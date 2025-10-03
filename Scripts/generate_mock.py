# generate_mock_json.py
# Script to generate sample JSON files for all request and response schemas from OpenAPI spec
import json
import os
import random
from typing import Any, Dict, List, Optional, Set, Tuple

import jsonschema

OPENAPI_PATH = "./openapi.json"
TARGET_DIRECTORIES = [
    ("Types tests", "../Tests/NearJsonRpcTypesTests/Mock"),
    ("Client tests", "../Tests/NearJsonRpcClientTests/Mock")
]
MAX_ATTEMPTS = 5  # attempts to generate a valid sample (useful because generation uses randomness)

# --- Swift Type Name Conversion (same logic as codegen.py) ---
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

# --- Load OpenAPI ---
def load_openapi() -> Dict[str, Any]:
    if not os.path.exists(OPENAPI_PATH):
        raise FileNotFoundError(f"{OPENAPI_PATH} not found")
    with open(OPENAPI_PATH, "r", encoding="utf-8") as f:
        return json.load(f)

_openapi: Optional[Dict[str, Any]] = None
_components_schemas: Dict[str, Any] = {}

def ensure_loaded():
    global _openapi, _components_schemas
    if _openapi is None:
        _openapi = load_openapi()
        _components_schemas = _openapi.get("components", {}).get("schemas", {}) or {}

# --- Helpers (same enhanced generator from previous version) ---
def resolve_ref_schema(ref: str, components: Dict[str, Any]) -> Optional[Dict[str, Any]]:
    if not ref.startswith("#/components/schemas/"):
        return None
    name = ref.split("/")[-1]
    return components.get(name)

def get_fallback_for_ref(ref_name: str, components: Dict[str, Any], depth: int = 0) -> Any:
    """Generate appropriate fallback values for common schema references"""
    # Common primitive-like references
    if ref_name in ("AccountId", "PublicKey", "CryptoHash"):
        return "s"  # These are typically string-like
    elif ref_name == "ShardId":
        return 0  # ShardId is typically an integer/uint64
    elif ref_name in ("BlockHeight", "Balance", "Gas"):
        return 0  # These are typically numeric
    elif ref_name == "Nonce":
        return 0
    else:
        # For complex objects, try to generate a minimal object if depth allows
        if depth < 3:  # Prevent deep recursion
            ref_schema = components.get(ref_name)
            if ref_schema and ref_schema.get("type") == "object":
                # Try to generate minimal required object
                props = ref_schema.get("properties", {})
                required = ref_schema.get("required", [])
                minimal_obj = {}
                for req_field in required[:5]:  # Limit to first 5 required fields
                    field_schema = props.get(req_field, {})
                    if field_schema.get("type") == "string":
                        minimal_obj[req_field] = "s"
                    elif field_schema.get("type") == "integer":
                        minimal_obj[req_field] = 0
                    elif field_schema.get("type") == "number":
                        minimal_obj[req_field] = 0.0
                    elif field_schema.get("type") == "boolean":
                        minimal_obj[req_field] = True
                    elif field_schema.get("type") == "array":
                        minimal_obj[req_field] = []
                    elif "$ref" in field_schema:
                        inner_ref = field_schema["$ref"].split("/")[-1]
                        minimal_obj[req_field] = get_fallback_for_ref(inner_ref, components, depth + 1)
                    else:
                        minimal_obj[req_field] = "s"
                return minimal_obj
        # Default fallback for complex objects
        return {}

def choose_enum(schema: Dict[str, Any]) -> Any:
    enum = schema.get("enum", [])
    if not enum:
        return None
    if len(enum) > 1:
        non_null = [v for v in enum if v is not None]
        if non_null:
            if random.random() < 0.9:
                return random.choice(non_null)
            else:
                return random.choice(enum)
        return random.choice(enum)
    return enum[0]

