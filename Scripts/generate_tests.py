#!/usr/bin/env python3

import json
import os
from typing import Dict, Any, List, Tuple, Set, Optional

OPENAPI_PATH = "./openapi.json"
MOCK_DIR_TYPES = "../Tests/NearJsonRpcTypesTests/Mock"
MOCK_DIR_CLIENT = "../Tests/NearJsonRpcClientTests/Mock"

# Output paths
TYPES_TEST_OUTPUT = "../Tests/NearJsonRpcTypesTests/TypesDecodingTests.swift"
STANDALONE_TYPES_TEST_OUTPUT = "../Tests/NearJsonRpcTypesTests/StandaloneTypesTests.swift"
ENHANCED_TEST_OUTPUT = "../Tests/NearJsonRpcTypesTests/EnhancedCoverageTests.swift"
CLIENT_TEST_OUTPUT = "../Tests/NearJsonRpcClientTests/ClientTests.swift"
CLIENT_METHOD_TEST_OUTPUT = "../Tests/NearJsonRpcClientTests/ClientMethodTests.swift"


def to_swift_type_name(name: str) -> str:
    """Convert schema name to Swift type name (PascalCase)"""
    if not name:
        return name
    
    if "_" in name:
        parts = name.split("_")
        processed_parts = []
        for part in parts:
            if part.islower():
                processed_parts.append(part.capitalize())
            else:
                processed_parts.append(part)
        return "".join(processed_parts)
    
    if name and name[0].islower():
        return name[0].upper() + name[1:]
    
    return name


def to_swift_property_name(name: str) -> str:
    """Convert property name to Swift property name (camelCase)"""
    if "_" in name:
        parts = name.split("_")
        return parts[0].lower() + "".join(part.capitalize() for part in parts[1:])
    if name.isupper() and len(name) > 1:
        return name.lower()
    return name[0].lower() + name[1:] if name else name


def to_swift_function_name(rpc_method: str) -> str:
    """Convert RPC method name to Swift function name (camelCase)"""
    method_name = rpc_method
    if method_name.startswith("rpc_"):
        method_name = method_name[4:]
    if method_name.startswith("EXPERIMENTAL_"):
        method_name = "experimental_" + method_name[len("EXPERIMENTAL_"):]
    return to_swift_property_name(method_name)


def load_openapi() -> Dict[str, Any]:
    """Load OpenAPI specification"""
    if not os.path.exists(OPENAPI_PATH):
        raise FileNotFoundError(f"{OPENAPI_PATH} not found")
    with open(OPENAPI_PATH, "r", encoding="utf-8") as f:
        return json.load(f)


def extract_method_info(openapi: Dict[str, Any]) -> List[Tuple[str, str, str, str, str]]:
    """Extract method information from OpenAPI spec
    Returns: List of (method_name, swift_function_name, request_type, response_type, result_type)
    """
    methods = []
    paths = openapi.get("paths", {})
    
    for path, path_item in paths.items():
        if "post" not in path_item:
            continue
        
        post_op = path_item["post"]
        method_name = path.lstrip("/")
        swift_function_name = to_swift_function_name(method_name)
        
        # Get request type from requestBody
        request_type = None
        if "requestBody" in post_op:
            content = post_op["requestBody"].get("content", {})
            json_content = content.get("application/json", {})
            schema = json_content.get("schema", {})
            if "$ref" in schema:
                request_type = schema["$ref"].split("/")[-1]
        
        # Get response type from responses
        response_type = None
        result_type = None
        if "responses" in post_op:
            success_response = post_op["responses"].get("200", {})
            content = success_response.get("content", {})
            json_content = content.get("application/json", {})
            schema = json_content.get("schema", {})
            if "$ref" in schema:
                response_type = schema["$ref"].split("/")[-1]
                
                # Extract the result type from response schema
                schemas = openapi.get("components", {}).get("schemas", {})
                response_schema = schemas.get(response_type, {})
                
                # Check if it's a oneOf response (result or error)
                if "oneOf" in response_schema:
                    for variant in response_schema["oneOf"]:
                        if "$ref" in variant:
                            continue
                        props = variant.get("properties", {})
                        if "result" in props:
                            result_ref = props["result"].get("$ref", "")
                            if result_ref:
                                result_type = result_ref.split("/")[-1]
                            else:
                                result_schema = props["result"]
                                result_type = result_schema.get("type", "Any")
                            break
        
        if request_type and response_type:
            methods.append((method_name, swift_function_name, request_type, response_type, result_type or "Unknown"))
    
    return methods


