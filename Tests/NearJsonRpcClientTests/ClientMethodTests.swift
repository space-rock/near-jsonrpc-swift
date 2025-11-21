
import Foundation
import Testing
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
@testable import NearJsonRpcClient
@testable import NearJsonRpcTypes

@preconcurrency class MockURLProtocol: URLProtocol {
    nonisolated(unsafe) static var handler: MockHandler = .init()

    actor MockHandler {
        private var requestHandler: (@Sendable (URLRequest) throws -> (HTTPURLResponse, Data))?
        private var lastRequest: URLRequest?

        func setRequestHandler(_ handler: @Sendable @escaping (URLRequest) throws -> (HTTPURLResponse, Data)) {
            requestHandler = handler
        }

        func getRequestHandler() -> (@Sendable (URLRequest) throws -> (HTTPURLResponse, Data))? {
            requestHandler
        }

        func captureRequest(_ request: URLRequest) {
            lastRequest = request
        }

        func getLastRequest() -> URLRequest? {
            lastRequest
        }
    }

    override class func canInit(with _: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        let currentRequest = request
        let protocolClient = client

        Task {
            await MockURLProtocol.handler.captureRequest(currentRequest)

            guard let handlerFunc = await MockURLProtocol.handler.getRequestHandler() else {
                fatalError("Handler is unavailable.")
            }

            do {
                let (response, data) = try handlerFunc(currentRequest)
                protocolClient?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                protocolClient?.urlProtocol(self, didLoad: data)
                protocolClient?.urlProtocolDidFinishLoading(self)
            } catch {
                protocolClient?.urlProtocol(self, didFailWithError: error)
            }
        }
    }

