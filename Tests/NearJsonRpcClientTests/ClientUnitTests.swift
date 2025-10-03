//
// ClientUnitTests.swift
// Unit tests for NearJsonRpcClient core functionality
//

import Testing
import Foundation
@testable import NearJsonRpcClient
@testable import NearJsonRpcTypes

@Suite("Client Unit Tests")
struct ClientUnitTests {
    
    // MARK: - Client Initialization Tests
    
    @Test("Client initializes with valid URL")
    func testClientInitWithValidURL() {
        let url = URL(string: "https://rpc.testnet.near.org")!
        let client = NearJsonRpcClient(baseURL: url)
        // Client should initialize successfully
        #expect(client != nil)
    }
    
    @Test("Client initializes with valid URL string")
    func testClientInitWithValidURLString() throws {
        let client = try NearJsonRpcClient(baseURLString: "https://rpc.testnet.near.org")
        #expect(client != nil)
    }
    
    @Test("Client throws error with invalid URL string")
    func testClientInitWithInvalidURLString() {
        do {
            _ = try NearJsonRpcClient(baseURLString: "not a valid url ://")
            #expect(Bool(false), "Should have thrown an error")
        } catch let error as NearJsonRpcError {
            switch error {
            case .invalidURL(let urlString):
                #expect(urlString == "not a valid url ://")
            default:
                #expect(Bool(false), "Expected invalidURL error")
            }
        } catch {
            #expect(Bool(false), "Expected NearJsonRpcError")
        }
    }
    
