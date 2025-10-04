
import Foundation
@testable import NearJsonRpcClient
@testable import NearJsonRpcTypes
import Testing

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

    @Test("EXPERIMENTAL_changes request and success response types are valid")
    func eXPERIMENTALChangesRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALChanges.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALChanges.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_changes request and error response types are valid")
    func eXPERIMENTALChangesRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALChanges.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALChanges.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_changes_in_block request and success response types are valid")
    func eXPERIMENTALChangesInBlockRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALChangesInBlock.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALChangesInBlock.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError_Success.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_changes_in_block request and error response types are valid")
    func eXPERIMENTALChangesInBlockRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALChangesInBlock.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALChangesInBlock.self, from: requestData)

        // Test error response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError_Error.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_congestion_level request and success response types are valid")
    func eXPERIMENTALCongestionLevelRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALCongestionLevel.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALCongestionLevel.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcCongestionLevelResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcCongestionLevelResponseAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_congestion_level request and error response types are valid")
    func eXPERIMENTALCongestionLevelRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALCongestionLevel.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALCongestionLevel.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcCongestionLevelResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcCongestionLevelResponseAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_genesis_config request and success response types are valid")
    func eXPERIMENTALGenesisConfigRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALGenesisConfig.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALGenesisConfig.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForGenesisConfigAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForGenesisConfigAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_genesis_config request and error response types are valid")
    func eXPERIMENTALGenesisConfigRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALGenesisConfig.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALGenesisConfig.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForGenesisConfigAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForGenesisConfigAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_light_client_block_proof request and success response types are valid")
    func eXPERIMENTALLightClientBlockProofRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALLightClientBlockProof.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALLightClientBlockProof.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_light_client_block_proof request and error response types are valid")
    func eXPERIMENTALLightClientBlockProofRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALLightClientBlockProof.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALLightClientBlockProof.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_light_client_proof request and success response types are valid")
    func eXPERIMENTALLightClientProofRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALLightClientProof.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALLightClientProof.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError_Success.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_light_client_proof request and error response types are valid")
    func eXPERIMENTALLightClientProofRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALLightClientProof.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALLightClientProof.self, from: requestData)

        // Test error response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError_Error.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_maintenance_windows request and success response types are valid")
    func eXPERIMENTALMaintenanceWindowsRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALMaintenanceWindows.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALMaintenanceWindows.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForArrayOfRangeOfUint64AndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_maintenance_windows request and error response types are valid")
    func eXPERIMENTALMaintenanceWindowsRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALMaintenanceWindows.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALMaintenanceWindows.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForArrayOfRangeOfUint64AndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_protocol_config request and success response types are valid")
    func eXPERIMENTALProtocolConfigRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALProtocolConfig.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALProtocolConfig.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcProtocolConfigResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcProtocolConfigResponseAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_protocol_config request and error response types are valid")
    func eXPERIMENTALProtocolConfigRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALProtocolConfig.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALProtocolConfig.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcProtocolConfigResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcProtocolConfigResponseAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_receipt request and success response types are valid")
    func eXPERIMENTALReceiptRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALReceipt.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALReceipt.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcReceiptResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcReceiptResponseAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_receipt request and error response types are valid")
    func eXPERIMENTALReceiptRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALReceipt.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALReceipt.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcReceiptResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcReceiptResponseAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_split_storage_info request and success response types are valid")
    func eXPERIMENTALSplitStorageInfoRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALSplitStorageInfo.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALSplitStorageInfo.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_split_storage_info request and error response types are valid")
    func eXPERIMENTALSplitStorageInfoRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALSplitStorageInfo.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALSplitStorageInfo.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_tx_status request and success response types are valid")
    func eXPERIMENTALTxStatusRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALTxStatus.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALTxStatus.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_tx_status request and error response types are valid")
    func eXPERIMENTALTxStatusRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALTxStatus.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALTxStatus.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_validators_ordered request and success response types are valid")
    func eXPERIMENTALValidatorsOrderedRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALValidatorsOrdered.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALValidatorsOrdered.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_validators_ordered request and error response types are valid")
    func eXPERIMENTALValidatorsOrderedRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALValidatorsOrdered.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALValidatorsOrdered.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError.self, from: responseData)
    }

    @Test("block request and success response types are valid")
    func blockRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForBlock.json")
        _ = try decoder.decode(JsonRpcRequestForBlock.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcBlockResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcBlockResponseAndRpcError.self, from: responseData)
    }

    @Test("block request and error response types are valid")
    func blockRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForBlock.json")
        _ = try decoder.decode(JsonRpcRequestForBlock.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcBlockResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcBlockResponseAndRpcError.self, from: responseData)
    }

    @Test("block_effects request and success response types are valid")
    func blockEffectsRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForBlockEffects.json")
        _ = try decoder.decode(JsonRpcRequestForBlockEffects.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError_Success.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError.self,
            from: responseData,
        )
    }

    @Test("block_effects request and error response types are valid")
    func blockEffectsRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForBlockEffects.json")
        _ = try decoder.decode(JsonRpcRequestForBlockEffects.self, from: requestData)

        // Test error response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError_Error.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError.self,
            from: responseData,
        )
    }

    @Test("broadcast_tx_async request and success response types are valid")
    func broadcastTxAsyncRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForBroadcastTxAsync.json")
        _ = try decoder.decode(JsonRpcRequestForBroadcastTxAsync.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForCryptoHashAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForCryptoHashAndRpcError.self, from: responseData)
    }

    @Test("broadcast_tx_async request and error response types are valid")
    func broadcastTxAsyncRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForBroadcastTxAsync.json")
        _ = try decoder.decode(JsonRpcRequestForBroadcastTxAsync.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForCryptoHashAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForCryptoHashAndRpcError.self, from: responseData)
    }

    @Test("broadcast_tx_commit request and success response types are valid")
    func broadcastTxCommitRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForBroadcastTxCommit.json")
        _ = try decoder.decode(JsonRpcRequestForBroadcastTxCommit.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcError.self, from: responseData)
    }

    @Test("broadcast_tx_commit request and error response types are valid")
    func broadcastTxCommitRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForBroadcastTxCommit.json")
        _ = try decoder.decode(JsonRpcRequestForBroadcastTxCommit.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcError.self, from: responseData)
    }

    @Test("changes request and success response types are valid")
    func changesRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForChanges.json")
        _ = try decoder.decode(JsonRpcRequestForChanges.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError.self, from: responseData)
    }

    @Test("changes request and error response types are valid")
    func changesRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForChanges.json")
        _ = try decoder.decode(JsonRpcRequestForChanges.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError.self, from: responseData)
    }

    @Test("chunk request and success response types are valid")
    func chunkRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForChunk.json")
        _ = try decoder.decode(JsonRpcRequestForChunk.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcChunkResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcChunkResponseAndRpcError.self, from: responseData)
    }

    @Test("chunk request and error response types are valid")
    func chunkRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForChunk.json")
        _ = try decoder.decode(JsonRpcRequestForChunk.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcChunkResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcChunkResponseAndRpcError.self, from: responseData)
    }

    @Test("client_config request and success response types are valid")
    func clientConfigRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForClientConfig.json")
        _ = try decoder.decode(JsonRpcRequestForClientConfig.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcClientConfigResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcClientConfigResponseAndRpcError.self, from: responseData)
    }

    @Test("client_config request and error response types are valid")
    func clientConfigRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForClientConfig.json")
        _ = try decoder.decode(JsonRpcRequestForClientConfig.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcClientConfigResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcClientConfigResponseAndRpcError.self, from: responseData)
    }

    @Test("gas_price request and success response types are valid")
    func gasPriceRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForGasPrice.json")
        _ = try decoder.decode(JsonRpcRequestForGasPrice.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcGasPriceResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcGasPriceResponseAndRpcError.self, from: responseData)
    }

    @Test("gas_price request and error response types are valid")
    func gasPriceRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForGasPrice.json")
        _ = try decoder.decode(JsonRpcRequestForGasPrice.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcGasPriceResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcGasPriceResponseAndRpcError.self, from: responseData)
    }

    @Test("genesis_config request and success response types are valid")
    func genesisConfigRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForGenesisConfig.json")
        _ = try decoder.decode(JsonRpcRequestForGenesisConfig.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForGenesisConfigAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForGenesisConfigAndRpcError.self, from: responseData)
    }

    @Test("genesis_config request and error response types are valid")
    func genesisConfigRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForGenesisConfig.json")
        _ = try decoder.decode(JsonRpcRequestForGenesisConfig.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForGenesisConfigAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForGenesisConfigAndRpcError.self, from: responseData)
    }

    @Test("health request and success response types are valid")
    func healthRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForHealth.json")
        _ = try decoder.decode(JsonRpcRequestForHealth.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForNullableRpcHealthResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForNullableRpcHealthResponseAndRpcError.self, from: responseData)
    }

    @Test("health request and error response types are valid")
    func healthRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForHealth.json")
        _ = try decoder.decode(JsonRpcRequestForHealth.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForNullableRpcHealthResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForNullableRpcHealthResponseAndRpcError.self, from: responseData)
    }

    @Test("light_client_proof request and success response types are valid")
    func lightClientProofRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForLightClientProof.json")
        _ = try decoder.decode(JsonRpcRequestForLightClientProof.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError_Success.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError.self,
            from: responseData,
        )
    }

    @Test("light_client_proof request and error response types are valid")
    func lightClientProofRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForLightClientProof.json")
        _ = try decoder.decode(JsonRpcRequestForLightClientProof.self, from: requestData)

        // Test error response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError_Error.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError.self,
            from: responseData,
        )
    }

    @Test("maintenance_windows request and success response types are valid")
    func maintenanceWindowsRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForMaintenanceWindows.json")
        _ = try decoder.decode(JsonRpcRequestForMaintenanceWindows.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForArrayOfRangeOfUint64AndRpcError.self, from: responseData)
    }

    @Test("maintenance_windows request and error response types are valid")
    func maintenanceWindowsRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForMaintenanceWindows.json")
        _ = try decoder.decode(JsonRpcRequestForMaintenanceWindows.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForArrayOfRangeOfUint64AndRpcError.self, from: responseData)
    }

    @Test("network_info request and success response types are valid")
    func networkInfoRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForNetworkInfo.json")
        _ = try decoder.decode(JsonRpcRequestForNetworkInfo.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcNetworkInfoResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcNetworkInfoResponseAndRpcError.self, from: responseData)
    }

    @Test("network_info request and error response types are valid")
    func networkInfoRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForNetworkInfo.json")
        _ = try decoder.decode(JsonRpcRequestForNetworkInfo.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcNetworkInfoResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcNetworkInfoResponseAndRpcError.self, from: responseData)
    }

    @Test("next_light_client_block request and success response types are valid")
    func nextLightClientBlockRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForNextLightClientBlock.json")
        _ = try decoder.decode(JsonRpcRequestForNextLightClientBlock.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError.self, from: responseData)
    }

    @Test("next_light_client_block request and error response types are valid")
    func nextLightClientBlockRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForNextLightClientBlock.json")
        _ = try decoder.decode(JsonRpcRequestForNextLightClientBlock.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError.self, from: responseData)
    }

    @Test("query request and success response types are valid")
    func queryRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForQuery.json")
        _ = try decoder.decode(JsonRpcRequestForQuery.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcQueryResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcQueryResponseAndRpcError.self, from: responseData)
    }

    @Test("query request and error response types are valid")
    func queryRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForQuery.json")
        _ = try decoder.decode(JsonRpcRequestForQuery.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcQueryResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcQueryResponseAndRpcError.self, from: responseData)
    }

    @Test("send_tx request and success response types are valid")
    func sendTxRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForSendTx.json")
        _ = try decoder.decode(JsonRpcRequestForSendTx.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcError.self, from: responseData)
    }

    @Test("send_tx request and error response types are valid")
    func sendTxRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForSendTx.json")
        _ = try decoder.decode(JsonRpcRequestForSendTx.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcError.self, from: responseData)
    }

    @Test("status request and success response types are valid")
    func statusRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForStatus.json")
        _ = try decoder.decode(JsonRpcRequestForStatus.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcStatusResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcStatusResponseAndRpcError.self, from: responseData)
    }

    @Test("status request and error response types are valid")
    func statusRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForStatus.json")
        _ = try decoder.decode(JsonRpcRequestForStatus.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcStatusResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcStatusResponseAndRpcError.self, from: responseData)
    }

    @Test("tx request and success response types are valid")
    func txRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForTx.json")
        _ = try decoder.decode(JsonRpcRequestForTx.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcError.self, from: responseData)
    }

    @Test("tx request and error response types are valid")
    func txRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForTx.json")
        _ = try decoder.decode(JsonRpcRequestForTx.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcError.self, from: responseData)
    }

    @Test("validators request and success response types are valid")
    func validatorsRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForValidators.json")
        _ = try decoder.decode(JsonRpcRequestForValidators.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcValidatorResponseAndRpcError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcValidatorResponseAndRpcError.self, from: responseData)
    }

    @Test("validators request and error response types are valid")
    func validatorsRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForValidators.json")
        _ = try decoder.decode(JsonRpcRequestForValidators.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcValidatorResponseAndRpcError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcValidatorResponseAndRpcError.self, from: responseData)
    }
}