def merge_allof_schemas(allof_list: List[Dict[str, Any]], components: Dict[str, Any]) -> Dict[str, Any]:
    """
    Merge allOf schemas. Handles:
      - single $ref → resolve and return it
      - multiple schemas → merge object parts + primitive constraints
    """
    if len(allof_list) == 1:
        first = allof_list[0]
        if "$ref" in first:
            resolved = resolve_ref_schema(first["$ref"], components)
            if resolved is not None:
                # Return resolved schema directly — avoids returning {} later
                return resolved
        # Otherwise fall through to general merging below

    object_parts = []
    primitive_parts = []

    for subs in allof_list:
        inline = {k: v for k, v in subs.items() if k != "$ref"}
        if "$ref" in subs:
            resolved = resolve_ref_schema(subs["$ref"], components)
            if resolved:
                # Treat resolved schema as inline
                if resolved.get("type") == "object" or "properties" in resolved:
                    object_parts.append(resolved)
                else:
                    primitive_parts.append(resolved)

        if inline:
            if inline.get("type") == "object" or "properties" in inline:
                object_parts.append(inline)
            else:
                primitive_parts.append(inline)

    if object_parts and not primitive_parts:
        merged = {"type": "object", "properties": {}, "required": []}
        for subschema in object_parts:
            merged["properties"].update(subschema.get("properties", {}))
            merged["required"] = list(dict.fromkeys(merged.get("required", []) + subschema.get("required", [])))
            if "additionalProperties" in subschema:
                merged["additionalProperties"] = subschema["additionalProperties"]
        return merged

    if primitive_parts and not object_parts:
        # Just take the first one? Or combine? For now, pick first.
        return dict(primitive_parts[0])

    if object_parts and primitive_parts:
        merged = {"type": "object", "properties": {}, "required": []}
        for subschema in object_parts:
            merged["properties"].update(subschema.get("properties", {}))
            merged["required"] = list(dict.fromkeys(merged.get("required", []) + subschema.get("required", [])))
        # Overlay primitive constraints (like type, format, etc.)
        merged.update(primitive_parts[0])
        return merged

    # Fallback: if nothing could be merged, return empty schema — generate_sample will handle it
    return {}

def sample_for_primitive(schema: Dict[str, Any]) -> Any:
    if "enum" in schema:
        return choose_enum(schema)
    if "default" in schema:
        return schema["default"]
    if "const" in schema:
        return schema["const"]

    typ = schema.get("type")
    fmt = schema.get("format", "")
    if typ == "string" or (typ is None and fmt):
        min_len = schema.get("minLength", 1)
        length = max(1, min_len)
        if fmt in ("byte", "bytes"):
            return "c3RyaW5n"
        if fmt in ("date-time", "date"):
            return "1970-01-01T00:00:00Z"
        return "s" * max(1, length)
    if typ == "integer":
        if "minimum" in schema:
            return int(schema["minimum"])
        if "maximum" in schema:
            return int(schema["maximum"])
        return 0
    if typ == "number":
        if "minimum" in schema:
            return float(schema["minimum"])
        if "maximum" in schema:
            return float(schema["maximum"])
        return 0.0
    if typ == "boolean":
        return True
    return None

