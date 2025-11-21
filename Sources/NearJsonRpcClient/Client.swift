import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
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
    public init(baseURLString: String, session: URLSession = .shared) throws(NearJsonRpcError) {
        guard let url = URL(string: baseURLString) else {
            throw NearJsonRpcError.invalidURL(baseURLString)
        }
        self.init(baseURL: url, session: session)
    }
}

// MARK: - Core JSON-RPC Implementation

extension NearJsonRpcClient {
    /// Perform a JSON-RPC request with generated response type enum
    func performRequest<ResponseType: Codable>(
        method: String,
        params: some Codable,
        responseType _: ResponseType.Type,
    ) async throws(NearJsonRpcError) -> ResponseType {
        let request = JsonRpcRequest(
            id: UUID().uuidString,
            jsonrpc: "2.0",
            method: method,
            params: params,
        )

        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let requestData: Data
        do {
            requestData = try encoder.encode(request)
        } catch {
            throw NearJsonRpcError.decodingError(error)
        }

        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = requestData

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: urlRequest)
        } catch {
            throw NearJsonRpcError.decodingError(error)
        }

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
    case rpcError(RpcErrorDetails)
    case decodingError(Error)

    public var errorDescription: String? {
        switch self {
        case let .invalidURL(url):
            "Invalid URL: \(url)"
        case .invalidResponse:
            "Invalid response from server"
        case let .httpError(code):
            "HTTP error: \(code)"
        case let .rpcError(details):
            "RPC error: \(details)"
        case let .decodingError(error):
            "Decoding error: \(error.localizedDescription)"
        }
    }
}