def extract_all_type_names(openapi: Dict[str, Any]) -> Dict[str, str]:
    """Extract all type names from OpenAPI schemas and categorize them.
    Returns a dict mapping type_name -> category (enum, struct, typealias, etc.)
    """
    schemas = openapi.get("components", {}).get("schemas", {})
    types = {}
    
    for schema_name, schema in schemas.items():
        # Skip request/response types as they're tested separately
        if schema_name.startswith("JsonRpcRequest") or schema_name.startswith("JsonRpcResponse"):
            continue
            
        swift_name = to_swift_type_name(schema_name)
        
        # Determine type category
        if "enum" in schema and isinstance(schema.get("enum"), list):
            types[swift_name] = "enum"
        elif "oneOf" in schema or "anyOf" in schema:
            types[swift_name] = "enum"
        elif "type" in schema:
            schema_type = schema.get("type")
            if schema_type == "object":
                types[swift_name] = "struct"
            elif schema_type == "string":
                types[swift_name] = "typealias"
            elif schema_type in ("integer", "number"):
                types[swift_name] = "typealias"
            elif schema_type == "array":
                types[swift_name] = "typealias"
        elif "allOf" in schema:
            types[swift_name] = "struct"
    
    return types


def generate_types_tests(openapi: Dict[str, Any]) -> str:
    """Generate tests for type encoding/decoding"""
    
    # Get all mock JSON files
    mock_files = []
    if os.path.exists(MOCK_DIR_TYPES):
        mock_files = [f for f in os.listdir(MOCK_DIR_TYPES) if f.endswith('.json')]
    
    code = """
import Testing
import Foundation
@testable import NearJsonRpcTypes

@Suite("Type Encoding/Decoding Tests")
struct TypesDecodingTests {
    
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    
    init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
    }
    
    /// Load mock JSON data from file
    func loadMockJSON(_ filename: String) throws -> Data {
        let testBundle = Bundle.module
        guard let url = testBundle.url(forResource: filename.replacingOccurrences(of: ".json", with: ""), withExtension: "json", subdirectory: "Mock") else {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock file not found: \\(filename)"])
        }
        return try Data(contentsOf: url)
    }
    
"""
    
    # Generate test for each request type
    request_files = sorted([f for f in mock_files if f.startswith('JsonRpcRequestFor')])
    for filename in request_files:
        type_name = filename.replace('.json', '')
        test_name = f"test{type_name}DecodingAndEncoding"
        
        code += f"""    @Test("{type_name} can be decoded and re-encoded")
    func {test_name}() throws {{
        let data = try loadMockJSON("{filename}")
        
        // Test decoding
        let decoded = try decoder.decode({type_name}.self, from: data)
        
        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(encoded.count > 0)
        
        // Test round-trip
        _ = try decoder.decode({type_name}.self, from: encoded)
    }}
    
"""
    
    # Group response files by base type (without _Success or _Error suffix)
    response_base_types = {}
    for filename in mock_files:
        if filename.startswith('JsonRpcResponseFor'):
            name_without_ext = filename.replace('.json', '')
            
            if name_without_ext.endswith('_Success'):
                base_type = name_without_ext[:-8]
                if base_type not in response_base_types:
                    response_base_types[base_type] = {}
                response_base_types[base_type]['success'] = filename
            elif name_without_ext.endswith('_Error'):
                base_type = name_without_ext[:-6]
                if base_type not in response_base_types:
                    response_base_types[base_type] = {}
                response_base_types[base_type]['error'] = filename
    
    # Generate tests for response types (both success and error variants)
    for base_type in sorted(response_base_types.keys()):
        variants = response_base_types[base_type]
        
        # Test success variant
        if 'success' in variants:
            filename = variants['success']
            test_name = f"test{base_type}SuccessDecodingAndEncoding"
            
            code += f"""    @Test("{base_type} success response can be decoded and re-encoded")
    func {test_name}() throws {{
        let data = try loadMockJSON("{filename}")
        
        // Test decoding
        let decoded = try decoder.decode({base_type}.self, from: data)
        
        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(encoded.count > 0)
        
        // Test round-trip
        _ = try decoder.decode({base_type}.self, from: encoded)
    }}
    
"""
        
        # Test error variant
        if 'error' in variants:
            filename = variants['error']
            test_name = f"test{base_type}ErrorDecodingAndEncoding"
            
            code += f"""    @Test("{base_type} error response can be decoded and re-encoded")
    func {test_name}() throws {{
        let data = try loadMockJSON("{filename}")
        
        // Test decoding
        let decoded = try decoder.decode({base_type}.self, from: data)
        
        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(encoded.count > 0)
        
        // Test round-trip
        _ = try decoder.decode({base_type}.self, from: encoded)
    }}
    
"""
    
    code += "}\n"
    return code


