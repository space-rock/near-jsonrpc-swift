import json
import os
import hashlib
from typing import Any, Dict, List, Optional, Set, Tuple

OPENAPI_PATH = "./openapi.json"
OUTPUT_PATH = "../Sources/NearJsonRpcTypes/Types.swift"
METHODS_OUTPUT_PATH = "../Sources/NearJsonRpcClient/Methods.swift"

SWIFT_RESERVED_KEYWORDS = {
    "protocol", "class", "struct", "enum", "func", "var", "let", "if", "else", 
    "for", "while", "return", "break", "continue", "default", "case", "switch", 
    "import", "public", "private", "internal", "static", "final", "required", 
    "optional", "override", "super", "self", "init", "deinit", "nil", "true", 
    "false", "try", "throw", "throws", "catch", "as", "is", "in", "out", "inout"
}

ANYCODABLE_HELPER_CODE = """// MARK: - AnyCodable Helper
public struct AnyCodable: Codable, @unchecked Sendable {
    public let value: Any
    
    public init(_ value: Any) {
        self.value = value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if container.decodeNil() {
            value = NSNull()
        } else if let bool = try? container.decode(Bool.self) {
            value = bool
        } else if let int = try? container.decode(Int.self) {
            value = int
        } else if let double = try? container.decode(Double.self) {
            value = double
        } else if let string = try? container.decode(String.self) {
            value = string
        } else if let array = try? container.decode([AnyCodable].self) {
            value = array.map { $0.value }
        } else if let dictionary = try? container.decode([String: AnyCodable].self) {
            value = dictionary.mapValues { $0.value }
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode AnyCodable")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        if value is NSNull {
            try container.encodeNil()
        } else if let bool = value as? Bool {
            try container.encode(bool)
        } else if let int = value as? Int {
            try container.encode(int)
        } else if let double = value as? Double {
            try container.encode(double)
        } else if let string = value as? String {
            try container.encode(string)
        } else if let array = value as? [Any] {
            try container.encode(array.map(AnyCodable.init))
        } else if let dictionary = value as? [String: Any] {
            try container.encode(dictionary.mapValues(AnyCodable.init))
        } else {
            throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: [], debugDescription: "Cannot encode AnyCodable"))
        }
    }
}

// MARK: - AnyCodingKey Helper
/// A dynamic CodingKey that can represent any string key
struct AnyCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
    
    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}

"""

DECODING_DIAGNOSTICS_CODE = """// MARK: - Decoding Diagnostics Helpers
fileprivate func describeCodingKey(_ key: CodingKey) -> String {
    if let intValue = key.intValue {
        return "[\\(intValue)]"
    }
    let stringValue = key.stringValue
    return stringValue.isEmpty ? "\\\"\\\"" : stringValue
}

fileprivate func describeCodingPath(_ codingPath: [CodingKey]) -> String {
    guard !codingPath.isEmpty else { return "<root>" }
    var description = ""
    for key in codingPath {
        if let intValue = key.intValue {
            description += "[\\(intValue)]"
        } else {
            if !description.isEmpty {
                description += "."
            }
            description += key.stringValue
        }
    }
    return description
}

fileprivate func describeDecodingError(_ error: Error) -> String {
    if let decodingError = error as? DecodingError {
        switch decodingError {
        case .typeMismatch(_, let context):
            return "typeMismatch at \\(describeCodingPath(context.codingPath)): \\(context.debugDescription)"
        case .valueNotFound(_, let context):
            return "valueNotFound at \\(describeCodingPath(context.codingPath)): \\(context.debugDescription)"
        case .keyNotFound(let key, let context):
            return "keyNotFound for key '\\(describeCodingKey(key))' at \\(describeCodingPath(context.codingPath)): \\(context.debugDescription)"
        case .dataCorrupted(let context):
            return "dataCorrupted at \\(describeCodingPath(context.codingPath)): \\(context.debugDescription)"
        @unknown default:
            return "Unknown DecodingError: \\(decodingError)"
        }
    }
    return String(describing: error)
}

"""


def load_openapi() -> Dict[str, Any]:
    if not os.path.exists(OPENAPI_PATH):
        raise FileNotFoundError(f"{OPENAPI_PATH} not found")
    with open(OPENAPI_PATH, "r", encoding="utf-8") as f:
        return json.load(f)


def escape_swift_keyword(property_name: str) -> str:
    """Escape Swift reserved keywords by wrapping in backticks"""
    if property_name in SWIFT_RESERVED_KEYWORDS:
        return f"`{property_name}`"
    return property_name

def is_discriminator_field(prop_name: str, prop_schema: Dict[str, Any]) -> bool:
    """Check if a property is a discriminator field (single-value enum)"""
    # Check if this is a single-value enum used as a discriminator
    if "enum" in prop_schema and prop_schema.get("type") == "string":
        enum_values = prop_schema["enum"]
        if len(enum_values) == 1 and enum_values[0] is not None:
            # Common discriminator field names
            discriminator_patterns = ["type", "request_type", "changes_type", "kind"]
            return any(pattern in prop_name.lower() for pattern in discriminator_patterns)
    return False

def get_discriminator_enum_type(prop_name: str) -> str:
    """Get the enum type name for a discriminator field"""
    return to_swift_type_name(prop_name)

def process_property_for_struct(
    prop_name: str, 
    prop_schema: Dict[str, Any], 
    required: Set[str], 
    components: Dict[str, Any],
    context: str = "",
    generated_types: Optional[Set[str]] = None,
    inline_types: Optional[Dict[str, str]] = None
) -> Tuple[str, str, str, bool]:
    """
    Process a property for struct generation.
    Returns: (swift_prop_name, prop_type, property_line, needs_coding_key_mapping)
    """
    generated_types = generated_types or set()
    inline_types = inline_types or {}
    
    swift_prop_name = to_swift_property_name(prop_name)
    swift_prop_name = escape_swift_keyword(swift_prop_name)
    
    # Check if this is a discriminator field - if so, use the generated enum type
    if is_discriminator_field(prop_name, prop_schema):
        prop_type = get_discriminator_enum_type(prop_name)
    elif context and generated_types and inline_types:
        prop_type = get_swift_type(prop_schema, components, context=context, generated_types=generated_types, inline_types=inline_types)
    else:
        prop_type = get_swift_type(prop_schema, components)
    
    # Check if nullable or optional
    is_nullable = prop_schema.get("nullable", False)
    is_required = prop_name in required
    
    # Handle nullable in resolved refs
    if "$ref" in prop_schema and not is_nullable:
        ref_schema = resolve_ref_schema(prop_schema["$ref"], components.get("schemas", {}))
        if ref_schema and ref_schema.get("nullable", False):
            is_nullable = True
    
    # Make optional if not required or if nullable
    if not is_required or is_nullable:
        if not prop_type.endswith("?"):
            prop_type += "?"
    
    property_line = f"    public let {swift_prop_name}: {prop_type}\n"
    
    # Check if we need CodingKeys mapping
    clean_swift_prop = swift_prop_name.strip("`")
    needs_mapping = clean_swift_prop != prop_name
    
    return swift_prop_name, prop_type, property_line, needs_mapping

def generate_coding_keys_section(property_mappings: Dict[str, str], all_properties: Dict[str, Any]) -> str:
    """Generate CodingKeys enum section if needed
    
    Note: Since we use JSONDecoder.keyDecodingStrategy = .convertFromSnakeCase,
    we don't need to generate CodingKeys for standard snake_case to camelCase conversions.
    CodingKeys are only needed for special cases like escaped keywords.
    """
    # Since we're using convertFromSnakeCase, we don't need CodingKeys for snake_case conversions
    # Only generate if there are escaped keywords or other special cases
    return ""

def ensure_unique_type_name(name: str, generated_types: Set[str]) -> str:
    """Ensure a type name is unique by adding suffix if needed"""
    swift_name = to_swift_type_name(name)
    original_swift_name = swift_name
    
    if swift_name in generated_types:
        counter = 2
        while swift_name in generated_types:
            swift_name = f"{original_swift_name}{counter}"
            counter += 1
    
    return swift_name