def generate_sample(schema: Dict[str, Any],
                    components: Dict[str, Any],
                    depth: int = 0,
                    seen_refs: Optional[Set[str]] = None) -> Any:
    if depth > 100:  # Increased depth limit to handle complex nested schemas
        return None
    seen_refs = seen_refs or set()

    if schema is None:
        return None

    if "$ref" in schema:
        ref = schema["$ref"]
        if ref in seen_refs:
            # Instead of returning None for circular refs, return a basic fallback
            ref_name = ref.split("/")[-1]
            return get_fallback_for_ref(ref_name, components, depth + 5)  # Use high depth to get simple fallback
        seen_refs.add(ref)
        resolved = resolve_ref_schema(ref, components)
        if resolved is None:
            return None
        return generate_sample(resolved, components, depth + 1, seen_refs)

    if "default" in schema:
        return schema["default"]
    if "enum" in schema:
        return choose_enum(schema)

    # Handle nullable fields - but be more conservative about returning None
    # for fields that have additional constraints
    if schema.get("nullable", False):
        # Only return None for nullable fields if they don't have other constraints
        # or if we're in a context where null is truly acceptable
        has_constraints = any(k in schema for k in ["minimum", "maximum", "minLength", "maxLength", "format", "pattern"])
        if not has_constraints and random.random() < 0.1:
            return None

    if "allOf" in schema:
        merged = merge_allof_schemas(schema["allOf"], components)
        return generate_sample(merged, components, depth + 1, seen_refs)

    if "oneOf" in schema or "anyOf" in schema:
        choices = schema.get("oneOf") or schema.get("anyOf")
        if not choices:
            return None

        # Pick a random choice from oneOf/anyOf
        choice = random.choice(choices)

        # Generate base sample from chosen subschema
        sample = generate_sample(choice, components, depth + 1, seen_refs)

        # If we got a dict result, we need to merge in the parent schema's properties and requirements
        if isinstance(sample, dict):
            # Get parent-level properties and required fields
            parent_props = schema.get("properties", {})
            parent_required = schema.get("required", [])
            choice_props = choice.get("properties", {}) if isinstance(choice, dict) else {}
            choice_required = choice.get("required", []) if isinstance(choice, dict) else []

            # Ensure all parent-level required properties are present
            for prop_name in parent_required:
                if prop_name not in sample:
                    # Try to get the property schema from parent or choice
                    prop_schema = parent_props.get(prop_name) or choice_props.get(prop_name, {})
                    if prop_schema:
                        prop_sample = generate_sample(prop_schema, components, depth + 1, seen_refs.copy())
                        if prop_sample is not None:
                            sample[prop_name] = prop_sample
                        # If None, we'll leave it out and let validation catch it

            # Also ensure choice-level required properties are present
            for prop_name in choice_required:
                if prop_name not in sample:
                    prop_schema = choice_props.get(prop_name) or parent_props.get(prop_name, {})
                    if prop_schema:
                        prop_sample = generate_sample(prop_schema, components, depth + 1, seen_refs.copy())
                        if prop_sample is not None:
                            sample[prop_name] = prop_sample
                        # If None, we'll leave it out and let validation catch it

        return sample

    if schema.get("type") == "object" or "properties" in schema or "patternProperties" in schema or ("additionalProperties" in schema and isinstance(schema.get("additionalProperties"), dict)):
        props = schema.get("properties", {}) or {}
        required = schema.get("required", []) or []
        out: Dict[str, Any] = {}

        # Handle explicit properties
        for name, subs in props.items():
            is_required = name in required
            
            # Check for nullable - need to resolve $ref to get the full schema
            is_nullable = subs.get("nullable", False)
            if not is_nullable and "$ref" in subs:
                resolved_schema = resolve_ref_schema(subs["$ref"], components)
                if resolved_schema:
                    is_nullable = resolved_schema.get("nullable", False)
            
            # Also check if anyOf/oneOf contains null
            if not is_nullable:
                if "anyOf" in subs:
                    for variant in subs["anyOf"]:
                        if variant.get("nullable") or variant.get("enum") == [None]:
                            is_nullable = True
                            break
                elif "oneOf" in subs:
                    for variant in subs["oneOf"]:
                        if variant.get("nullable") or variant.get("enum") == [None]:
                            is_nullable = True
                            break

            # Create a new seen_refs copy for each property to avoid cross-property circular ref detection
            property_seen_refs = seen_refs.copy()
            val = generate_sample(subs, components, depth + 1, property_seen_refs)

            # If we got None but field is required and NOT nullable → try regenerating
            if val is None and is_required and not is_nullable:
                # Try a few more times with different random seeds
                for retry in range(3):
                    val = generate_sample(subs, components, depth + 1, seen_refs.copy())
                    if val is not None:
                        break
                
                # If still None, keep it as None - the validation will catch it
                # This helps us identify actual schema issues
            elif val is None and not is_nullable:
                # Even if not required, don't set arrays/objects to None unless explicitly nullable
                typ = subs.get("type")
                if typ == "array":
                    val = []
                elif typ == "object" or "properties" in subs:
                    val = {}

            out[name] = val

        # Handle patternProperties
        pp = schema.get("patternProperties", {}) or {}
        for patt, pschema in pp.items():
            # Try to generate a key that matches the pattern
            example_key = None

            # Common case: ^\d+$
            if patt == r"^\d+$":
                example_key = str(random.randint(0, 999))
            # You can add more common patterns here as needed
            elif patt == r"^[a-zA-Z_][a-zA-Z0-9_]*$":  # simple identifier
                example_key = random.choice(["key_a", "item_1", "field_x"])
            else:
                # Fallback: try to generate something plausible or use generic
                # For now, just use a safe default — but warn via comment or log
                example_key = f"generated_key_{hash(patt) % 1000}"

            # Generate value for this pattern-matched property
            val = generate_sample(pschema, components, depth + 1, seen_refs)
            if val is None:
                val = sample_for_primitive(pschema) or "s"

            out[example_key] = val

        # Handle additionalProperties
        addp = schema.get("additionalProperties", None)
        if isinstance(addp, dict):
            # Only add if additionalProperties is allowed (not False)
            if addp is not False:
                out["additionalProp1"] = generate_sample(addp, components, depth + 1, seen_refs)

        return out

    if schema.get("type") == "array" or "items" in schema:
        items_schema = schema.get("items", {})
        min_items = schema.get("minItems", None)
        max_items = schema.get("maxItems", None)

        # Handle tuple-style arrays (items: [schema1, schema2, ...])
        if isinstance(items_schema, list):
            arr = []
            for item_sch in items_schema:
                val = generate_sample(item_sch, components, depth + 1, seen_refs)
                # Enforce non-nullability per item schema unless explicitly nullable
                if val is None and not item_sch.get("nullable", False):
                    # Try a few more times
                    for retry in range(3):
                        val = generate_sample(item_sch, components, depth + 1, seen_refs.copy())
                        if val is not None:
                            break
                    # If still None, we'll skip this item or add it anyway
                    # depending on whether it's required (for tuple arrays, all items are typically required)
                arr.append(val)
            if min_items and len(arr) < min_items:
                while len(arr) < min_items:
                    last_sch = items_schema[-1]
                    val = generate_sample(last_sch, components, depth + 1, seen_refs.copy())
                    arr.append(val)
            return arr

        # Handle uniform arrays (items: { ... })
        count = 1
        if isinstance(min_items, int):
            count = max(1, min_items)
        elif isinstance(max_items, int):
            count = max(1, min(3, max_items))
        else:
            count = 1

        arr = []
        for _ in range(count):
            val = generate_sample(items_schema, components, depth + 1, seen_refs.copy())
            if val is None and not items_schema.get("nullable", False):
                # Try a few more times
                for retry in range(3):
                    val = generate_sample(items_schema, components, depth + 1, seen_refs.copy())
                    if val is not None:
                        break
                # If still None after retries, keep it as None
            arr.append(val)

        return arr

    prim = sample_for_primitive(schema)
    if prim is not None:
        return prim

    return None