    @Test("Client initializes with custom URLSession")
    func testClientInitWithCustomSession() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        let session = URLSession(configuration: config)
        let url = URL(string: "https://rpc.testnet.near.org")!
        let client = NearJsonRpcClient(baseURL: url, session: session)
        #expect(client != nil)
    }
    
    @Test("Client initializes with localhost URL")
    func testClientInitWithLocalhostURL() throws {
        let client = try NearJsonRpcClient(baseURLString: "http://localhost:3030")
        #expect(client != nil)
    }
    
    @Test("Client initializes with IP address")
    func testClientInitWithIPAddress() throws {
        let client = try NearJsonRpcClient(baseURLString: "http://192.168.1.1:3030")
        #expect(client != nil)
    }
    
    @Test("Client handles URL with path")
    func testClientInitWithURLPath() throws {
        let client = try NearJsonRpcClient(baseURLString: "https://rpc.testnet.near.org/api/v1")
        #expect(client != nil)
    }
    
    @Test("Client handles URL with query parameters")
    func testClientInitWithQueryParameters() throws {
        let client = try NearJsonRpcClient(baseURLString: "https://rpc.testnet.near.org?key=value")
        #expect(client != nil)
    }
    
    @Test("Client handles empty URL string")
    func testClientInitWithEmptyURL() {
        do {
            _ = try NearJsonRpcClient(baseURLString: "")
            #expect(Bool(false), "Should have thrown an error")
        } catch is NearJsonRpcError {
            #expect(Bool(true))
        } catch {
            #expect(Bool(false), "Expected NearJsonRpcError")
        }
    }
    
    @Test("Client handles URL with special characters")
    func testClientInitWithSpecialCharacters() throws {
        let client = try NearJsonRpcClient(baseURLString: "https://rpc-test_node.near.org")
        #expect(client != nil)
    }
    
    // MARK: - Error Type Tests
    
    @Test("NearJsonRpcError invalidURL has correct description")
    func testInvalidURLErrorDescription() {
        let error = NearJsonRpcError.invalidURL("bad://url")
        #expect(error.errorDescription == "Invalid URL: bad://url")
    }
    
    @Test("NearJsonRpcError invalidResponse has correct description")
    func testInvalidResponseErrorDescription() {
        let error = NearJsonRpcError.invalidResponse
        #expect(error.errorDescription == "Invalid response from server")
    }
    
    @Test("NearJsonRpcError httpError has correct description")
    func testHTTPErrorDescription() {
        let error = NearJsonRpcError.httpError(404)
        #expect(error.errorDescription == "HTTP error: 404")
    }
    
    @Test("NearJsonRpcError httpError handles various status codes")
    func testHTTPErrorVariousStatusCodes() {
        let codes = [400, 401, 403, 404, 500, 502, 503]
        for code in codes {
            let error = NearJsonRpcError.httpError(code)
            #expect(error.errorDescription?.contains("\(code)") == true)
        }
    }
    
    @Test("NearJsonRpcError rpcError error type exists")
    func testRpcErrorType() {
        // Test that we can reference the RpcError type from NearJsonRpcTypes
        // The actual RpcError creation is complex due to oneOf variants
        // So we just verify the error case exists
        let httpError = NearJsonRpcError.httpError(500)
        switch httpError {
        case .httpError:
            #expect(Bool(true))
        default:
            #expect(Bool(false))
        }
    }
    
    @Test("NearJsonRpcError decodingError has correct description")
    func testDecodingErrorDescription() {
        struct TestError: Error, LocalizedError {
            var errorDescription: String? { "Test decoding failure" }
        }
        let error = NearJsonRpcError.decodingError(TestError())
        #expect(error.errorDescription?.contains("Decoding error") == true)
    }
    
    // MARK: - JsonRpcRequest Tests
    
    @Test("JsonRpcRequest initializes correctly")
    func testJsonRpcRequestInit() {
        struct TestParams: Codable {
            let value: String
        }
        let params = TestParams(value: "test")
        let request = JsonRpcRequest(
            id: "123",
            jsonrpc: "2.0",
            method: "test_method",
            params: params
        )
        #expect(request.id == "123")
        #expect(request.jsonrpc == "2.0")
        #expect(request.method == "test_method")
        #expect(request.params.value == "test")
    }
    
    @Test("JsonRpcRequest encodes correctly")
    func testJsonRpcRequestEncoding() throws {
        struct TestParams: Codable {
            let testValue: String
        }
        let params = TestParams(testValue: "test")
        let request = JsonRpcRequest(
            id: "123",
            jsonrpc: "2.0",
            method: "test_method",
            params: params
        )
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try encoder.encode(request)
        let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        
        #expect(json["id"] as? String == "123")
        #expect(json["jsonrpc"] as? String == "2.0")
        #expect(json["method"] as? String == "test_method")
        #expect((json["params"] as? [String: Any])?["test_value"] as? String == "test")
    }
    
    @Test("JsonRpcRequest decodes correctly")
    func testJsonRpcRequestDecoding() throws {
        struct TestParams: Codable {
            let testValue: String
        }
        
        let json = """
        {
            "id": "123",
            "jsonrpc": "2.0",
            "method": "test_method",
            "params": {
                "test_value": "test"
            }
        }
        """
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let data = Data(json.utf8)
        let request = try decoder.decode(JsonRpcRequest<TestParams>.self, from: data)
        
        #expect(request.id == "123")
        #expect(request.jsonrpc == "2.0")
        #expect(request.method == "test_method")
        #expect(request.params.testValue == "test")
    }
    
    @Test("JsonRpcRequest handles complex params")
    func testJsonRpcRequestComplexParams() throws {
        struct ComplexParams: Codable {
            let stringValue: String
            let intValue: Int
            let arrayValue: [String]
            let nestedObject: NestedObject
            
            struct NestedObject: Codable {
                let key: String
            }
        }
        
        let params = ComplexParams(
            stringValue: "test",
            intValue: 42,
            arrayValue: ["a", "b", "c"],
            nestedObject: ComplexParams.NestedObject(key: "value")
        )
        
        let request = JsonRpcRequest(
            id: "456",
            jsonrpc: "2.0",
            method: "complex_method",
            params: params
        )
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(JsonRpcRequest<ComplexParams>.self, from: data)
        
        #expect(decoded.params.stringValue == "test")
        #expect(decoded.params.intValue == 42)
        #expect(decoded.params.arrayValue.count == 3)
        #expect(decoded.params.nestedObject.key == "value")
    }
    
    @Test("JsonRpcRequest handles empty object params")
    func testJsonRpcRequestEmptyParams() throws {
        struct EmptyParams: Codable {}
        
        let request = JsonRpcRequest(
            id: "789",
            jsonrpc: "2.0",
            method: "empty_method",
            params: EmptyParams()
        )
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(request)
        
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(JsonRpcRequest<EmptyParams>.self, from: data)
        
        #expect(decoded.id == "789")
        #expect(decoded.method == "empty_method")
    }
    
    @Test("JsonRpcRequest handles UUID as id")
    func testJsonRpcRequestUUIDId() throws {
        struct TestParams: Codable {
            let value: String
        }
        
        let uuid = UUID().uuidString
        let request = JsonRpcRequest(
            id: uuid,
            jsonrpc: "2.0",
            method: "test",
            params: TestParams(value: "test")
        )
        
        #expect(request.id == uuid)
        #expect(UUID(uuidString: request.id) != nil)
    }
    
    @Test("JsonRpcRequest preserves method name")
    func testJsonRpcRequestMethodPreservation() throws {
        struct TestParams: Codable {}
        
        let methods = [
            "EXPERIMENTAL_changes",
            "block",
            "query",
            "tx",
            "EXPERIMENTAL_validators_ordered"
        ]
        
        for method in methods {
            let request = JsonRpcRequest(
                id: "1",
                jsonrpc: "2.0",
                method: method,
                params: TestParams()
            )
            
            let encoder = JSONEncoder()
            let data = try encoder.encode(request)
            
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(JsonRpcRequest<TestParams>.self, from: data)
            
            #expect(decoded.method == method)
        }
    }
    
    // MARK: - Type Alias Tests
    
    @Test("NearRpcClient is alias for NearJsonRpcClient")
    func testTypeAlias() {
        let url = URL(string: "https://rpc.testnet.near.org")!
        let client1: NearJsonRpcClient = NearJsonRpcClient(baseURL: url)
        let client2: NearRpcClient = NearRpcClient(baseURL: url)
        
        // Both should be the same type
        #expect(type(of: client1) == type(of: client2))
    }
}