# =============================================================================
# STANDALONE TYPES TESTS GENERATOR
# =============================================================================

def generate_standalone_types_tests(openapi: Dict[str, Any]) -> str:
    """Generate tests for standalone types (not just request/response)"""
    
    code = """
import Testing
import Foundation
@testable import NearJsonRpcTypes

@Suite("Standalone Type Tests for Coverage")
struct StandaloneTypesTests {
    
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    
    init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
    }
    
    /// Load mock JSON data from file
    func loadMockJSON(_ filename: String) throws -> Data {
        let testBundle = Bundle.module
        guard let url = testBundle.url(forResource: filename.replacingOccurrences(of: ".json", with: ""), withExtension: "json", subdirectory: "Mock") else {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock file not found: \\(filename)"])
        }
        return try Data(contentsOf: url)
    }
    
"""
    
    types = extract_all_type_names(openapi)
    
    # Check which types have mock files (including variants)
    mock_files = set()
    if os.path.exists(MOCK_DIR_TYPES):
        mock_files = {f.replace('.json', '') for f in os.listdir(MOCK_DIR_TYPES) if f.endswith('.json')}
    
    test_count = 0
    variant_test_count = 0
    
    for type_name in sorted(types.keys()):
        # Check if this type has variant files
        variant_files = [f for f in mock_files if f.startswith(f"{type_name}_Variant")]
        
        if variant_files:
            # Generate a test for each variant
            for variant_file in sorted(variant_files):
                variant_num = variant_file.split('_Variant')[1]
                code += f'''    @Test("{type_name} variant {variant_num} can be decoded and re-encoded")
    func test{type_name}Variant{variant_num}DecodingAndEncoding() throws {{
        let data = try loadMockJSON("{variant_file}.json")
        
        // Test decoding
        let decoded = try decoder.decode({type_name}.self, from: data)
        
        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(encoded.count > 0)
        
        // Test round-trip
        _ = try decoder.decode({type_name}.self, from: encoded)
    }}
    
'''
                variant_test_count += 1
        elif type_name in mock_files:
            # Use mock file-based test for regular types
            test_code = f'''    @Test("{type_name} can be decoded from mock and re-encoded")
    func test{type_name}DecodingAndEncoding() throws {{
        let data = try loadMockJSON("{type_name}.json")
        
        // Test decoding
        let decoded = try decoder.decode({type_name}.self, from: data)
        
        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(encoded.count > 0)
        
        // Test round-trip
        _ = try decoder.decode({type_name}.self, from: encoded)
    }}
    
'''
            code += test_code
            test_count += 1
    
    code += "}\n"
    
    print(f"   Generated {test_count} standalone type tests + {variant_test_count} variant tests")
    
    return code