def register_generated_type(swift_name: str, generated_types: Set[str]) -> bool:
    """Register a type as generated. Returns True if successfully added, False if already exists"""
    if swift_name in generated_types:
        return False
    generated_types.add(swift_name)
    return True


def to_swift_type_name(name: str) -> str:
    """Convert schema name to Swift type name (PascalCase)"""
    if not name:
        return name
    
    # Handle names with underscores - preserve existing casing of each part
    if "_" in name:
        parts = name.split("_")
        # Capitalize any lowercase parts (which are likely connecting words)
        processed_parts = []
        for part in parts:
            if part.islower():
                processed_parts.append(part.capitalize())
            else:
                processed_parts.append(part)
        return "".join(processed_parts)
    
    # Handle camelCase to PascalCase
    if name and name[0].islower():
        return name[0].upper() + name[1:]
    
    # Already PascalCase or simple name
    return name

def to_swift_property_name(name: str) -> str:
    """Convert property name to Swift property name (camelCase)"""
    if "_" in name:
        parts = name.split("_")

        def transform_part(part: str) -> str:
            if not part:
                return ""
            # Preserve specialized casing when digits are present (e.g. p2p -> P2P)
            if part.islower():
                if any(ch.isdigit() for ch in part):
                    digit_indices = [idx for idx, ch in enumerate(part) if ch.isdigit()]
                    if digit_indices:
                        has_letter_before = any(ch.isalpha() for ch in part[:digit_indices[0]])
                        has_letter_after = any(ch.isalpha() for ch in part[digit_indices[-1] + 1:])
                        if has_letter_before and has_letter_after:
                            return "".join(ch.upper() if ch.isalpha() else ch for ch in part)
                return part.capitalize()
            if part.isupper():
                return part
            return part[0].upper() + part[1:]

        first_part = parts[0].lower() if parts else ""
        transformed = [transform_part(part) for part in parts[1:]]
        return first_part + "".join(transformed)
    # Handle all caps (ID -> id, URL -> url)
    if name.isupper() and len(name) > 1:
        return name.lower()
    # Already camelCase or simple name
    return name[0].lower() + name[1:] if name else name

def resolve_ref_name(ref: str) -> Optional[str]:
    """Extract type name from $ref"""
    if not ref.startswith("#/components/schemas/"):
        return None
    return ref.split("/")[-1]

def resolve_ref_schema(ref: str, components: Dict[str, Any]) -> Optional[Dict[str, Any]]:
    """Resolve a $ref to its schema definition"""
    name = resolve_ref_name(ref)
    if name:
        return components.get(name)
    return None

def generate_schema_hash(schema: Dict[str, Any]) -> str:
    """Generate a short hash for a schema to create unique names"""
    schema_str = json.dumps(schema, sort_keys=True)
    return hashlib.md5(schema_str.encode()).hexdigest()[:8]

def generate_unique_type_name(base_name: str, schema: Dict[str, Any], context: str = "", generated_types: Set[str] = None) -> str:
    """Generate a unique type name for inline objects"""
    generated_types = generated_types or set()
    
    # Start with the base name
    candidate = to_swift_type_name(base_name)
    
    # Add context if provided
    if context:
        candidate = f"{to_swift_type_name(context)}{candidate}"
    
    # If it's unique, return it
    if candidate not in generated_types:
        return candidate
    
    # If not unique, add numeric suffix for better readability
    counter = 1
    final_candidate = f"{candidate}{counter}"
    while final_candidate in generated_types:
        counter += 1
        final_candidate = f"{candidate}{counter}"
    
    return final_candidate

def should_generate_inline_struct(schema: Dict[str, Any]) -> bool:
    """Determine if we should generate an inline struct for this schema"""
    if schema.get("type") != "object":
        return False
    
    # Must have properties to be worth generating
    properties = schema.get("properties", {})
    if not properties:
        return False
    
    # Don't generate for very simple objects (1-2 primitive properties)
    if len(properties) <= 2:
        all_primitive = True
        for prop_schema in properties.values():
            if not is_primitive_type(prop_schema):
                all_primitive = False
                break
        if all_primitive:
            return False
    
    return True

def is_primitive_type(schema: Dict[str, Any]) -> bool:
    """Check if a schema represents a primitive type"""
    if "$ref" in schema:
        return False  # References are not primitive
    
    schema_type = schema.get("type")
    if schema_type in ["string", "integer", "number", "boolean"]:
        return True
    
    if schema_type == "array":
        items = schema.get("items", {})
        return is_primitive_type(items)
    
    return False

def get_swift_primitive_type(schema: Dict[str, Any], components: Dict[str, Any], seen_refs: Optional[Set[str]] = None, context: str = "", generated_types: Optional[Set[str]] = None, inline_types: Optional[Dict[str, str]] = None) -> str:
    """Map OpenAPI primitive types to Swift types"""
    seen_refs = seen_refs or set()
    generated_types = generated_types or set()
    inline_types = inline_types or {}
    
    typ = schema.get("type")
    fmt = schema.get("format", "")
    
    # Handle refs first
    if "$ref" in schema:
        ref = schema["$ref"]
        if ref in seen_refs:
            ref_name = resolve_ref_name(ref)
            if ref_name:
                return to_swift_type_name(ref_name)
            return "Any"
        seen_refs.add(ref)
        ref_name = resolve_ref_name(ref)
        if ref_name:
            return to_swift_type_name(ref_name)
        return "Any"
    
    if typ == "string":
        if fmt == "byte":
            return "Data"
        elif fmt == "binary":
            return "Data"
        elif fmt == "uuid":
            return "UUID"
        elif fmt == "uint64":
            return "UInt64"
        return "String"
    elif typ == "integer":
        if fmt == "int32":
            return "Int32"
        elif fmt == "int64":
            return "Int64"
        elif fmt == "uint64":
            return "UInt64"
        return "Int"
    elif typ == "number":
        if fmt == "float":
            return "Float"
        elif fmt == "double":
            return "Double"
        return "Double"
    elif typ == "boolean":
        return "Bool"
    elif typ == "array":
        items = schema.get("items", {})
        items_type = get_swift_type(items, components, seen_refs, context, generated_types, inline_types)
        return f"[{items_type}]"
    elif typ == "object":
        # For inline objects with properties, try to generate specific types
        if "properties" in schema and should_generate_inline_struct(schema):
            # Generate a unique name for this inline object
            schema_key = json.dumps(schema, sort_keys=True)
            if schema_key in inline_types:
                return inline_types[schema_key]
            
            type_name = generate_unique_type_name("InlineObject", schema, context, generated_types)
            inline_types[schema_key] = type_name
            generated_types.add(type_name)
            
            # Generate the struct code and store it for later output
            struct_code = generate_inline_object_struct(type_name, schema, components, generated_types, inline_types)
            # Store the struct code in a global registry (we'll need to modify the main function to handle this)
            if not hasattr(get_swift_primitive_type, '_inline_structs'):
                get_swift_primitive_type._inline_structs = {}
            get_swift_primitive_type._inline_structs[type_name] = struct_code
            
            return type_name
        
        # For objects with additionalProperties, use dictionary
        elif "additionalProperties" in schema and "properties" not in schema:
            if isinstance(schema["additionalProperties"], dict):
                value_type = get_swift_type(schema["additionalProperties"], components, seen_refs, context, generated_types, inline_types)
                return f"[String: {value_type}]"
            else:
                return "AnyCodable"  # Use AnyCodable for arbitrary objects
        
        # Fallback to generic dictionary
        return "AnyCodable"  # Use a custom AnyCodable type instead of [String: Any]
    
    # For empty schemas or unknown types, use AnyCodable instead of Any
    # because Any is not Codable in Swift
    return "AnyCodable"