def convert_openapi_nullable_to_jsonschema(schema):
    """
    Convert OpenAPI 3.0 'nullable: true' to JSON Schema compatible anyOf patterns.
    This is needed because jsonschema library doesn't understand the 'nullable' keyword.
    """
    if not isinstance(schema, dict):
        return schema
    
    # Create a deep copy to avoid modifying the original
    converted = schema.copy()
    
    # Handle nullable fields
    if converted.get("nullable", False) and "type" in converted:
        # Convert {type: "integer", nullable: true} to {anyOf: [{type: "integer"}, {type: "null"}]}
        original_type_schema = {k: v for k, v in converted.items() if k != "nullable"}
        converted = {
            "anyOf": [
                original_type_schema,
                {"type": "null"}
            ]
        }
    
    # Recursively convert nested schemas
    if "properties" in converted:
        converted["properties"] = {
            k: convert_openapi_nullable_to_jsonschema(v) 
            for k, v in converted["properties"].items()
        }
    
    if "items" in converted:
        converted["items"] = convert_openapi_nullable_to_jsonschema(converted["items"])
    
    if "additionalProperties" in converted and isinstance(converted["additionalProperties"], dict):
        converted["additionalProperties"] = convert_openapi_nullable_to_jsonschema(converted["additionalProperties"])
    
    for key in ["allOf", "oneOf", "anyOf"]:
        if key in converted:
            converted[key] = [convert_openapi_nullable_to_jsonschema(sub) for sub in converted[key]]
    
    return converted