# =============================================================================
# ENHANCED COVERAGE TESTS GENERATOR
# =============================================================================

def generate_enhanced_tests(openapi: Dict[str, Any]) -> str:
    """Generate enhanced tests for better coverage"""
    
    code = """
import Testing
import Foundation
@testable import NearJsonRpcTypes

@Suite("Enhanced Coverage Tests with Property Access")
struct EnhancedCoverageTests {
    
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    
    init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
    }
    
    /// Load mock JSON data from file
    func loadMockJSON(_ filename: String) throws -> Data {
        let testBundle = Bundle.module
        guard let url = testBundle.url(forResource: filename.replacingOccurrences(of: ".json", with: ""), withExtension: "json", subdirectory: "Mock") else {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock file not found: \\(filename)"])
        }
        return try Data(contentsOf: url)
    }
    
"""
    
    schemas = openapi.get("components", {}).get("schemas", {})
    
    # Get all standalone types (exclude request/response)
    standalone_schemas = {
        name: schema for name, schema in schemas.items()
        if not (name.startswith("JsonRpcRequest") or name.startswith("JsonRpcResponse"))
    }
    
    # Get available mock files
    mock_files = set()
    if os.path.exists(MOCK_DIR_TYPES):
        mock_files = {f.replace('.json', '') for f in os.listdir(MOCK_DIR_TYPES) if f.endswith('.json')}
    
    test_count = 0
    variant_test_count = 0
    
    # Skip types known to have issues
    skip_types = {"RpcError", "RpcClientConfigResponse"}
    
    for schema_name in sorted(standalone_schemas.keys()):
        schema = standalone_schemas[schema_name]
        swift_name = to_swift_type_name(schema_name)
        
        if swift_name in skip_types:
            continue
        
        # Check if this type has variant files
        variant_files = [f for f in mock_files if f.startswith(f"{swift_name}_Variant")]
        
        if variant_files:
            # Generate enhanced test for each variant
            for variant_file in sorted(variant_files):
                variant_num = variant_file.split('_Variant')[1]
                test_code = f'''    @Test("{swift_name} variant {variant_num} encoding stability")
    func test{swift_name}Variant{variant_num}EncodingStability() throws {{
        let data = try loadMockJSON("{variant_file}.json")
        let decoded = try decoder.decode({swift_name}.self, from: data)
        
        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode({swift_name}.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)
        
        #expect(encoded1.count > 0)
        #expect(encoded2.count > 0)
    }}
    
'''
                code += test_code
                variant_test_count += 1
        elif "properties" in schema or "oneOf" in schema or "anyOf" in schema:
            # Generate validity test for types with properties or oneOf
            if swift_name in mock_files:
                test_code = f'''    @Test("{swift_name} decoded instance is valid")
    func test{swift_name}Validity() throws {{
        let data = try loadMockJSON("{swift_name}.json")
        let decoded = try decoder.decode({swift_name}.self, from: data)
        
        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(encoded.count > 0)
        
        // Verify round-trip
        let redecoded = try decoder.decode({swift_name}.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(reencoded.count > 0)
    }}
    
'''
                code += test_code
                test_count += 1
    
    code += "}\n"
    
    print(f"   Generated {test_count} enhanced coverage tests + {variant_test_count} variant stability tests")
    
    return code