def get_swift_type(schema: Dict[str, Any], components: Dict[str, Any], seen_refs: Optional[Set[str]] = None, context: str = "", generated_types: Optional[Set[str]] = None, inline_types: Optional[Dict[str, str]] = None) -> str:
    """Get Swift type for a schema"""
    seen_refs = seen_refs or set()
    generated_types = generated_types or set()
    inline_types = inline_types or {}
    
    if "$ref" in schema:
        ref = schema["$ref"]
        if ref in seen_refs:
            ref_name = resolve_ref_name(ref)
            if ref_name:
                return to_swift_type_name(ref_name)
            return "Any"
        seen_refs.add(ref)
        ref_name = resolve_ref_name(ref)
        if ref_name:
            return to_swift_type_name(ref_name)
        return "Any"
    
    if "enum" in schema:
        # For simple enums, use the primitive type
        return get_swift_primitive_type(schema, components, seen_refs, context, generated_types, inline_types)
    
    if "allOf" in schema:
        # For allOf, try to find the main type
        for item in schema["allOf"]:
            if "$ref" in item:
                ref_name = resolve_ref_name(item["$ref"])
                if ref_name:
                    return to_swift_type_name(ref_name)
        # If no ref found, might be a composite type
        return get_swift_primitive_type(schema, components, seen_refs, context, generated_types, inline_types)
    
    if "oneOf" in schema or "anyOf" in schema:
        # For oneOf/anyOf, we'd need to create an enum with associated values
        # For now, use Any
        choices = schema.get("oneOf") or schema.get("anyOf")
        if choices and len(choices) == 2:
            # Special case: nullable type (one option is null)
            for choice in choices:
                if choice.get("type") == "null":
                    continue
                return get_swift_type(choice, components, seen_refs, context, generated_types, inline_types) + "?"
        return "Any"
    
    return get_swift_primitive_type(schema, components, seen_refs, context, generated_types, inline_types)

def generate_swift_enum(name: str, schema: Dict[str, Any]) -> str:
    """Generate Swift enum for schemas with enum values"""
    swift_name = to_swift_type_name(name)
    enum_values = schema.get("enum", [])
    typ = schema.get("type", "string")
    is_nullable = schema.get("nullable", False)
    
    if not enum_values:
        return ""
    
    # Handle the special case of nullable enum with only null value
    if len(enum_values) == 1 and enum_values[0] is None and is_nullable:
        # This represents a null-only type, generate a type that encodes to null
        return f"""public struct {swift_name}: Codable, Sendable {{
    public init() {{}}
    
    public init(from decoder: Decoder) throws {{
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {{
            throw DecodingError.typeMismatch({swift_name}.self, DecodingError.Context(codingPath: [], debugDescription: "Expected null"))
        }}
    }}
    
    public func encode(to encoder: Encoder) throws {{
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }}
}}
"""
    
    # Filter out null values for enum generation
    non_null_values = [v for v in enum_values if v is not None]
    
    if not non_null_values:
        # All values are null - generate a type that encodes to null
        return f"""public struct {swift_name}: Codable, Sendable {{
    public init() {{}}
    
    public init(from decoder: Decoder) throws {{
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {{
            throw DecodingError.typeMismatch({swift_name}.self, DecodingError.Context(codingPath: [], debugDescription: "Expected null"))
        }}
    }}
    
    public func encode(to encoder: Encoder) throws {{
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }}
}}
"""
    
    if typ == "string":
        swift_type = "String"
    elif typ == "integer":
        swift_type = "Int"
    else:
        swift_type = "String"
    
    code = f"public enum {swift_name}: {swift_type}, Codable"
    
    # Add Sendable if it's a simple enum
    code += ", Sendable"
    
    code += " {\n"
    
    seen_cases = set()
    for value in non_null_values:
        if value is None:
            continue
        if typ == "string":
            # Convert to valid Swift case name
            case_name = str(value).replace("-", "_").replace(" ", "_").replace(".", "_").replace("/", "_").replace("@", "_")
            case_name = to_swift_property_name(case_name)
            
            # Ensure case name starts with a letter
            if case_name and case_name[0].isdigit():
                case_name = "val" + case_name
            
            # Avoid duplicate case names
            original_case = case_name
            counter = 1
            while case_name in seen_cases:
                case_name = f"{original_case}{counter}"
                counter += 1
            seen_cases.add(case_name)
            
            if case_name != value:
                code += f'    case {case_name} = "{value}"\n'
            else:
                code += f'    case {case_name}\n'
        else:
            case_name = f"val{value}"
            # Ensure no duplicates
            original_case = case_name
            counter = 1
            while case_name in seen_cases:
                case_name = f"{original_case}{counter}"
                counter += 1
            seen_cases.add(case_name)
            code += f'    case {case_name} = {value}\n'
    
    code += "}\n"
    return code

def merge_allof_for_swift(allof_list: List[Dict[str, Any]], components: Dict[str, Any]) -> Dict[str, Any]:
    """Merge allOf schemas for Swift generation"""
    merged = {"type": "object", "properties": {}, "required": []}
    
    for item in allof_list:
        if "$ref" in item:
            resolved = resolve_ref_schema(item["$ref"], components)
            if resolved:
                if "properties" in resolved:
                    merged["properties"].update(resolved["properties"])
                if "required" in resolved:
                    merged["required"].extend(resolved["required"])
                if "type" in resolved and "type" not in merged:
                    merged["type"] = resolved["type"]
        
        if "properties" in item:
            merged["properties"].update(item["properties"])
        if "required" in item:
            merged["required"].extend(item["required"])
        if "type" in item and "type" not in merged:
            merged["type"] = item["type"]
    
    # Remove duplicates from required
    merged["required"] = list(dict.fromkeys(merged["required"]))
    return merged

def generate_swift_struct(name: str, schema: Dict[str, Any], components: Dict[str, Any], generated_types: Set[str], inline_types: Optional[Dict[str, str]] = None) -> str:
    """Generate Swift struct for object schemas"""
    inline_types = inline_types or {}
    swift_name = ensure_unique_type_name(name, generated_types)
    
    # Skip if already generated
    if not register_generated_type(swift_name, generated_types):
        return ""
    
    # Handle allOf by merging schemas
    if "allOf" in schema:
        schema = merge_allof_for_swift(schema["allOf"], components)
    
    # Handle oneOf/anyOf as enums with associated values
    if "oneOf" in schema or "anyOf" in schema:
        return generate_swift_enum_with_associated_values(name, schema, components, generated_types, inline_types)[1] + generate_swift_enum_with_associated_values(name, schema, components, generated_types, inline_types)[0]
    
    properties = schema.get("properties", {})
    required = set(schema.get("required", []))
    
    # If no properties but has additionalProperties, generate a typealias
    if not properties and "additionalProperties" in schema:
        if isinstance(schema["additionalProperties"], dict):
            value_type = get_swift_type(schema["additionalProperties"], components)
        else:
            value_type = "Any"
        return f"public typealias {swift_name} = [String: {value_type}]\n"
    
    code = f"public struct {swift_name}: Codable, Sendable {{\n"
    
    # Generate properties using helper function
    property_mappings = {}
    property_info = []  # Store property info for initializer
    for prop_name, prop_schema in properties.items():
        swift_prop_name, prop_type, property_line, needs_mapping = process_property_for_struct(
            prop_name, prop_schema, required, components
        )
        code += property_line
        property_info.append((swift_prop_name, prop_type))
        
        if needs_mapping:
            property_mappings[prop_name] = prop_name
    
    # Generate public initializer
    if properties:
        # Struct with properties - generate parameterized initializer
        code += "\n    public init(\n"
        init_params = []
        for swift_prop_name, prop_type in property_info:
            clean_name = swift_prop_name.strip("`")
            init_params.append(f"        {clean_name}: {prop_type}")
        
        code += ",\n".join(init_params)
        code += "\n    ) {\n"
        
        for swift_prop_name, _ in property_info:
            clean_name = swift_prop_name.strip("`")
            code += f"        self.{clean_name} = {clean_name}\n"
        
        code += "    }\n"
    else:
        # Empty struct - generate empty public initializer
        code += "\n    public init() {}\n"
    
    # Add CodingKeys if any property names need mapping
    code += generate_coding_keys_section(property_mappings, properties)
    
    code += "}\n"
    return code