def generate_sample_for_schema(schema_name: str) -> Optional[Dict[str, Any]]:
    """
    Generate a sample JSON for `schema_name` and validate it against the full schema using jsonschema.
    Tries multiple attempts (because generation uses randomness). Returns first valid sample or None.
    """
    schema = _components_schemas.get(schema_name)
    if schema is None:
        print(f"⚠️  Schema '{schema_name}' not found")
        return None

    # Prepare a jsonschema resolver rooted at the whole OpenAPI doc so "#/components/..." refs resolve.
    # But first convert nullable fields to be compatible with JSON Schema
    converted_root_doc = _openapi.copy() if _openapi else {}
    if "components" in converted_root_doc and "schemas" in converted_root_doc["components"]:
        converted_root_doc["components"]["schemas"] = {
            name: convert_openapi_nullable_to_jsonschema(schema_def)
            for name, schema_def in converted_root_doc["components"]["schemas"].items()
        }
    
    resolver = jsonschema.RefResolver.from_schema(converted_root_doc)
    
    # Also convert the current schema for validation
    converted_schema = convert_openapi_nullable_to_jsonschema(schema)

    last_error = None
    last_sample = None

    # choose appropriate validator class for the schema
    ValidatorClass = jsonschema.validators.validator_for(converted_schema)
    # instantiate validator with schema and resolver
    for attempt in range(1, MAX_ATTEMPTS + 1):
        sample = generate_sample(schema, _components_schemas)  # Generate from original schema
        last_sample = sample
        try:
            validator = ValidatorClass(converted_schema, resolver=resolver)  # Validate against converted schema
            validator.validate(sample)
            # success
            return sample
        except jsonschema.ValidationError as ve:
            last_error = ve
            # try again (randomness may produce a different valid sample)
            continue
        except Exception as e:
            # unexpected error (schema not valid for chosen validator or other issues)
            last_error = e
            break

    # If we get here, attempts failed
    print(f"❌ Failed to generate valid sample for '{schema_name}': {last_error}")
    return last_sample  # Return last attempt even if invalid

def is_request_or_response_schema(schema_name: str) -> bool:
    """Check if schema name is a request or response schema"""
    return (schema_name.startswith("JsonRpcRequest_") or 
            schema_name.startswith("JsonRpcResponse_"))

def is_response_schema(schema_name: str) -> bool:
    """Check if schema name is a response schema"""
    return schema_name.startswith("JsonRpcResponse_")

def generate_response_variant(schema_name: str, variant_type: str) -> Optional[Dict[str, Any]]:
    """
    Generate a sample for a specific response variant (result or error).
    
    Args:
        schema_name: The response schema name
        variant_type: Either "result" or "error"
    
    Returns:
        Sample JSON with the specified variant, or None if failed
    """
    schema = _components_schemas.get(schema_name)
    if schema is None:
        return None
    
    # Check if this is a oneOf response schema
    one_of = schema.get("oneOf", [])
    if not one_of:
        # Not a oneOf schema, generate normally
        return generate_sample_for_schema(schema_name)
    
    # Find the variant we want (result or error)
    target_variant = None
    for variant in one_of:
        if variant_type in variant.get("properties", {}):
            target_variant = variant
            break
    
    if target_variant is None:
        return None
    
    # Create a modified schema that forces the specific variant
    # We need to merge the base schema with the specific variant
    forced_schema = {
        "type": "object",
        "properties": {},
        "required": []
    }
    
    # Copy base properties (id, jsonrpc, etc.)
    if "properties" in schema:
        forced_schema["properties"].update(schema["properties"])
    
    # Copy base required fields
    if "required" in schema:
        forced_schema["required"] = list(schema["required"])
    
    # Merge the variant properties (result or error field)
    if "properties" in target_variant:
        forced_schema["properties"].update(target_variant["properties"])
    
    # Merge the variant required fields
    if "required" in target_variant:
        forced_schema["required"].extend(target_variant["required"])
    
    # Remove duplicates from required list
    forced_schema["required"] = list(set(forced_schema["required"]))
    
    # Generate sample from the forced schema
    return generate_sample(forced_schema, _components_schemas, depth=0, seen_refs=set())