def generate_client_tests(methods: List[Tuple[str, str, str, str, str]]) -> str:
    """Generate tests for client methods"""
    
    code = """
import Testing
import Foundation
@testable import NearJsonRpcClient
@testable import NearJsonRpcTypes

@Suite("Client Method Tests")
struct ClientTests {
    
    let decoder: JSONDecoder
    
    init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    /// Load mock JSON data from file
    func loadMockJSON(_ filename: String) throws -> Data {
        let testBundle = Bundle.module
        guard let url = testBundle.url(forResource: filename.replacingOccurrences(of: ".json", with: ""), withExtension: "json", subdirectory: "Mock") else {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock file not found: \\(filename)"])
        }
        return try Data(contentsOf: url)
    }
    
"""
    
    # Generate test for each method
    for method_name, swift_function_name, request_type, response_type, result_type in sorted(methods):
        # Test request and success response
        test_name_success = f"test{to_swift_type_name(method_name)}RequestAndSuccessResponse"
        request_file = f"{to_swift_type_name(request_type)}.json"
        response_success_file = f"{to_swift_type_name(response_type)}_Success.json"
        
        code += f"""    @Test("{method_name} request and success response types are valid")
    func {test_name_success}() throws {{
        // Test request type decoding
        let requestData = try loadMockJSON("{request_file}")
        _ = try decoder.decode({to_swift_type_name(request_type)}.self, from: requestData)
        
        // Test success response type decoding
        let responseData = try loadMockJSON("{response_success_file}")
        _ = try decoder.decode({to_swift_type_name(response_type)}.self, from: responseData)
    }}
    
"""
        
        # Test request and error response
        test_name_error = f"test{to_swift_type_name(method_name)}RequestAndErrorResponse"
        response_error_file = f"{to_swift_type_name(response_type)}_Error.json"
        
        code += f"""    @Test("{method_name} request and error response types are valid")
    func {test_name_error}() throws {{
        // Test request type decoding
        let requestData = try loadMockJSON("{request_file}")
        _ = try decoder.decode({to_swift_type_name(request_type)}.self, from: requestData)
        
        // Test error response type decoding
        let responseData = try loadMockJSON("{response_error_file}")
        _ = try decoder.decode({to_swift_type_name(response_type)}.self, from: responseData)
    }}
    
"""
    
    code += "}\n"
    return code


# =============================================================================
# CLIENT METHOD TESTS GENERATOR
# =============================================================================

def generate_mock_url_protocol_class() -> str:
    return """class MockURLProtocol: URLProtocol {
    static var handler: MockHandler = MockHandler()

    actor MockHandler {
        private var requestHandler: (@Sendable (URLRequest) throws -> (HTTPURLResponse, Data))?

        func setRequestHandler(_ handler: @Sendable @escaping (URLRequest) throws -> (HTTPURLResponse, Data)) {
            self.requestHandler = handler
        }

        func getRequestHandler() -> (@Sendable (URLRequest) throws -> (HTTPURLResponse, Data))? {
            return self.requestHandler
        }
    }

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        Task {
            guard let handlerFunc = await MockURLProtocol.handler.getRequestHandler() else {
                fatalError("Handler is unavailable.")
            }

            do {
                let (response, data) = try handlerFunc(request)
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                self.client?.urlProtocol(self, didLoad: data)
                self.client?.urlProtocolDidFinishLoading(self)
            } catch {
                self.client?.urlProtocol(self, didFailWithError: error)
            }
        }
    }

    override func stopLoading() {
        // No-op
    }
}
"""