def analyze_oneof_variant(variant: Dict[str, Any], components: Dict[str, Any], context: str = "", generated_types: Optional[Set[str]] = None) -> Tuple[str, str, bool, bool]:
    """
    Analyze a oneOf variant to determine the case name, type, and if it needs inline struct
    Returns: (case_name, type_name, needs_inline_struct, is_wrapped_object)
    """
    generated_types = generated_types or set()
    
    # Handle direct enum values - these should be raw value enums, not associated values
    if "enum" in variant and len(variant["enum"]) == 1:
        enum_value = variant["enum"][0]
        case_name = to_swift_property_name(str(enum_value).replace("-", "_").replace(".", "_"))
        # Return a special marker to indicate this is a literal enum value
        return case_name, f'LITERAL:{enum_value}', False, False
    
    # Handle simple types
    if variant.get("type") in ["string", "integer", "number", "boolean", "array"] and "properties" not in variant:
        type_name = get_swift_primitive_type(variant, components)
        case_name = variant.get("type", "value").lower()
        return case_name, type_name, False, False
    
    # Handle $ref
    if "$ref" in variant:
        ref_name = resolve_ref_name(variant["$ref"])
        if ref_name:
            case_name = to_swift_property_name(ref_name)
            type_name = to_swift_type_name(ref_name)
            return case_name, type_name, False, False
    
    # Handle allOf schemas (merge multiple objects)
    if "allOf" in variant:
        merged_schema = merge_allof_for_swift(variant["allOf"], components)
        
        # Use the title if available, otherwise generate a name
        if "title" in variant:
            case_name = to_swift_property_name(variant["title"])
            type_name = to_swift_type_name(variant["title"])
        else:
            # Generate name based on merged properties
            properties = merged_schema.get("properties", {})
            if properties:
                prop_names = sorted(properties.keys())[:3]
                pascal_prop_names = [to_swift_type_name(name) for name in prop_names]
                base_name = "OneOf" + "".join(pascal_prop_names)
                if len(properties) > 3:
                    base_name += "Etc"
                type_name = generate_unique_type_name(base_name, merged_schema, context, generated_types)
                case_name = to_swift_property_name(type_name.replace("OneOf", ""))
            else:
                case_name = "mergedVariant"
                type_name = "AnyCodable"
        
        return case_name, type_name, True, False
    
    # Handle anyOf schemas (especially nullable references)
    if "anyOf" in variant:
        choices = variant["anyOf"]
        
        # Check for nullable reference pattern
        if len(choices) == 2:
            ref_choice = None
            null_choice = None
            
            for choice in choices:
                if "$ref" in choice:
                    ref_choice = choice
                elif choice.get("enum") == [None] and choice.get("nullable"):
                    null_choice = choice
            
            if ref_choice and null_choice:
                ref_name = resolve_ref_name(ref_choice["$ref"])
                if ref_name:
                    case_name = to_swift_property_name(ref_name)
                    # Check if the referenced type is already nullable
                    ref_schema = resolve_ref_schema(ref_choice["$ref"], components)
                    if ref_schema and ref_schema.get("enum") == [None] and ref_schema.get("nullable"):
                        type_name = to_swift_type_name(ref_name)  # Use the actual type name
                    else:
                        type_name = f"{to_swift_type_name(ref_name)}?"
                    return case_name, type_name, False, False
        
        # Fallback for complex anyOf - use first non-null choice
        for choice in choices:
            if choice.get("enum") != [None]:
                return analyze_oneof_variant(choice, components, context, generated_types)
    
    # Handle objects with properties
    if variant.get("type") == "object" and "properties" in variant:
        properties = variant["properties"]
        required = set(variant.get("required", []))
        
        # Check if this is a wrapped object pattern (single property with $ref)
        if len(properties) == 1:
            prop_name = list(properties.keys())[0]
            # Use proper PascalCase for the property name
            case_name = to_swift_property_name(prop_name)
            prop_schema = properties[prop_name]
            
            # Handle anyOf in property (like nullable references)
            if "anyOf" in prop_schema:
                choices = prop_schema["anyOf"]
                if len(choices) == 2:
                    ref_choice = None
                    null_choice = None
                    
                    for choice in choices:
                        if "$ref" in choice:
                            ref_choice = choice
                        elif choice.get("enum") == [None] and choice.get("nullable"):
                            null_choice = choice
                    
                    if ref_choice and null_choice:
                        ref_name = resolve_ref_name(ref_choice["$ref"])
                        if ref_name:
                            # Check if the referenced type is already nullable
                            ref_schema = resolve_ref_schema(ref_choice["$ref"], components)
                            if ref_schema and ref_schema.get("enum") == [None] and ref_schema.get("nullable"):
                                type_name = to_swift_type_name(ref_name)  # Use the actual type name
                            else:
                                type_name = f"{to_swift_type_name(ref_name)}?"
                            return case_name, type_name, False, True  # is_wrapped_object = True
            
            # If it's a reference, this is a wrapped object
            if "$ref" in prop_schema:
                ref_name = resolve_ref_name(prop_schema["$ref"])
                if ref_name:
                    type_name = to_swift_type_name(ref_name)
                    return case_name, type_name, False, True  # is_wrapped_object = True
            
            # If it's an inline object, we need to create a struct for it
            if prop_schema.get("type") == "object" and "properties" in prop_schema:
                # Use the property name in PascalCase for better naming
                pascal_prop_name = to_swift_type_name(prop_name)
                type_name = generate_unique_type_name(f"OneOf{pascal_prop_name}Inline", prop_schema, context, generated_types)
                return case_name, type_name, True, True  # Both inline and wrapped
            
            # Otherwise, get the type directly - this is still wrapped
            prop_type = get_swift_primitive_type(prop_schema, components)
            return case_name, prop_type, False, True
        else:
            # Multiple properties - create a struct name based on schema content
            # Use title if available
            if "title" in variant:
                case_name = to_swift_property_name(variant["title"])
                type_name = to_swift_type_name(variant["title"])
            else:
                # Generate a more descriptive name using property names and schema hash
                prop_names = sorted(properties.keys())[:3]  # Use first 3 property names
                # Convert each property name to PascalCase and concatenate
                pascal_prop_names = [to_swift_type_name(name) for name in prop_names]
                base_name = "OneOf" + "".join(pascal_prop_names)
                if len(properties) > 3:
                    base_name += "Etc"
                
                type_name = generate_unique_type_name(base_name, variant, context, generated_types)
                # Add the generated type name to the set to ensure future variants get unique names
                if generated_types is not None:
                    generated_types.add(type_name)
                case_name = to_swift_property_name(type_name.replace("OneOf", ""))
            
            return case_name, type_name, True, False
    
    # Fallback
    case_name = "unknownVariant"
    type_name = "Any"
    return case_name, type_name, False, False

def generate_inline_object_struct(type_name: str, schema: Dict[str, Any], components: Dict[str, Any], generated_types: Optional[Set[str]] = None, inline_types: Optional[Dict[str, str]] = None) -> str:
    """Generate a struct for an inline object schema"""
    generated_types = generated_types or set()
    inline_types = inline_types or {}
    properties = schema.get("properties", {})
    required = set(schema.get("required", []))
    
    code = f"public struct {type_name}: Codable, Sendable {{\n"
    
    # Generate properties using helper function
    property_mappings = {}
    property_info = []  # Store property info for initializer
    for prop_name, prop_schema in properties.items():
        swift_prop_name, prop_type, property_line, needs_mapping = process_property_for_struct(
            prop_name, prop_schema, required, components, type_name, generated_types, inline_types
        )
        code += property_line
        property_info.append((swift_prop_name, prop_type))
        
        if needs_mapping:
            property_mappings[prop_name] = prop_name
    
    # Generate public initializer
    if properties:
        # Struct with properties - generate parameterized initializer
        code += "\n    public init(\n"
        init_params = []
        for swift_prop_name, prop_type in property_info:
            clean_name = swift_prop_name.strip("`")
            init_params.append(f"        {clean_name}: {prop_type}")
        
        code += ",\n".join(init_params)
        code += "\n    ) {\n"
        
        for swift_prop_name, _ in property_info:
            clean_name = swift_prop_name.strip("`")
            code += f"        self.{clean_name} = {clean_name}\n"
        
        code += "    }\n"
    else:
        # Empty struct - generate empty public initializer
        code += "\n    public init() {}\n"
    
    # Add CodingKeys if any property names need mapping
    code += generate_coding_keys_section(property_mappings, properties)
    
    code += "}\n\n"
    return code