def should_generate_standalone_mock(schema_name: str, schema: Dict[str, Any]) -> bool:
    """
    Determine if we should generate a standalone mock for this schema.
    We want to generate mocks for complex types that would benefit from testing.
    """
    # Skip request/response types (handled separately)
    if is_request_or_response_schema(schema_name):
        return False
    
    # Skip simple typealiases (string, int, etc.)
    if "type" in schema and schema["type"] in ("string", "integer", "number", "boolean"):
        if "properties" not in schema and "enum" not in schema and "oneOf" not in schema and "anyOf" not in schema:
            return False
    
    # Generate for structs with properties
    if "properties" in schema:
        return True
    
    # Generate for enums
    if "enum" in schema:
        return True
    
    # Generate for oneOf/anyOf types
    if "oneOf" in schema or "anyOf" in schema:
        return True
    
    # Generate for allOf types
    if "allOf" in schema:
        return True
    
    return False

def generate_all_oneof_variants(schema_name: str, schema: Dict[str, Any]) -> List[Tuple[str, Dict[str, Any]]]:
    """
    Generate a sample for EACH variant of a oneOf/anyOf schema.
    This is critical for achieving high code coverage on enum types.
    
    Returns:
        List of (variant_name, sample_json) tuples
    """
    variants_list = []
    
    # Check if this is a oneOf or anyOf schema
    variant_key = None
    if "oneOf" in schema:
        variant_key = "oneOf"
    elif "anyOf" in schema:
        variant_key = "anyOf"
    else:
        return variants_list
    
    variants = schema[variant_key]
    
    # Try to generate a sample for each variant
    for i, variant in enumerate(variants):
        try:
            # Create a schema that forces this specific variant
            forced_schema = dict(variant)
            
            # If the parent schema has base properties, merge them
            if "properties" in schema and "properties" in forced_schema:
                base_props = schema["properties"].copy()
                base_props.update(forced_schema["properties"])
                forced_schema["properties"] = base_props
            
            # Generate sample for this variant
            sample = generate_sample(forced_schema, _components_schemas, depth=0, seen_refs=set())
            
            if sample is not None:
                variant_name = f"{schema_name}_Variant{i}"
                variants_list.append((variant_name, sample))
        except Exception as e:
            # Skip variants that fail to generate
            print(f"  ⚠️  Could not generate variant {i} for {schema_name}: {e}")
            continue
    
    return variants_list

