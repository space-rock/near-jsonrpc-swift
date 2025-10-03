//
// Client.swift
// NEAR Protocol JSON-RPC Client
//

import Foundation
import NearJsonRpcTypes

public typealias NearRpcClient = NearJsonRpcClient

/// JSON-RPC client for the NEAR Protocol API
/// All methods are auto-generated from the OpenAPI specification
public actor NearJsonRpcClient {
    private let baseURL: URL
    private let session: URLSession
    
    /// Initialize client with base URL
    /// - Parameter baseURL: The base URL for the NEAR RPC endpoint
    public init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    /// Initialize client with base URL string
    /// - Parameter baseURLString: The base URL string for the NEAR RPC endpoint
    /// - Throws: `NearJsonRpcError.invalidURL` if the URL string is invalid
    public init(baseURLString: String, session: URLSession = .shared) throws {
        guard let url = URL(string: baseURLString) else {
            throw NearJsonRpcError.invalidURL(baseURLString)
        }
        self.init(baseURL: url, session: session)
    }
}

// MARK: - Core JSON-RPC Implementation

extension NearJsonRpcClient {
    
    /// Perform a JSON-RPC request with generated response type enum
    internal func performRequest<RequestType: Codable, ResponseType: Codable>(
        method: String,
        params: RequestType,
        responseType: ResponseType.Type
    ) async throws -> ResponseType {
        let request = JsonRpcRequest(
            id: UUID().uuidString,
            jsonrpc: "2.0",
            method: method,
            params: params
        )
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let requestData = try encoder.encode(request)
        
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = requestData
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NearJsonRpcError.invalidResponse
        }
        
        guard httpResponse.statusCode == 200 else {
            throw NearJsonRpcError.httpError(httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let jsonRpcResponse = try decoder.decode(ResponseType.self, from: data)
            return jsonRpcResponse
        } catch {
            throw NearJsonRpcError.decodingError(error)
        }
    }
}

// MARK: - Supporting Types

/// JSON-RPC request structure
public struct JsonRpcRequest<T: Codable>: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: T
    
    public init(id: String, jsonrpc: String, method: String, params: T) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

/// JSON-RPC client errors
public enum NearJsonRpcError: Error, LocalizedError {
    case invalidURL(String)
    case invalidResponse
    case httpError(Int)
    case rpcError(RpcError)
    case decodingError(Error)
    
    public var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "Invalid URL: \(url)"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let code):
            return "HTTP error: \(code)"
        case .rpcError(let error):
            return "RPC error: \(error)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        }
    }
}