def generate_swift_enum_with_associated_values(name: str, schema: Dict[str, Any], components: Dict[str, Any], generated_types: Set[str], inline_types: Optional[Dict[str, str]] = None) -> Tuple[str, str]:
    """
    Generate Swift enum with associated values for oneOf/anyOf schemas
    Returns: (main_enum_code, inline_structs_code)
    """
    inline_types = inline_types or {}
    swift_name = to_swift_type_name(name)
    choices = schema.get("oneOf") or schema.get("anyOf", [])
    
    if not choices:
        return "", ""
    
    # Check if this is just a nullable type
    if len(choices) == 2:
        null_count = sum(1 for choice in choices if choice.get("type") == "null")
        if null_count == 1:
            # This is just a nullable type, not a real union
            return "", ""
    
    # Analyze variants
    variants = []
    inline_structs = ""
    inline_structs_generated = set()  # Track generated inline struct names
    
    for choice in choices:
        case_name, type_name, needs_inline, is_wrapped = analyze_oneof_variant(choice, components, swift_name, generated_types)
        variants.append((case_name, type_name, choice, is_wrapped))
        
        if needs_inline and type_name not in inline_structs_generated:
            inline_struct_code = generate_oneof_inline_struct(case_name, type_name, choice, components, generated_types, inline_types)
            inline_structs += inline_struct_code
            inline_structs_generated.add(type_name)

    # Determine whether we ever append decoding errors (used to silence Swift warnings)
    collects_decoding_errors = False
    for _, type_name, choice, is_wrapped in variants:
        if type_name.startswith('LITERAL:'):
            continue
        if is_wrapped:
            properties = choice.get("properties", {})
            if properties:
                collects_decoding_errors = True
                break
        else:
            collects_decoding_errors = True
            break
    
    # Generate the main enum
    code = f"public enum {swift_name}: Codable, Sendable {{\n"
    
    # Generate cases
    case_names_used = set()
    literal_cases = []  # Store cases that are literal enum values
    for case_name, type_name, _, _ in variants:
        # Avoid duplicate case names
        original_case = case_name
        counter = 1
        while case_name in case_names_used:
            case_name = f"{original_case}{counter}"
            counter += 1
        case_names_used.add(case_name)
        
        # Check if this is a literal enum value
        if type_name.startswith('LITERAL:'):
            literal_value = type_name[8:]  # Remove 'LITERAL:' prefix
            literal_cases.append((case_name, literal_value))
            code += f"    case {case_name}\n"
        else:
            code += f"    case {case_name}({type_name})\n"
    
    # Add Codable implementation
    code += "\n    public init(from decoder: Decoder) throws {\n"
    if collects_decoding_errors:
        code += "        var decodingErrors: [String] = []\n"
    else:
        code += "        let decodingErrors: [String] = []\n"
    code += "        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)\n"
    
    # Generate decoding attempts
    case_names_used = set()
    for case_name, type_name, choice, is_wrapped in variants:
        # Ensure consistent case name
        original_case = case_name
        counter = 1
        while case_name in case_names_used:
            case_name = f"{original_case}{counter}"
            counter += 1
        case_names_used.add(case_name)
        
        # Handle special case for literal string values (enum values)
        if type_name.startswith('LITERAL:'):
            literal_value = type_name[8:]  # Remove 'LITERAL:' prefix
            code += f'        if let value = try? decoder.singleValueContainer().decode(String.self), value == "{literal_value}" {{\n'
            code += f'            self = .{case_name}\n'
            code += f"            return\n"
            code += f"        }}\n"
        elif is_wrapped:
            # For wrapped objects, decode using raw keys via AnyCodingKey to avoid keyDecodingStrategy side effects
            properties = choice.get("properties", {})
            if properties:
                prop_name = list(properties.keys())[0]  # Wrapper property key as it appears in JSON
                candidate_keys = [prop_name]
                swift_prop_variant = to_swift_property_name(prop_name)
                if swift_prop_variant and swift_prop_variant not in candidate_keys:
                    candidate_keys.append(swift_prop_variant)
                lowercase_variant = prop_name[:1].lower() + prop_name[1:]
                if lowercase_variant and lowercase_variant not in candidate_keys:
                    candidate_keys.append(lowercase_variant)
                unique_candidates: List[str] = []
                seen_candidates: Set[str] = set()
                for candidate in candidate_keys:
                    lowered = candidate.lower()
                    if lowered in seen_candidates:
                        continue
                    seen_candidates.add(lowered)
                    unique_candidates.append(candidate)
                candidate_condition = " || ".join([f'key.stringValue.caseInsensitiveCompare("{candidate}") == .orderedSame' for candidate in unique_candidates])
                code += f"        do {{\n"
                code += f"            if let container = anyKeyContainer {{\n"
                code += f"                if let matchingKey = container.allKeys.first(where: {{ key in {candidate_condition} }}) {{\n"
                code += f"                    let value = try container.decode({type_name}.self, forKey: matchingKey)\n"
                code += f"                    self = .{case_name}(value)\n"
                code += f"                    return\n"
                code += f"                }}\n"
                code += f"            }}\n"
                code += f"        }} catch let error {{\n"
                code += f"            decodingErrors.append(\".{case_name}: \\(describeDecodingError(error))\")\n"
                code += f"        }}\n"
        else:
            # For direct values, use singleValueContainer
            code += f"        do {{\n"
            code += f"            let value = try decoder.singleValueContainer().decode({type_name}.self)\n"
            code += f"            self = .{case_name}(value)\n"
            code += f"            return\n"
            code += f"        }} catch let error {{\n"
            code += f"            decodingErrors.append(\".{case_name}: \\(describeDecodingError(error))\")\n"
            code += f"        }}\n"
    
    code += "        let contextDescription: String\n"
    code += "        if decodingErrors.isEmpty {\n"
    code += "            let availableKeys: String\n"
    code += "            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {\n"
    code += "                let joined = keys.map { \"\\($0.stringValue)\" }.joined(separator: \", \")\n"
    code += f"                availableKeys = \" Available keys: [\\(joined)]\"\n"
    code += "            } else {\n"
    code += "                availableKeys = \"\"\n"
    code += "            }\n"
    code += f"            contextDescription = \"Could not decode any of the oneOf/anyOf variants for {swift_name}\\(availableKeys)\"\n"
    code += "        } else {\n"
    code += f"            contextDescription = \"Could not decode any of the oneOf/anyOf variants for {swift_name}:\\n\" + decodingErrors.joined(separator: \"\\n\")\n"
    code += "        }\n"
    code += "        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))\n"
    code += "    }\n"
    
    # Add CodingKeys if we have wrapped objects that need explicit mapping
    # (i.e., not simple snake_case conversions that convertFromSnakeCase handles)
    has_wrapped = any(is_wrapped for _, _, _, is_wrapped in variants)
    if has_wrapped:
        # Collect properties that need explicit CodingKeys
        needs_coding_keys = {}
        for case_name, type_name, choice, is_wrapped in variants:
            if is_wrapped:
                properties = choice.get("properties", {})
                if properties:
                    prop_name = list(properties.keys())[0]
                    swift_prop_name = to_swift_property_name(prop_name)
                    
                    # Check if this is a simple snake_case conversion
                    # convertFromSnakeCase handles: "chunk_id" -> "chunkId", "block_id" -> "blockId"
                    if "_" in prop_name:
                        # This is snake_case, convertFromSnakeCase will handle it
                        continue
                    
                    # Not snake_case, needs explicit mapping (e.g., "FunctionCall", "result")
                    if swift_prop_name not in needs_coding_keys:
                        needs_coding_keys[swift_prop_name] = prop_name
        
        # Only generate CodingKeys if there are properties that need explicit mapping
        if needs_coding_keys:
            code += "\n    enum CodingKeys: String, CodingKey {\n"
            for swift_prop_name, prop_name in needs_coding_keys.items():
                if swift_prop_name != prop_name:
                    code += f'        case {swift_prop_name} = "{prop_name}"\n'
                else:
                    code += f'        case {swift_prop_name}\n'
            code += "    }\n"
    
    code += "\n    public func encode(to encoder: Encoder) throws {\n"
    
    # Generate encoding cases
    case_names_used = set()
    wrapped_cases = []
    direct_cases = []
    literal_cases = []
    
    for case_name, type_name, choice, is_wrapped in variants:
        # Ensure consistent case name
        original_case = case_name
        counter = 1
        while case_name in case_names_used:
            case_name = f"{original_case}{counter}"
            counter += 1
        case_names_used.add(case_name)
        
        if type_name.startswith('LITERAL:'):
            literal_value = type_name[8:]  # Remove 'LITERAL:' prefix
            literal_cases.append((case_name, literal_value))
        elif is_wrapped:
            properties = choice.get("properties", {})
            if properties:
                prop_name = list(properties.keys())[0]
                wrapped_cases.append((case_name, prop_name))
        else:
            direct_cases.append(case_name)
    
    if wrapped_cases:
        code += "        switch self {\n"
        for case_name, prop_name in wrapped_cases:
            swift_prop_name = to_swift_property_name(prop_name)
            code += f"        case .{case_name}(let value):\n"
            
            # Check if this property needs CodingKeys or if it's snake_case
            if "_" in prop_name:
                # Snake_case property - encode directly with the original key name
                # The encoder will NOT convert it automatically, so we use a custom key
                code += f"            var container = encoder.container(keyedBy: AnyCodingKey.self)\n"
                code += f'            try container.encode(value, forKey: AnyCodingKey(stringValue: "{prop_name}"))\n'
            else:
                # Non-snake_case property - use CodingKeys
                code += f"            var container = encoder.container(keyedBy: CodingKeys.self)\n"
                code += f"            try container.encode(value, forKey: .{swift_prop_name})\n"
        for case_name in direct_cases:
            code += f"        case .{case_name}(let value):\n"
            code += f"            var singleContainer = encoder.singleValueContainer()\n"
            code += f"            try singleContainer.encode(value)\n"
        for case_name, literal_value in literal_cases:
            code += f"        case .{case_name}:\n"
            code += f"            var singleContainer = encoder.singleValueContainer()\n"
            code += f'            try singleContainer.encode("{literal_value}")\n'
        code += "        }\n"
    else:
        code += "        switch self {\n"
        for case_name in direct_cases:
            code += f"        case .{case_name}(let value):\n"
            code += f"            var container = encoder.singleValueContainer()\n"
            code += f"            try container.encode(value)\n"
        for case_name, literal_value in literal_cases:
            code += f"        case .{case_name}:\n"
            code += f"            var container = encoder.singleValueContainer()\n"
            code += f'            try container.encode("{literal_value}")\n'
        code += "        }\n"
    
    code += "    }\n"
    code += "}\n"
    
    return code, inline_structs