def main():
    """Generate sample JSON files for all request and response schemas"""
    ensure_loaded()
    
    # Create target directories if they don't exist
    for _, directory in TARGET_DIRECTORIES:
        os.makedirs(directory, exist_ok=True)
    
    # Clean up old response files (without _Success or _Error suffix)
    print("🧹 Cleaning up old response files...")
    total_removed = 0
    for label, directory in TARGET_DIRECTORIES:
        if os.path.exists(directory):
            for filename in os.listdir(directory):
                if filename.startswith("JsonRpcResponseFor") and filename.endswith(".json"):
                    if not (filename.endswith("_Success.json") or filename.endswith("_Error.json")):
                        filepath = os.path.join(directory, filename)
                        os.remove(filepath)
                        print(f"   Removed old file: {filename}")
                        total_removed += 1
    print()
    
    # Filter schemas to only request and response types
    request_response_schemas = {
        name: schema for name, schema in _components_schemas.items()
        if is_request_or_response_schema(name)
    }
    
    print(f"📋 Found {len(request_response_schemas)} request/response schemas")
    print(f"📁 Output directories:")
    for label, directory in TARGET_DIRECTORIES:
        print(f"   {label}: {directory}")
    print()
    
    success_count = 0
    failed_count = 0
    
    for schema_name in sorted(request_response_schemas.keys()):
        swift_name = to_swift_type_name(schema_name)
        
        if is_response_schema(schema_name):
            # Generate both success and error variants
            for variant_type in ["result", "error"]:
                suffix = "_Success" if variant_type == "result" else "_Error"
                filename = f"{swift_name}{suffix}.json"
                
                sample = generate_response_variant(schema_name, variant_type)
                
                if sample:
                    for label, directory in TARGET_DIRECTORIES:
                        filepath = os.path.join(directory, filename)
                        with open(filepath, "w", encoding="utf-8") as f:
                            json.dump(sample, f, indent=2)
                    print(f"✅ {filename}")
                    success_count += 1
                else:
                    print(f"❌ Failed: {filename}")
                    failed_count += 1
        else:
            # Regular request schema
            filename = f"{swift_name}.json"
            sample = generate_sample_for_schema(schema_name)
            
            if sample:
                for label, directory in TARGET_DIRECTORIES:
                    filepath = os.path.join(directory, filename)
                    with open(filepath, "w", encoding="utf-8") as f:
                        json.dump(sample, f, indent=2)
                print(f"✅ {filename}")
                success_count += 1
            else:
                print(f"❌ Failed: {filename}")
                failed_count += 1
    
    print()
    print(f"✨ Request/Response generation complete! Generated {success_count} files, {failed_count} failed")
    
    # Now generate standalone type mocks for better coverage
    print()
    print("📋 Generating standalone type mocks for improved coverage...")
    
    standalone_schemas = {
        name: schema for name, schema in _components_schemas.items()
        if should_generate_standalone_mock(name, schema)
    }
    
    print(f"   Found {len(standalone_schemas)} standalone types to generate")
    
    standalone_success = 0
    standalone_failed = 0
    variant_success = 0
    
    for schema_name in sorted(standalone_schemas.keys()):
        swift_name = to_swift_type_name(schema_name)
        schema = standalone_schemas[schema_name]
        
        # Check if this is a oneOf/anyOf type
        if "oneOf" in schema or "anyOf" in schema:
            # Generate samples for ALL variants
            variants = generate_all_oneof_variants(schema_name, schema)
            
            if variants:
                for variant_name, variant_sample in variants:
                    filename = f"{variant_name}.json"
                    for label, directory in TARGET_DIRECTORIES:
                        filepath = os.path.join(directory, filename)
                        with open(filepath, "w", encoding="utf-8") as f:
                            json.dump(variant_sample, f, indent=2)
                    print(f"✅ {filename}")
                    variant_success += 1
            else:
                print(f"⚠️  No variants generated for: {swift_name}")
        else:
            # Regular type (struct, enum, etc.)
            filename = f"{swift_name}.json"
            sample = generate_sample_for_schema(schema_name)
            
            if sample:
                for label, directory in TARGET_DIRECTORIES:
                    filepath = os.path.join(directory, filename)
                    with open(filepath, "w", encoding="utf-8") as f:
                        json.dump(sample, f, indent=2)
                print(f"✅ {filename}")
                standalone_success += 1
            else:
                print(f"❌ Failed: {filename}")
                standalone_failed += 1
    
    print()
    print(f"✨ Standalone type generation complete! Generated {standalone_success} regular + {variant_success} variant files")
    
    print()
    print(f"📊 Summary:")
    print(f"   Request/Response: {success_count} files")
    print(f"   Standalone types: {standalone_success} files")
    print(f"   OneOf/AnyOf variants: {variant_success} files")
    print(f"   Total: {success_count + standalone_success + variant_success} files")
    print()
    print("📂 Files saved to:")
    for label, directory in TARGET_DIRECTORIES:
        print(f"   {label}: {directory}")
    print()
    print("🎉 All done! Mock JSON files are ready for testing.")
    print()
    print("💡 Variant files significantly improve coverage by testing all enum cases!")

if __name__ == "__main__":
    main()