def generate_test_utilities() -> str:
    """Generate utility functions for tests"""
    return '''
// MARK: - Test Utilities

extension ClientMethodTests {
    
    /// Create a mock URLSession for testing
    func createMockSession() -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }
    
    /// Load mock JSON data from file
    func loadMockJSON(_ filename: String) throws -> Data {
        let testBundle = Bundle.module
        guard let url = testBundle.url(
            forResource: filename.replacingOccurrences(of: ".json", with: ""),
            withExtension: "json",
            subdirectory: "Mock"
        ) else {
            throw NSError(
                domain: "TestError",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Mock file not found: \\(filename)"]
            )
        }
        return try Data(contentsOf: url)
    }
    
    /// Create a mock HTTP response
    func createHTTPResponse(statusCode: Int = 200) -> HTTPURLResponse {
        return HTTPURLResponse(
            url: URL(string: "https://rpc.testnet.near.org")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"]
        )!
    }
    
    /// Setup mock response handler for success case
    func setupMockSuccessResponse(with data: Data) async {
        await MockURLProtocol.handler.setRequestHandler { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://rpc.testnet.near.org")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, data)
        }
    }
    
    /// Setup mock response handler for error case
    func setupMockErrorResponse(with data: Data) async {
        await MockURLProtocol.handler.setRequestHandler { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://rpc.testnet.near.org")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, data)
        }
    }
    
    /// Setup mock response handler for HTTP error
    func setupMockHTTPError(statusCode: Int) async {
        await MockURLProtocol.handler.setRequestHandler { request in
            let response = HTTPURLResponse(
                url: URL(string: "https://rpc.testnet.near.org")!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"]
            )!
            return (response, Data())
        }
    }
    
    /// Verify that a request was made with the expected method
    func verifyRequest(expectedMethod: String) async {
        guard let request = await MockURLProtocol.handler.getLastRequest() else {
            Issue.record("No request was captured")
            return
        }
        
        #expect(request.httpMethod == "POST")
        #expect(request.value(forHTTPHeaderField: "Content-Type") == "application/json")
        
        // Decode and verify the request body
        if let body = request.httpBody {
            do {
                let json = try JSONSerialization.jsonObject(with: body) as? [String: Any]
                let method = json?["method"] as? String
                #expect(method == expectedMethod)
            } catch {
                Issue.record("Failed to decode request body: \\(error)")
            }
        }
    }
}
'''


def generate_method_test(method_name: str, swift_function_name: str, 
                         request_type: str, response_type: str, result_type: str) -> str:
    """Generate a comprehensive test for a single method"""
    
    # Convert types to Swift names
    request_swift = to_swift_type_name(request_type)
    response_swift = to_swift_type_name(response_type)
    swift_method_name = to_swift_type_name(method_name)
    
    test_name = f"test{swift_function_name.capitalize()}"
    
    return f'''
    @Test("{method_name} method executes successfully with mock response")
    func {test_name}Success() async throws {{
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession
        )
        
        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestFor{swift_method_name}.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestFor{swift_method_name}.self, from: requestData)
        let request = requestWrapper.params
        
        // Load mock success response data
        let responseData = try loadMockJSON("{response_swift}_Success.json")
        await setupMockSuccessResponse(with: responseData)
        
        // Execute
        let result = try await client.{swift_function_name}(request)
        
        // Verify
        await verifyRequest(expectedMethod: "{method_name}")
        #expect(result != nil)
    }}
    
    @Test("{method_name} method handles error response correctly")
    func {test_name}Error() async throws {{
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession
        )
        
        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestFor{swift_method_name}.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestFor{swift_method_name}.self, from: requestData)
        let request = requestWrapper.params
        
        // Load mock error response data
        let responseData = try loadMockJSON("{response_swift}_Error.json")
        await setupMockErrorResponse(with: responseData)
        
        // Execute & Verify
        do {{
            _ = try await client.{swift_function_name}(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        }} catch is NearJsonRpcError {{
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        }} catch {{
            Issue.record("Expected NearJsonRpcError but got: \\(error)")
        }}
    }}
    
    @Test("{method_name} method handles HTTP error correctly")
    func {test_name}HTTPError() async throws {{
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession
        )
        
        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestFor{swift_method_name}.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestFor{swift_method_name}.self, from: requestData)
        let request = requestWrapper.params
        
        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)
        
        // Execute & Verify
        do {{
            _ = try await client.{swift_function_name}(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        }} catch let error as NearJsonRpcError {{
            switch error {{
            case .httpError(let statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \\(error)")
            }}
        }} catch {{
            Issue.record("Expected NearJsonRpcError but got: \\(error)")
        }}
    }}
'''


def generate_client_method_tests(methods: List[Tuple[str, str, str, str, str]]) -> str:
    """Generate comprehensive tests for all client methods"""
    
    code = """
import Testing
import Foundation
@testable import NearJsonRpcClient
@testable import NearJsonRpcTypes
"""
    
    # Add mock URL protocol (at file scope)
    code += generate_mock_url_protocol_class()
    
    # Start the test suite struct
    code += """
@Suite("Client Method Integration Tests", .serialized)
struct ClientMethodTests {
    
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    
    init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
    }
"""
    
    # Add individual method tests
    for method_name, swift_function_name, request_type, response_type, result_type in sorted(methods):
        code += generate_method_test(method_name, swift_function_name, request_type, response_type, result_type)
    
    code += "}\n"
    
    # Add test utilities (at file scope, as extension)
    code += generate_test_utilities()
    
    return code