_global_inline_struct_schemas = {}


def generate_oneof_inline_struct(case_name: str, type_name: str, variant: Dict[str, Any], components: Dict[str, Any], generated_types: Optional[Set[str]] = None, inline_types: Optional[Dict[str, str]] = None) -> str:
    """Generate an inline struct for oneOf variants that need it"""
    global _global_inline_struct_schemas
    
    generated_types = generated_types or set()
    inline_types = inline_types or {}
    
    # Handle allOf variants by merging schemas first
    if "allOf" in variant:
        variant = merge_allof_for_swift(variant["allOf"], components)
    
    if variant.get("type") != "object" or "properties" not in variant:
        return ""
    
    # Check if we've already generated a struct with this exact type_name
    # Use type_name instead of schema content for deduplication
    # This ensures that variants with the same property names but different types
    # get their own structs
    if type_name in _global_inline_struct_schemas:
        # Return empty string - this struct has already been generated
        return ""
    
    properties = variant["properties"]
    required = set(variant.get("required", []))
    
    # Handle the special case where we have a single property that is itself an inline object
    if len(properties) == 1 and type_name.endswith("Inline"):
        prop_name = list(properties.keys())[0]
        prop_schema = properties[prop_name]
        if prop_schema.get("type") == "object" and "properties" in prop_schema:
            # Generate struct for the inline object inside the property
            return generate_inline_object_struct(type_name, prop_schema, components, generated_types, inline_types)
    
    # Register this type_name as being generated
    _global_inline_struct_schemas[type_name] = type_name
    
    # Regular multi-property struct
    code = f"public struct {type_name}: Codable, Sendable {{\n"
    
    # Generate properties using helper function
    property_mappings = {}
    property_info = []  # Store property info for initializer
    for prop_name, prop_schema in properties.items():
        swift_prop_name, prop_type, property_line, needs_mapping = process_property_for_struct(
            prop_name, prop_schema, required, components
        )
        code += property_line
        property_info.append((swift_prop_name, prop_type))
        
        if needs_mapping:
            property_mappings[prop_name] = prop_name
    
    # Generate public initializer
    if properties:
        # Struct with properties - generate parameterized initializer
        code += "\n    public init(\n"
        init_params = []
        for swift_prop_name, prop_type in property_info:
            clean_name = swift_prop_name.strip("`")
            init_params.append(f"        {clean_name}: {prop_type}")
        
        code += ",\n".join(init_params)
        code += "\n    ) {\n"
        
        for swift_prop_name, _ in property_info:
            clean_name = swift_prop_name.strip("`")
            code += f"        self.{clean_name} = {clean_name}\n"
        
        code += "    }\n"
    else:
        # Empty struct - generate empty public initializer
        code += "\n    public init() {}\n"
    
    # Add CodingKeys if any property names need mapping
    code += generate_coding_keys_section(property_mappings, properties)
    
    code += "}\n\n"
    return code

def generate_swift_type_alias(name: str, schema: Dict[str, Any], components: Dict[str, Any]) -> str:
    """Generate type alias for simple types or references"""
    swift_name = to_swift_type_name(name)
    
    # Don't create redundant type aliases for direct references
    if "$ref" in schema and len(schema) == 1:
        ref_name = resolve_ref_name(schema["$ref"])
        if ref_name:
            ref_swift_name = to_swift_type_name(ref_name)
            if swift_name != ref_swift_name:
                return f"public typealias {swift_name} = {ref_swift_name}\n"
        return ""
    
    base_type = get_swift_type(schema, components)
    
    # Don't create type alias if it would be the same as the name
    if base_type == swift_name:
        return ""
    
    return f"public typealias {swift_name} = {base_type}\n"

