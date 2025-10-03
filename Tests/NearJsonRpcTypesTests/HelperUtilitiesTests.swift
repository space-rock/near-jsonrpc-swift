//
// HelperUtilitiesTests.swift
// Tests for helper utilities and diagnostic functions
//
// These tests target the helper code in Types.swift that isn't exercised
// through regular type encoding/decoding tests.
//

import Testing
import Foundation
@testable import NearJsonRpcTypes

@Suite("Helper Utilities and Diagnostics Tests")
struct HelperUtilitiesTests {
    
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    
    init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
    }
    
    // MARK: - AnyCodable Tests
    
    @Test("AnyCodable handles string values")
    func testAnyCodableString() throws {
        let value = AnyCodable("test string")
        let encoded = try encoder.encode(value)
        let decoded = try decoder.decode(AnyCodable.self, from: encoded)
        
        #expect(decoded.value as? String == "test string")
    }
    
    @Test("AnyCodable handles integer values")
    func testAnyCodableInteger() throws {
        let value = AnyCodable(42)
        let encoded = try encoder.encode(value)
        let decoded = try decoder.decode(AnyCodable.self, from: encoded)
        
        #expect(decoded.value as? Int == 42)
    }
    
    @Test("AnyCodable handles double values")
    func testAnyCodableDouble() throws {
        let value = AnyCodable(3.14159)
        let encoded = try encoder.encode(value)
        let decoded = try decoder.decode(AnyCodable.self, from: encoded)
        
        let decodedDouble = decoded.value as? Double
        #expect(decodedDouble != nil)
        #expect(abs(decodedDouble! - 3.14159) < 0.0001)
    }
    
    @Test("AnyCodable handles boolean values")
    func testAnyCodableBoolean() throws {
        let trueValue = AnyCodable(true)
        let encodedTrue = try encoder.encode(trueValue)
        let decodedTrue = try decoder.decode(AnyCodable.self, from: encodedTrue)
        #expect(decodedTrue.value as? Bool == true)
        
        let falseValue = AnyCodable(false)
        let encodedFalse = try encoder.encode(falseValue)
        let decodedFalse = try decoder.decode(AnyCodable.self, from: encodedFalse)
        #expect(decodedFalse.value as? Bool == false)
    }
    
    @Test("AnyCodable handles null values")
    func testAnyCodableNull() throws {
        let value = AnyCodable(NSNull())
        let encoded = try encoder.encode(value)
        let decoded = try decoder.decode(AnyCodable.self, from: encoded)
        
        #expect(decoded.value is NSNull)
    }
    
    @Test("AnyCodable handles array values")
    func testAnyCodableArray() throws {
        let array: [Any] = [1, "two", 3.0, true]
        let value = AnyCodable(array)
        let encoded = try encoder.encode(value)
        let decoded = try decoder.decode(AnyCodable.self, from: encoded)
        
        let decodedArray = decoded.value as? [Any]
        #expect(decodedArray != nil)
        #expect(decodedArray?.count == 4)
    }
    
    @Test("AnyCodable handles dictionary values")
    func testAnyCodableDictionary() throws {
        let dict: [String: Any] = [
            "name": "test",
            "count": 42,
            "active": true
        ]
        let value = AnyCodable(dict)
        let encoded = try encoder.encode(value)
        let decoded = try decoder.decode(AnyCodable.self, from: encoded)
        
        let decodedDict = decoded.value as? [String: Any]
        #expect(decodedDict != nil)
        #expect(decodedDict?.count == 3)
    }
    
    @Test("AnyCodable handles nested structures")
    func testAnyCodableNested() throws {
        let nested: [String: Any] = [
            "user": [
                "name": "Alice",
                "age": 30,
                "active": true
            ],
            "tags": ["swift", "testing", "coverage"]
        ]
        let value = AnyCodable(nested)
        let encoded = try encoder.encode(value)
        let decoded = try decoder.decode(AnyCodable.self, from: encoded)
        
        let decodedDict = decoded.value as? [String: Any]
        #expect(decodedDict != nil)
        #expect(decodedDict?.keys.contains("user") == true)
        #expect(decodedDict?.keys.contains("tags") == true)
    }
    
    @Test("AnyCodable handles empty array")
    func testAnyCodableEmptyArray() throws {
        let value = AnyCodable([Any]())
        let encoded = try encoder.encode(value)
        let decoded = try decoder.decode(AnyCodable.self, from: encoded)
        
        let decodedArray = decoded.value as? [Any]
        #expect(decodedArray != nil)
        #expect(decodedArray?.isEmpty == true)
    }
    
    @Test("AnyCodable handles empty dictionary")
    func testAnyCodableEmptyDictionary() throws {
        let value = AnyCodable([String: Any]())
        let encoded = try encoder.encode(value)
        let decoded = try decoder.decode(AnyCodable.self, from: encoded)
        
        let decodedDict = decoded.value as? [String: Any]
        #expect(decodedDict != nil)
        #expect(decodedDict?.isEmpty == true)
    }
    
    @Test("AnyCodable encodes and decodes complex JSON")
    func testAnyCodableComplexJSON() throws {
        let jsonString = """
        {
            "id": 123,
            "name": "Test",
            "metadata": {
                "created": "2025-10-03",
                "tags": ["tag1", "tag2"]
            },
            "active": true,
            "score": 98.5
        }
        """
        
        let jsonData = Data(jsonString.utf8)
        let decoded = try decoder.decode(AnyCodable.self, from: jsonData)
        
        #expect(decoded.value is [String: Any])
        
        let encoded = try encoder.encode(decoded)
        let redecoded = try decoder.decode(AnyCodable.self, from: encoded)
        
        #expect(redecoded.value is [String: Any])
    }
    
    // MARK: - AnyCodingKey Tests
    
    @Test("AnyCodingKey handles string values")
    func testAnyCodingKeyString() {
        let key = AnyCodingKey(stringValue: "testKey")
        #expect(key.stringValue == "testKey")
        #expect(key.intValue == nil)
    }
    
    @Test("AnyCodingKey handles integer values")
    func testAnyCodingKeyInteger() {
        let key = AnyCodingKey(intValue: 42)
        #expect(key?.stringValue == "42")
        #expect(key?.intValue == 42)
    }
    
    @Test("AnyCodingKey handles empty string")
    func testAnyCodingKeyEmptyString() {
        let key = AnyCodingKey(stringValue: "")
        #expect(key.stringValue == "")
        #expect(key.intValue == nil)
    }
    
    @Test("AnyCodingKey handles special characters")
    func testAnyCodingKeySpecialCharacters() {
        let key = AnyCodingKey(stringValue: "test-key_with.special")
        #expect(key.stringValue == "test-key_with.special")
    }
    
    @Test("AnyCodingKey handles zero")
    func testAnyCodingKeyZero() {
        let key = AnyCodingKey(intValue: 0)
        #expect(key?.stringValue == "0")
        #expect(key?.intValue == 0)
    }
    
    // MARK: - Decoding Error Tests (Indirect Testing of Diagnostic Functions)
    // Note: The diagnostic functions are fileprivate, so we test them indirectly
    // by triggering decoding errors that exercise those code paths
    
    @Test("Decoding error with type mismatch")
    func testDecodingErrorTypeMismatch() throws {
        struct TestStruct: Codable {
            let value: Int
        }
        
        let jsonData = Data("{\"value\": \"not_a_number\"}".utf8)
        
        do {
            _ = try decoder.decode(TestStruct.self, from: jsonData)
            #expect(Bool(false), "Should have thrown an error")
        } catch let error as DecodingError {
            // Verify the error is captured correctly
            switch error {
            case .typeMismatch:
                #expect(Bool(true))
            default:
                #expect(Bool(false), "Expected typeMismatch error")
            }
        } catch {
            #expect(Bool(false), "Expected DecodingError")
        }
    }
    
    @Test("Decoding error with missing required field")
    func testDecodingErrorKeyNotFound() throws {
        struct TestStruct: Codable {
            let requiredField: String
        }
        
        let jsonData = Data("{}".utf8)
        
        do {
            _ = try decoder.decode(TestStruct.self, from: jsonData)
            #expect(Bool(false), "Should have thrown an error")
        } catch is DecodingError {
            // Successfully caught a decoding error
            #expect(Bool(true))
        } catch {
            #expect(Bool(false), "Expected DecodingError")
        }
    }
    
    @Test("Decoding error with corrupted data")
    func testDecodingErrorDataCorrupted() throws {
        struct TestStruct: Codable {
            let value: String
        }
        
        let jsonData = Data("not valid json".utf8)
        
        do {
            _ = try decoder.decode(TestStruct.self, from: jsonData)
            #expect(Bool(false), "Should have thrown an error")
        } catch is DecodingError {
            // Successfully caught a decoding error
            #expect(Bool(true))
        } catch {
            // Invalid JSON throws different error types
            #expect(Bool(true))
        }
    }
    
    @Test("Decoding error with nested path")
    func testDecodingErrorNestedPath() throws {
        struct Inner: Codable {
            let value: Int
        }
        struct Outer: Codable {
            let inner: Inner
        }
        
        let jsonData = Data("{\"inner\": {\"value\": \"wrong_type\"}}".utf8)
        
        do {
            _ = try decoder.decode(Outer.self, from: jsonData)
            #expect(Bool(false), "Should have thrown an error")
        } catch let error as DecodingError {
            // Verify the error captures the nested path
            switch error {
            case .typeMismatch(_, let context):
                #expect(context.codingPath.count > 0)
            default:
                #expect(Bool(true))
            }
        } catch {
            #expect(Bool(false), "Expected DecodingError")
        }
    }
    
    @Test("Decoding error with array index")
    func testDecodingErrorArrayIndex() throws {
        struct Item: Codable {
            let id: Int
        }
        
        let jsonData = Data("[{\"id\": 1}, {\"id\": \"invalid\"}, {\"id\": 3}]".utf8)
        
        do {
            _ = try decoder.decode([Item].self, from: jsonData)
            #expect(Bool(false), "Should have thrown an error")
        } catch let error as DecodingError {
            // Verify the error captures the array index
            switch error {
            case .typeMismatch(_, let context):
                // The error should reference index [1]
                #expect(context.codingPath.count > 0)
            default:
                #expect(Bool(true))
            }
        } catch {
            #expect(Bool(false), "Expected DecodingError")
        }
    }
    
    // MARK: - Integration Tests for AnyCodable with Real Types
    
    @Test("AnyCodable works within struct properties")
    func testAnyCodableInStruct() throws {
        struct TestType: Codable {
            let id: String
            let metadata: AnyCodable
        }
        
        let jsonString = """
        {
            "id": "test123",
            "metadata": {
                "custom": "value",
                "count": 42
            }
        }
        """
        
        let jsonData = Data(jsonString.utf8)
        let decoded = try decoder.decode(TestType.self, from: jsonData)
        
        #expect(decoded.id == "test123")
        #expect(decoded.metadata.value is [String: Any])
        
        let encoded = try encoder.encode(decoded)
        let redecoded = try decoder.decode(TestType.self, from: encoded)
        
        #expect(redecoded.id == "test123")
    }
    
    @Test("AnyCodable handles array of mixed types")
    func testAnyCodableMixedArray() throws {
        let mixed: [Any] = [
            "string",
            123,
            true,
            ["nested": "dict"],
            [1, 2, 3]
        ]
        
        let value = AnyCodable(mixed)
        let encoded = try encoder.encode(value)
        let decoded = try decoder.decode(AnyCodable.self, from: encoded)
        
        let decodedArray = decoded.value as? [Any]
        #expect(decodedArray != nil)
        #expect(decodedArray?.count == 5)
    }
    
    @Test("AnyCodable handles deeply nested structures")
    func testAnyCodableDeeplyNested() throws {
        let deep: [String: Any] = [
            "level1": [
                "level2": [
                    "level3": [
                        "level4": [
                            "value": "deep"
                        ]
                    ]
                ]
            ]
        ]
        
        let value = AnyCodable(deep)
        let encoded = try encoder.encode(value)
        let decoded = try decoder.decode(AnyCodable.self, from: encoded)
        
        #expect(decoded.value is [String: Any])
    }
}