    override func stopLoading() {
        // No-op
    }
}

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

    @Test("EXPERIMENTAL_changes method executes successfully with mock response")
    func experimentalchangesSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALChanges.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALChanges.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.experimentalChanges(request)

        // Verify
        await verifyRequest(expectedMethod: "EXPERIMENTAL_changes")
        #expect(result != nil)
    }

    @Test("EXPERIMENTAL_changes method handles error response correctly")
    func experimentalchangesError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALChanges.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALChanges.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.experimentalChanges(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_changes method handles HTTP error correctly")
    func experimentalchangesHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALChanges.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALChanges.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.experimentalChanges(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_changes_in_block method executes successfully with mock response")
    func experimentalchangesinblockSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALChangesInBlock.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALChangesInBlock.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError_Success.json",
            )
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.experimentalChangesInBlock(request)

        // Verify
        await verifyRequest(expectedMethod: "EXPERIMENTAL_changes_in_block")
        #expect(result != nil)
    }

    @Test("EXPERIMENTAL_changes_in_block method handles error response correctly")
    func experimentalchangesinblockError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALChangesInBlock.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALChangesInBlock.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.experimentalChangesInBlock(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_changes_in_block method handles HTTP error correctly")
    func experimentalchangesinblockHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALChangesInBlock.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALChangesInBlock.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.experimentalChangesInBlock(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_congestion_level method executes successfully with mock response")
    func experimentalcongestionlevelSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALCongestionLevel.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALCongestionLevel.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.experimentalCongestionLevel(request)

        // Verify
        await verifyRequest(expectedMethod: "EXPERIMENTAL_congestion_level")
        #expect(result != nil)
    }

    @Test("EXPERIMENTAL_congestion_level method handles error response correctly")
    func experimentalcongestionlevelError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALCongestionLevel.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALCongestionLevel.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.experimentalCongestionLevel(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_congestion_level method handles HTTP error correctly")
    func experimentalcongestionlevelHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALCongestionLevel.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALCongestionLevel.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.experimentalCongestionLevel(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_genesis_config method executes successfully with mock response")
    func experimentalgenesisconfigSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALGenesisConfig.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALGenesisConfig.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData = try loadMockJSON("JsonRpcResponseForGenesisConfigAndGenesisConfigError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.experimentalGenesisConfig(request)

        // Verify
        await verifyRequest(expectedMethod: "EXPERIMENTAL_genesis_config")
        #expect(result != nil)
    }

    @Test("EXPERIMENTAL_genesis_config method handles error response correctly")
    func experimentalgenesisconfigError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALGenesisConfig.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALGenesisConfig.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForGenesisConfigAndGenesisConfigError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.experimentalGenesisConfig(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_genesis_config method handles HTTP error correctly")
    func experimentalgenesisconfigHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALGenesisConfig.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALGenesisConfig.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.experimentalGenesisConfig(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_light_client_block_proof method executes successfully with mock response")
    func experimentallightclientblockproofSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALLightClientBlockProof.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(
            JsonRpcRequestForEXPERIMENTALLightClientBlockProof.self,
            from: requestData,
        )
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError_Success.json",
            )
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.experimentalLightClientBlockProof(request)

        // Verify
        await verifyRequest(expectedMethod: "EXPERIMENTAL_light_client_block_proof")
        #expect(result != nil)
    }

    @Test("EXPERIMENTAL_light_client_block_proof method handles error response correctly")
    func experimentallightclientblockproofError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALLightClientBlockProof.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(
            JsonRpcRequestForEXPERIMENTALLightClientBlockProof.self,
            from: requestData,
        )
        let request = requestWrapper.params

        // Load mock error response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.experimentalLightClientBlockProof(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_light_client_block_proof method handles HTTP error correctly")
    func experimentallightclientblockproofHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALLightClientBlockProof.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(
            JsonRpcRequestForEXPERIMENTALLightClientBlockProof.self,
            from: requestData,
        )
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.experimentalLightClientBlockProof(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_light_client_proof method executes successfully with mock response")
    func experimentallightclientproofSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALLightClientProof.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALLightClientProof.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError_Success.json",
            )
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.experimentalLightClientProof(request)

        // Verify
        await verifyRequest(expectedMethod: "EXPERIMENTAL_light_client_proof")
        #expect(result != nil)
    }

    @Test("EXPERIMENTAL_light_client_proof method handles error response correctly")
    func experimentallightclientproofError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALLightClientProof.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALLightClientProof.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError_Error.json",
            )
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.experimentalLightClientProof(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_light_client_proof method handles HTTP error correctly")
    func experimentallightclientproofHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALLightClientProof.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALLightClientProof.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.experimentalLightClientProof(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_maintenance_windows method executes successfully with mock response")
    func experimentalmaintenancewindowsSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALMaintenanceWindows.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALMaintenanceWindows.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.experimentalMaintenanceWindows(request)

        // Verify
        await verifyRequest(expectedMethod: "EXPERIMENTAL_maintenance_windows")
        #expect(result != nil)
    }

    @Test("EXPERIMENTAL_maintenance_windows method handles error response correctly")
    func experimentalmaintenancewindowsError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALMaintenanceWindows.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALMaintenanceWindows.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.experimentalMaintenanceWindows(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_maintenance_windows method handles HTTP error correctly")
    func experimentalmaintenancewindowsHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALMaintenanceWindows.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALMaintenanceWindows.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.experimentalMaintenanceWindows(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_protocol_config method executes successfully with mock response")
    func experimentalprotocolconfigSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALProtocolConfig.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALProtocolConfig.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.experimentalProtocolConfig(request)

        // Verify
        await verifyRequest(expectedMethod: "EXPERIMENTAL_protocol_config")
        #expect(result != nil)
    }

    @Test("EXPERIMENTAL_protocol_config method handles error response correctly")
    func experimentalprotocolconfigError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALProtocolConfig.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALProtocolConfig.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.experimentalProtocolConfig(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_protocol_config method handles HTTP error correctly")
    func experimentalprotocolconfigHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALProtocolConfig.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALProtocolConfig.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.experimentalProtocolConfig(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_receipt method executes successfully with mock response")
    func experimentalreceiptSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALReceipt.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALReceipt.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.experimentalReceipt(request)

        // Verify
        await verifyRequest(expectedMethod: "EXPERIMENTAL_receipt")
        #expect(result != nil)
    }

    @Test("EXPERIMENTAL_receipt method handles error response correctly")
    func experimentalreceiptError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALReceipt.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALReceipt.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.experimentalReceipt(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_receipt method handles HTTP error correctly")
    func experimentalreceiptHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALReceipt.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALReceipt.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.experimentalReceipt(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_split_storage_info method executes successfully with mock response")
    func experimentalsplitstorageinfoSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALSplitStorageInfo.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALSplitStorageInfo.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.experimentalSplitStorageInfo(request)

        // Verify
        await verifyRequest(expectedMethod: "EXPERIMENTAL_split_storage_info")
        #expect(result != nil)
    }

    @Test("EXPERIMENTAL_split_storage_info method handles error response correctly")
    func experimentalsplitstorageinfoError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALSplitStorageInfo.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALSplitStorageInfo.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.experimentalSplitStorageInfo(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_split_storage_info method handles HTTP error correctly")
    func experimentalsplitstorageinfoHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALSplitStorageInfo.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALSplitStorageInfo.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.experimentalSplitStorageInfo(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_tx_status method executes successfully with mock response")
    func experimentaltxstatusSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALTxStatus.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALTxStatus.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.experimentalTxStatus(request)

        // Verify
        await verifyRequest(expectedMethod: "EXPERIMENTAL_tx_status")
        #expect(result != nil)
    }

    @Test("EXPERIMENTAL_tx_status method handles error response correctly")
    func experimentaltxstatusError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALTxStatus.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALTxStatus.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.experimentalTxStatus(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_tx_status method handles HTTP error correctly")
    func experimentaltxstatusHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALTxStatus.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALTxStatus.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.experimentalTxStatus(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_validators_ordered method executes successfully with mock response")
    func experimentalvalidatorsorderedSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALValidatorsOrdered.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALValidatorsOrdered.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.experimentalValidatorsOrdered(request)

        // Verify
        await verifyRequest(expectedMethod: "EXPERIMENTAL_validators_ordered")
        #expect(result != nil)
    }

    @Test("EXPERIMENTAL_validators_ordered method handles error response correctly")
    func experimentalvalidatorsorderedError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALValidatorsOrdered.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALValidatorsOrdered.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.experimentalValidatorsOrdered(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("EXPERIMENTAL_validators_ordered method handles HTTP error correctly")
    func experimentalvalidatorsorderedHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALValidatorsOrdered.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForEXPERIMENTALValidatorsOrdered.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.experimentalValidatorsOrdered(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("block method executes successfully with mock response")
    func blockSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForBlock.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForBlock.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcBlockResponseAndRpcBlockError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.block(request)

        // Verify
        await verifyRequest(expectedMethod: "block")
        #expect(result != nil)
    }

    @Test("block method handles error response correctly")
    func blockError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForBlock.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForBlock.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcBlockResponseAndRpcBlockError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.block(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("block method handles HTTP error correctly")
    func blockHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForBlock.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForBlock.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.block(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("block_effects method executes successfully with mock response")
    func blockeffectsSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForBlockEffects.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForBlockEffects.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError_Success.json",
            )
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.blockEffects(request)

        // Verify
        await verifyRequest(expectedMethod: "block_effects")
        #expect(result != nil)
    }

    @Test("block_effects method handles error response correctly")
    func blockeffectsError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForBlockEffects.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForBlockEffects.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.blockEffects(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("block_effects method handles HTTP error correctly")
    func blockeffectsHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForBlockEffects.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForBlockEffects.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.blockEffects(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("broadcast_tx_async method executes successfully with mock response")
    func broadcasttxasyncSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForBroadcastTxAsync.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForBroadcastTxAsync.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData = try loadMockJSON("JsonRpcResponseForCryptoHashAndRpcTransactionError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.broadcastTxAsync(request)

        // Verify
        await verifyRequest(expectedMethod: "broadcast_tx_async")
        #expect(result != nil)
    }

    @Test("broadcast_tx_async method handles error response correctly")
    func broadcasttxasyncError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForBroadcastTxAsync.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForBroadcastTxAsync.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForCryptoHashAndRpcTransactionError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.broadcastTxAsync(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("broadcast_tx_async method handles HTTP error correctly")
    func broadcasttxasyncHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForBroadcastTxAsync.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForBroadcastTxAsync.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.broadcastTxAsync(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("broadcast_tx_commit method executes successfully with mock response")
    func broadcasttxcommitSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForBroadcastTxCommit.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForBroadcastTxCommit.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.broadcastTxCommit(request)

        // Verify
        await verifyRequest(expectedMethod: "broadcast_tx_commit")
        #expect(result != nil)
    }

    @Test("broadcast_tx_commit method handles error response correctly")
    func broadcasttxcommitError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForBroadcastTxCommit.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForBroadcastTxCommit.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.broadcastTxCommit(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("broadcast_tx_commit method handles HTTP error correctly")
    func broadcasttxcommitHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForBroadcastTxCommit.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForBroadcastTxCommit.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.broadcastTxCommit(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("changes method executes successfully with mock response")
    func changesSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForChanges.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForChanges.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.changes(request)

        // Verify
        await verifyRequest(expectedMethod: "changes")
        #expect(result != nil)
    }

    @Test("changes method handles error response correctly")
    func changesError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForChanges.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForChanges.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.changes(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("changes method handles HTTP error correctly")
    func changesHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForChanges.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForChanges.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.changes(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("chunk method executes successfully with mock response")
    func chunkSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForChunk.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForChunk.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcChunkResponseAndRpcChunkError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.chunk(request)

        // Verify
        await verifyRequest(expectedMethod: "chunk")
        #expect(result != nil)
    }

    @Test("chunk method handles error response correctly")
    func chunkError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForChunk.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForChunk.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcChunkResponseAndRpcChunkError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.chunk(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("chunk method handles HTTP error correctly")
    func chunkHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForChunk.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForChunk.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.chunk(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("client_config method executes successfully with mock response")
    func clientconfigSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForClientConfig.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForClientConfig.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.clientConfig(request)

        // Verify
        await verifyRequest(expectedMethod: "client_config")
        #expect(result != nil)
    }

    @Test("client_config method handles error response correctly")
    func clientconfigError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForClientConfig.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForClientConfig.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.clientConfig(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("client_config method handles HTTP error correctly")
    func clientconfigHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForClientConfig.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForClientConfig.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.clientConfig(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("gas_price method executes successfully with mock response")
    func gaspriceSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForGasPrice.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForGasPrice.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.gasPrice(request)

        // Verify
        await verifyRequest(expectedMethod: "gas_price")
        #expect(result != nil)
    }

    @Test("gas_price method handles error response correctly")
    func gaspriceError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForGasPrice.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForGasPrice.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.gasPrice(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("gas_price method handles HTTP error correctly")
    func gaspriceHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForGasPrice.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForGasPrice.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.gasPrice(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("genesis_config method executes successfully with mock response")
    func genesisconfigSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForGenesisConfig.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForGenesisConfig.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData = try loadMockJSON("JsonRpcResponseForGenesisConfigAndGenesisConfigError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.genesisConfig(request)

        // Verify
        await verifyRequest(expectedMethod: "genesis_config")
        #expect(result != nil)
    }

    @Test("genesis_config method handles error response correctly")
    func genesisconfigError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForGenesisConfig.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForGenesisConfig.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForGenesisConfigAndGenesisConfigError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.genesisConfig(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("genesis_config method handles HTTP error correctly")
    func genesisconfigHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForGenesisConfig.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForGenesisConfig.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.genesisConfig(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("health method executes successfully with mock response")
    func healthSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForHealth.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForHealth.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData = try loadMockJSON("JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.health(request)

        // Verify
        await verifyRequest(expectedMethod: "health")
        #expect(result != nil)
    }

    @Test("health method handles error response correctly")
    func healthError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForHealth.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForHealth.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.health(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("health method handles HTTP error correctly")
    func healthHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForHealth.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForHealth.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.health(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("light_client_proof method executes successfully with mock response")
    func lightclientproofSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForLightClientProof.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForLightClientProof.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError_Success.json",
            )
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.lightClientProof(request)

        // Verify
        await verifyRequest(expectedMethod: "light_client_proof")
        #expect(result != nil)
    }

    @Test("light_client_proof method handles error response correctly")
    func lightclientproofError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForLightClientProof.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForLightClientProof.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError_Error.json",
            )
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.lightClientProof(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("light_client_proof method handles HTTP error correctly")
    func lightclientproofHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForLightClientProof.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForLightClientProof.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.lightClientProof(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("maintenance_windows method executes successfully with mock response")
    func maintenancewindowsSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForMaintenanceWindows.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForMaintenanceWindows.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.maintenanceWindows(request)

        // Verify
        await verifyRequest(expectedMethod: "maintenance_windows")
        #expect(result != nil)
    }

    @Test("maintenance_windows method handles error response correctly")
    func maintenancewindowsError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForMaintenanceWindows.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForMaintenanceWindows.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.maintenanceWindows(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("maintenance_windows method handles HTTP error correctly")
    func maintenancewindowsHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForMaintenanceWindows.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForMaintenanceWindows.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.maintenanceWindows(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("network_info method executes successfully with mock response")
    func networkinfoSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForNetworkInfo.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForNetworkInfo.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.networkInfo(request)

        // Verify
        await verifyRequest(expectedMethod: "network_info")
        #expect(result != nil)
    }

    @Test("network_info method handles error response correctly")
    func networkinfoError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForNetworkInfo.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForNetworkInfo.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.networkInfo(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("network_info method handles HTTP error correctly")
    func networkinfoHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForNetworkInfo.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForNetworkInfo.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.networkInfo(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("next_light_client_block method executes successfully with mock response")
    func nextlightclientblockSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForNextLightClientBlock.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForNextLightClientBlock.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError_Success.json",
            )
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.nextLightClientBlock(request)

        // Verify
        await verifyRequest(expectedMethod: "next_light_client_block")
        #expect(result != nil)
    }

    @Test("next_light_client_block method handles error response correctly")
    func nextlightclientblockError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForNextLightClientBlock.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForNextLightClientBlock.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError_Error.json",
            )
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.nextLightClientBlock(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("next_light_client_block method handles HTTP error correctly")
    func nextlightclientblockHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForNextLightClientBlock.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForNextLightClientBlock.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.nextLightClientBlock(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("query method executes successfully with mock response")
    func querySuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForQuery.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForQuery.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcQueryResponseAndRpcQueryError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.query(request)

        // Verify
        await verifyRequest(expectedMethod: "query")
        #expect(result != nil)
    }

    @Test("query method handles error response correctly")
    func queryError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForQuery.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForQuery.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcQueryResponseAndRpcQueryError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.query(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("query method handles HTTP error correctly")
    func queryHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForQuery.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForQuery.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.query(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("send_tx method executes successfully with mock response")
    func sendtxSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForSendTx.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForSendTx.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.sendTx(request)

        // Verify
        await verifyRequest(expectedMethod: "send_tx")
        #expect(result != nil)
    }

    @Test("send_tx method handles error response correctly")
    func sendtxError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForSendTx.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForSendTx.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.sendTx(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("send_tx method handles HTTP error correctly")
    func sendtxHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForSendTx.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForSendTx.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.sendTx(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("status method executes successfully with mock response")
    func statusSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForStatus.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForStatus.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcStatusResponseAndRpcStatusError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.status(request)

        // Verify
        await verifyRequest(expectedMethod: "status")
        #expect(result != nil)
    }

    @Test("status method handles error response correctly")
    func statusError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForStatus.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForStatus.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcStatusResponseAndRpcStatusError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.status(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("status method handles HTTP error correctly")
    func statusHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForStatus.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForStatus.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.status(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("tx method executes successfully with mock response")
    func txSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForTx.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForTx.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.tx(request)

        // Verify
        await verifyRequest(expectedMethod: "tx")
        #expect(result != nil)
    }

    @Test("tx method handles error response correctly")
    func txError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForTx.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForTx.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.tx(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("tx method handles HTTP error correctly")
    func txHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForTx.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForTx.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.tx(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("validators method executes successfully with mock response")
    func validatorsSuccess() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForValidators.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForValidators.self, from: requestData)
        let request = requestWrapper.params

        // Load mock success response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError_Success.json")
        await setupMockSuccessResponse(with: responseData)

        // Execute
        let result = try await client.validators(request)

        // Verify
        await verifyRequest(expectedMethod: "validators")
        #expect(result != nil)
    }

    @Test("validators method handles error response correctly")
    func validatorsError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForValidators.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForValidators.self, from: requestData)
        let request = requestWrapper.params

        // Load mock error response data
        let responseData = try loadMockJSON("JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError_Error.json")
        await setupMockErrorResponse(with: responseData)

        // Execute & Verify
        do {
            _ = try await client.validators(request)
            Issue.record("Expected method to throw RPC error but it succeeded")
        } catch is NearJsonRpcError {
            // Expected to catch NearJsonRpcError (including rpcError case)
            #expect(true)
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }

    @Test("validators method handles HTTP error correctly")
    func validatorsHTTPError() async throws {
        // Setup
        let mockSession = createMockSession()
        let client = NearJsonRpcClient(
            baseURL: URL(string: "https://rpc.testnet.near.org")!,
            session: mockSession,
        )

        // Load mock request data and extract params
        let requestData = try loadMockJSON("JsonRpcRequestForValidators.json")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let requestWrapper = try decoder.decode(JsonRpcRequestForValidators.self, from: requestData)
        let request = requestWrapper.params

        // Setup HTTP error response
        await setupMockHTTPError(statusCode: 500)

        // Execute & Verify
        do {
            _ = try await client.validators(request)
            Issue.record("Expected method to throw HTTP error but it succeeded")
        } catch let error as NearJsonRpcError {
            switch error {
            case let .httpError(statusCode):
                #expect(statusCode == 500)
            case .invalidResponse:
                // Some methods might throw invalidResponse instead
                #expect(true)
            default:
                Issue.record("Expected httpError but got: \(error)")
            }
        } catch {
            Issue.record("Expected NearJsonRpcError but got: \(error)")
        }
    }
}

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
            subdirectory: "Mock",
        ) else {
            throw NSError(
                domain: "TestError",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Mock file not found: \(filename)"],
            )
        }
        return try Data(contentsOf: url)
    }

    /// Create a mock HTTP response
    func createHTTPResponse(statusCode: Int = 200) -> HTTPURLResponse {
        HTTPURLResponse(
            url: URL(string: "https://rpc.testnet.near.org")!,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"],
        )!
    }

    /// Setup mock response handler for success case
    func setupMockSuccessResponse(with data: Data) async {
        await MockURLProtocol.handler.setRequestHandler { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://rpc.testnet.near.org")!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"],
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
                headerFields: ["Content-Type": "application/json"],
            )!
            return (response, data)
        }
    }

    /// Setup mock response handler for HTTP error
    func setupMockHTTPError(statusCode: Int) async {
        await MockURLProtocol.handler.setRequestHandler { _ in
            let response = HTTPURLResponse(
                url: URL(string: "https://rpc.testnet.near.org")!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: ["Content-Type": "application/json"],
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
                let method: String? = json?["method"] as? String
                #expect(method == expectedMethod)
            } catch {
                Issue.record("Failed to decode request body: \(error)")
            }
        }
    }
}