def generate_swift_for_schema(name: str, schema: Dict[str, Any], components: Dict[str, Any], generated_types: Set[str], inline_types: Optional[Dict[str, str]] = None) -> str:
    """Generate Swift code for a single schema"""
    inline_types = inline_types or {}
    swift_name = to_swift_type_name(name)
    
    # Skip if already generated - but handle duplicates by adding suffix
    original_swift_name = swift_name
    if swift_name in generated_types:
        # Check if this is the same schema as the already generated one
        # For duplicates with different schema content, add a suffix
        counter = 2
        while swift_name in generated_types:
            swift_name = f"{original_swift_name}{counter}"
            counter += 1
    
    # Handle different schema types
    if "enum" in schema and not ("oneOf" in schema or "anyOf" in schema):
        code = generate_swift_enum(name, schema)
        if code:
            generated_types.add(swift_name)
        return code
    elif "oneOf" in schema or "anyOf" in schema:
        enum_code, inline_structs = generate_swift_enum_with_associated_values(name, schema, components, generated_types, inline_types)
        if enum_code:
            generated_types.add(swift_name)
        return inline_structs + enum_code
    elif "allOf" in schema:
        # Check if allOf contains only a single $ref - this should be a type alias
        allof_items = schema["allOf"]
        if len(allof_items) == 1 and "$ref" in allof_items[0] and len(allof_items[0]) == 1:
            # Simple allOf with single reference - create type alias
            ref_schema = {"$ref": allof_items[0]["$ref"]}
            return generate_swift_type_alias(name, ref_schema, components)
        else:
            # Complex allOf - treat as struct
            return generate_swift_struct(name, schema, components, generated_types, inline_types)
    elif schema.get("type") == "object" or "properties" in schema:
        return generate_swift_struct(name, schema, components, generated_types, inline_types)
    elif "$ref" in schema and len(schema) == 1:
        # Pure reference - might need type alias
        return generate_swift_type_alias(name, schema, components)
    elif schema.get("type") in ["string", "integer", "number", "boolean", "array"]:
        # Simple types - create type alias if it adds value
        alias = generate_swift_type_alias(name, schema, components)
        if alias:
            generated_types.add(swift_name)
        return alias
    else:
        # Default to struct for complex types
        return generate_swift_struct(name, schema, components, generated_types)


def resolve_schema(schema: Optional[Dict[str, Any]], components: Dict[str, Any]) -> Optional[Dict[str, Any]]:
    """Resolve a schema, following $ref pointers."""
    if schema is None:
        return None
    if "$ref" in schema:
        return resolve_ref_schema(schema["$ref"], components)
    return schema


def is_null_schema(schema: Optional[Dict[str, Any]]) -> bool:
    """Check whether a schema represents a null literal."""
    if not schema:
        return False
    if schema.get("type") == "null":
        return True
    enum_values = schema.get("enum")
    if enum_values and all(value is None for value in enum_values):
        return True
    return False


def schema_to_swift_type_name(schema: Optional[Dict[str, Any]], components: Dict[str, Any], default: str = "AnyCodable") -> str:
    """Convert an OpenAPI schema snippet to the corresponding Swift type name."""
    if schema is None:
        return default
    if "$ref" in schema:
        ref_name = resolve_ref_name(schema["$ref"])
        if ref_name:
            return to_swift_type_name(ref_name)
        return default
    if "allOf" in schema:
        for item in schema["allOf"]:
            if "$ref" in item:
                return schema_to_swift_type_name(item, components, default)
        return default
    if "anyOf" in schema:
        options = schema["anyOf"]
        non_null_options = [opt for opt in options if not is_null_schema(opt)]
        if not non_null_options:
            return default
        base = schema_to_swift_type_name(non_null_options[0], components, default)
        if any(is_null_schema(opt) or opt.get("nullable") for opt in options):
            if not base.endswith("?"):
                base = f"{base}?"
        return base
    if "oneOf" in schema:
        options = schema["oneOf"]
        non_null_options = [opt for opt in options if not is_null_schema(opt)]
        if len(non_null_options) == 1 and len(options) == 2 and any(is_null_schema(opt) for opt in options):
            base = schema_to_swift_type_name(non_null_options[0], components, default)
            if not base.endswith("?"):
                base = f"{base}?"
            return base
        return default
    schema_type = schema.get("type")
    if schema_type == "array":
        items_type = schema_to_swift_type_name(schema.get("items"), components, default="AnyCodable")
        result = f"[{items_type}]"
    elif schema_type == "object":
        if "additionalProperties" in schema:
            value_type = schema_to_swift_type_name(schema.get("additionalProperties"), components, default="AnyCodable")
            result = f"[String: {value_type}]"
        else:
            result = "AnyCodable"
    elif schema_type == "string":
        fmt = schema.get("format")
        if fmt in ("byte", "binary"):
            result = "Data"
        elif fmt == "uuid":
            result = "UUID"
        elif fmt == "uint64":
            result = "UInt64"
        else:
            result = "String"
    elif schema_type == "integer":
        fmt = schema.get("format")
        if fmt == "int32":
            result = "Int32"
        elif fmt == "int64":
            result = "Int64"
        elif fmt == "uint64":
            result = "UInt64"
        else:
            result = "Int"
    elif schema_type == "number":
        fmt = schema.get("format")
        if fmt == "float":
            result = "Float"
        else:
            result = "Double"
    elif schema_type == "boolean":
        result = "Bool"
    elif schema_type == "null":
        result = "NSNull"
    else:
        result = default
    if schema.get("nullable") and not result.endswith("?"):
        result = f"{result}?"
    return result


def derive_result_type_name(response_schema: Optional[Dict[str, Any]], components: Dict[str, Any]) -> str:
    """Determine the Swift type of the `result` payload inside a JSON-RPC response schema."""
    if not response_schema:
        return "AnyCodable"
    if "oneOf" in response_schema:
        for variant in response_schema["oneOf"]:
            properties = variant.get("properties", {})
            if "result" in properties:
                return schema_to_swift_type_name(properties["result"], components, default="AnyCodable")
        return "AnyCodable"
    if "allOf" in response_schema:
        for item in response_schema["allOf"]:
            properties = item.get("properties", {})
            if "result" in properties:
                return schema_to_swift_type_name(properties["result"], components, default="AnyCodable")
    properties = response_schema.get("properties", {})
    if "result" in properties:
        return schema_to_swift_type_name(properties["result"], components, default="AnyCodable")
    return "AnyCodable"


def to_swift_client_method_name(rpc_method: str) -> str:
    """Convert the RPC method string to a Swift method name."""
    method_name = rpc_method
    if method_name.startswith("rpc_"):
        method_name = method_name[4:]
    if method_name.startswith("EXPERIMENTAL_"):
        method_name = "experimental_" + method_name[len("EXPERIMENTAL_"):]
    return to_swift_property_name(method_name)


def format_doc_comment(description: str, rpc_method: str) -> str:
    """Create a Swift doc comment for a method."""
    lines = [line.strip() for line in description.splitlines() if line.strip()]
    if not lines:
        lines = [f"RPC method: {rpc_method}"]
    return "\n".join(f"    /// {line}" for line in lines)


def extract_rpc_methods(openapi: Dict[str, Any], components: Dict[str, Any]) -> List[Dict[str, str]]:
    """Extract RPC method metadata from the OpenAPI document."""
    methods: List[Dict[str, str]] = []
    seen_swift_names: Set[str] = set()
    paths = openapi.get("paths", {})
    for path_item in paths.values():
        for http_method, operation in path_item.items():
            if http_method.lower() != "post":
                continue
            request_body = operation.get("requestBody", {})
            request_schema = request_body.get("content", {}).get("application/json", {}).get("schema")
            if not request_schema:
                continue
            resolved_request_schema = resolve_schema(request_schema, components)
            if not resolved_request_schema:
                continue
            props = resolved_request_schema.get("properties", {})
            method_property = props.get("method", {})
            method_enum = method_property.get("enum", [])
            rpc_method = method_enum[0] if method_enum else operation.get("operationId")
            if not rpc_method:
                continue
            params_schema = props.get("params")
            request_type = schema_to_swift_type_name(params_schema, components, default="AnyCodable")
            responses = operation.get("responses", {})
            success_response = responses.get("200")
            if not success_response:
                for status_code, candidate in responses.items():
                    if isinstance(status_code, str) and status_code.startswith("2"):
                        success_response = candidate
                        break
            if not success_response:
                continue
            response_schema = success_response.get("content", {}).get("application/json", {}).get("schema")
            response_type = schema_to_swift_type_name(response_schema, components, default="AnyCodable")
            resolved_response_schema = resolve_schema(response_schema, components)
            result_type = derive_result_type_name(resolved_response_schema, components)
            swift_method_name = to_swift_client_method_name(rpc_method)
            original_swift_method_name = swift_method_name
            counter = 2
            while swift_method_name in seen_swift_names:
                swift_method_name = f"{original_swift_method_name}{counter}"
                counter += 1
            seen_swift_names.add(swift_method_name)
            description = operation.get("summary") or operation.get("description") or ""
            methods.append(
                {
                    "rpc_method": rpc_method,
                    "swift_method": swift_method_name,
                    "request_type": request_type,
                    "response_type": response_type,
                    "result_type": result_type,
                    "doc": description.strip(),
                }
            )
    return methods