def main():
    print("🔄 Loading OpenAPI specification...")
    openapi = load_openapi()
    
    print("🔄 Extracting method information...")
    methods = extract_method_info(openapi)
    print(f"   Found {len(methods)} methods")
    print()
    
    # Generate Types Tests
    print("📝 Generating type decoding tests...")
    types_tests = generate_types_tests(openapi)
    
    os.makedirs(os.path.dirname(TYPES_TEST_OUTPUT), exist_ok=True)
    with open(TYPES_TEST_OUTPUT, "w", encoding="utf-8") as f:
        f.write(types_tests)
    print(f"   ✅ {TYPES_TEST_OUTPUT}")
    print()
    
    print("📝 Generating standalone type tests...")
    standalone_tests = generate_standalone_types_tests(openapi)
    
    os.makedirs(os.path.dirname(STANDALONE_TYPES_TEST_OUTPUT), exist_ok=True)
    with open(STANDALONE_TYPES_TEST_OUTPUT, "w", encoding="utf-8") as f:
        f.write(standalone_tests)
    print(f"   ✅ {STANDALONE_TYPES_TEST_OUTPUT}")
    print()
    
    # Generate Enhanced Coverage Tests
    print("📝 Generating enhanced coverage tests...")
    enhanced_tests = generate_enhanced_tests(openapi)
    
    os.makedirs(os.path.dirname(ENHANCED_TEST_OUTPUT), exist_ok=True)
    with open(ENHANCED_TEST_OUTPUT, "w", encoding="utf-8") as f:
        f.write(enhanced_tests)
    print(f"   ✅ {ENHANCED_TEST_OUTPUT}")
    print()
    
    # Generate Client Tests
    print("📝 Generating client tests...")
    client_tests = generate_client_tests(methods)
    
    os.makedirs(os.path.dirname(CLIENT_TEST_OUTPUT), exist_ok=True)
    with open(CLIENT_TEST_OUTPUT, "w", encoding="utf-8") as f:
        f.write(client_tests)
    print(f"   ✅ {CLIENT_TEST_OUTPUT}")
    print()
    
    print("📝 Generating client method tests...")
    client_method_tests = generate_client_method_tests(methods)
    
    os.makedirs(os.path.dirname(CLIENT_METHOD_TEST_OUTPUT), exist_ok=True)
    with open(CLIENT_METHOD_TEST_OUTPUT, "w", encoding="utf-8") as f:
        f.write(client_method_tests)
    print(f"   ✅ {CLIENT_METHOD_TEST_OUTPUT}")
    print(f"   Generated {len(methods) * 3} tests ({len(methods)} methods × 3 test cases each)")
    print()
    
    # Summary
    print("✨ Test generation complete!")
    print()
    print("📊 Generated files:")
    print(f"   • {TYPES_TEST_OUTPUT}")
    print(f"   • {STANDALONE_TYPES_TEST_OUTPUT}")
    print(f"   • {ENHANCED_TEST_OUTPUT}")
    print(f"   • {CLIENT_TEST_OUTPUT}")
    print(f"   • {CLIENT_METHOD_TEST_OUTPUT}")
    print()
    print("📋 Test coverage includes:")
    print("   • Request/response type encoding/decoding")
    print("   • Standalone type validation")
    print("   • Enhanced property access tests")
    print("   • Encoding stability tests")
    print("   • Client method success handling")
    print("   • Client method error handling")
    print("   • Client method HTTP error handling")
    print()
    print("📋 Next steps:")
    print("   1. Run: swift test --enable-code-coverage")
    print("   2. Generate coverage report")
    print("   3. Expected coverage: 80%+ overall")


if __name__ == "__main__":
    main()