def generate_methods_code(openapi: Dict[str, Any], components: Dict[str, Any]) -> Tuple[str, int]:
    """Generate the Swift methods implementation from the OpenAPI specification."""
    methods = extract_rpc_methods(openapi, components)
    header = """
import Foundation
import NearJsonRpcTypes

// MARK: - Auto-generated RPC Methods
extension NearJsonRpcClient {
"""
    method_blocks = []
    for method in methods:
        doc_comment = format_doc_comment(method["doc"], method["rpc_method"])
        method_block = f"""
{doc_comment}
    public func {method['swift_method']}(_ request: {method['request_type']}) async throws(NearJsonRpcError) -> {method['result_type']} {{
        let response: {method['response_type']} = try await performRequest(
            method: "{method['rpc_method']}",
            params: request,
            responseType: {method['response_type']}.self
        )
        
        switch response {{
        case .result(let result):
            return result
        case .error(let error):
            throw NearJsonRpcError.rpcError(error)
        }}
    }}
"""
        method_blocks.append(method_block)
    methods_code = "".join(method_blocks)
    footer = """
}
"""
    full_code = header + methods_code + footer
    return full_code, len(methods)

def collect_discriminator_enums(schemas: Dict[str, Any]) -> Dict[str, Set[str]]:
    """Collect all discriminator enum values across all schemas"""
    discriminators: Dict[str, Set[str]] = {}
    
    def extract_from_schema(schema: Dict[str, Any]):
        """Recursively extract discriminator values from a schema"""
        if not isinstance(schema, dict):
            return
        
        # Check properties
        properties = schema.get("properties", {})
        for prop_name, prop_schema in properties.items():
            if is_discriminator_field(prop_name, prop_schema):
                enum_values = prop_schema.get("enum", [])
                if enum_values and enum_values[0] is not None:
                    if prop_name not in discriminators:
                        discriminators[prop_name] = set()
                    discriminators[prop_name].update(enum_values)
        
        # Check oneOf/anyOf/allOf variants
        for key in ["oneOf", "anyOf", "allOf"]:
            if key in schema:
                for variant in schema[key]:
                    extract_from_schema(variant)
    
    # Process all schemas
    for schema in schemas.values():
        extract_from_schema(schema)
    
    return discriminators

def generate_discriminator_enums(discriminators: Dict[str, Set[str]]) -> str:
    """Generate Swift enum types for discriminator fields"""
    code = ""
    
    for field_name, values in sorted(discriminators.items()):
        if not values:
            continue
        
        # Generate enum name from field name
        enum_name = to_swift_type_name(field_name)
        
        code += f"// MARK: - {enum_name}\n\n"
        code += f"public enum {enum_name}: String, Codable, Sendable {{\n"
        
        # Generate cases
        seen_cases = set()
        for value in sorted(values):
            # Convert to valid Swift case name
            case_name = str(value).replace("-", "_").replace(" ", "_").replace(".", "_").replace("/", "_")
            case_name = to_swift_property_name(case_name)
            
            # Ensure case name starts with a letter
            if case_name and case_name[0].isdigit():
                case_name = "val" + case_name
            
            # Avoid duplicate case names
            original_case = case_name
            counter = 1
            while case_name in seen_cases:
                case_name = f"{original_case}{counter}"
                counter += 1
            seen_cases.add(case_name)
            
            if case_name != value:
                code += f'    case {case_name} = "{value}"\n'
            else:
                code += f'    case {case_name}\n'
        
        code += "}\n\n"
    
    return code

def main():
    """Main function to generate Swift types from OpenAPI spec"""
    print(f"Loading OpenAPI specification from {OPENAPI_PATH}...")
    openapi = load_openapi()
    
    components_schemas = openapi.get("components", {}).get("schemas", {})
    if not components_schemas:
        print("No schemas found in OpenAPI specification")
        return
    
    print(f"Found {len(components_schemas)} schemas")
    
    # Collect discriminator enum values
    print("Collecting discriminator fields...")
    discriminators = collect_discriminator_enums(components_schemas)
    print(f"Found {len(discriminators)} discriminator fields with enum values")
    
    # Generate Swift code
    swift_code = "import Foundation\n\n"
    swift_code += "// MARK: - Auto-generated Types\n\n"
    
    
    # Add AnyCodable helper for arbitrary JSON objects
    swift_code += ANYCODABLE_HELPER_CODE
    swift_code += DECODING_DIAGNOSTICS_CODE
    
    # Generate discriminator enums first (they're used by other types)
    if discriminators:
        swift_code += "// MARK: - Discriminator Enums\n\n"
        swift_code += generate_discriminator_enums(discriminators)
    
    generated_types = set()
    inline_types = {}
    
    # Clear the global inline struct registry to ensure clean state
    global _global_inline_struct_schemas
    _global_inline_struct_schemas = {}
    
    # Clear any previous inline structs registry
    if hasattr(get_swift_primitive_type, '_inline_structs'):
        delattr(get_swift_primitive_type, '_inline_structs')
    
    # Sort schemas by dependency (simple types first, then complex)
    def schema_complexity(item):
        name, schema = item
        if "$ref" in schema and len(schema) == 1:
            return 0  # Simple reference
        elif schema.get("type") in ["string", "integer", "number", "boolean"]:
            return 1  # Primitive
        elif "enum" in schema:
            return 2  # Enum
        elif schema.get("type") == "array":
            return 3  # Array
        elif "oneOf" in schema or "anyOf" in schema:
            return 4  # Union
        elif "allOf" in schema:
            return 5  # Composition
        else:
            return 6  # Object
    
    sorted_schemas = sorted(components_schemas.items(), key=schema_complexity)
    
    # Generate types
    for name, schema in sorted_schemas:
        code = generate_swift_for_schema(name, schema, components_schemas, generated_types, inline_types)
        if code:
            swift_code += f"// MARK: - {to_swift_type_name(name)}\n"
            swift_code += code + "\n"
    
    # Add any generated inline structs
    if hasattr(get_swift_primitive_type, '_inline_structs'):
        swift_code += "// MARK: - Generated Inline Types\n\n"
        for type_name, struct_code in get_swift_primitive_type._inline_structs.items():
            swift_code += struct_code + "\n"
    
    # Write to file
    print(f"Writing Swift types to {OUTPUT_PATH}...")
    with open(OUTPUT_PATH, "w", encoding="utf-8") as f:
        f.write(swift_code)
    
    total_generated = len(generated_types)
    if hasattr(get_swift_primitive_type, '_inline_structs'):
        total_generated += len(get_swift_primitive_type._inline_structs)
    
    print(f"Successfully generated {total_generated} Swift types")
    print(f"Output written to: {OUTPUT_PATH}")

    methods_code, method_count = generate_methods_code(openapi, components_schemas)
    methods_output_dir = os.path.dirname(os.path.abspath(METHODS_OUTPUT_PATH))
    os.makedirs(methods_output_dir, exist_ok=True)
    print(f"Writing Swift methods to {METHODS_OUTPUT_PATH}...")
    with open(METHODS_OUTPUT_PATH, "w", encoding="utf-8") as f:
        f.write(methods_code)
    print(f"Successfully generated {method_count} RPC methods")
    print(f"Output written to: {METHODS_OUTPUT_PATH}")

if __name__ == "__main__":
    main()