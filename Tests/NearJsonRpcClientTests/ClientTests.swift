
import Foundation
import Testing
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
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
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError_Success.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_changes request and error response types are valid")
    func eXPERIMENTALChangesRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALChanges.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALChanges.self, from: requestData)

        // Test error response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError_Error.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_changes_in_block request and success response types are valid")
    func eXPERIMENTALChangesInBlockRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALChangesInBlock.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALChangesInBlock.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError_Success.json",
            )
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError.self,
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
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError_Error.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_congestion_level request and success response types are valid")
    func eXPERIMENTALCongestionLevelRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALCongestionLevel.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALCongestionLevel.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_congestion_level request and error response types are valid")
    func eXPERIMENTALCongestionLevelRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALCongestionLevel.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALCongestionLevel.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_genesis_config request and success response types are valid")
    func eXPERIMENTALGenesisConfigRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALGenesisConfig.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALGenesisConfig.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForGenesisConfigAndGenesisConfigError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForGenesisConfigAndGenesisConfigError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_genesis_config request and error response types are valid")
    func eXPERIMENTALGenesisConfigRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALGenesisConfig.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALGenesisConfig.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForGenesisConfigAndGenesisConfigError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForGenesisConfigAndGenesisConfigError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_light_client_block_proof request and success response types are valid")
    func eXPERIMENTALLightClientBlockProofRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALLightClientBlockProof.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALLightClientBlockProof.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError_Success.json",
            )
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_light_client_block_proof request and error response types are valid")
    func eXPERIMENTALLightClientBlockProofRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALLightClientBlockProof.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALLightClientBlockProof.self, from: requestData)

        // Test error response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError_Error.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_light_client_proof request and success response types are valid")
    func eXPERIMENTALLightClientProofRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALLightClientProof.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALLightClientProof.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError_Success.json",
            )
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError.self,
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
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError_Error.json",
            )
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_maintenance_windows request and success response types are valid")
    func eXPERIMENTALMaintenanceWindowsRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALMaintenanceWindows.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALMaintenanceWindows.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError_Success.json")
        _ = try decoder.decode(
            JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_maintenance_windows request and error response types are valid")
    func eXPERIMENTALMaintenanceWindowsRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALMaintenanceWindows.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALMaintenanceWindows.self, from: requestData)

        // Test error response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError_Error.json")
        _ = try decoder.decode(
            JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_protocol_config request and success response types are valid")
    func eXPERIMENTALProtocolConfigRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALProtocolConfig.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALProtocolConfig.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError_Success.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_protocol_config request and error response types are valid")
    func eXPERIMENTALProtocolConfigRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALProtocolConfig.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALProtocolConfig.self, from: requestData)

        // Test error response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError_Error.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_receipt request and success response types are valid")
    func eXPERIMENTALReceiptRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALReceipt.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALReceipt.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_receipt request and error response types are valid")
    func eXPERIMENTALReceiptRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALReceipt.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALReceipt.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_split_storage_info request and success response types are valid")
    func eXPERIMENTALSplitStorageInfoRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALSplitStorageInfo.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALSplitStorageInfo.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError_Success.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_split_storage_info request and error response types are valid")
    func eXPERIMENTALSplitStorageInfoRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALSplitStorageInfo.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALSplitStorageInfo.self, from: requestData)

        // Test error response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError_Error.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError.self,
            from: responseData,
        )
    }

    @Test("EXPERIMENTAL_tx_status request and success response types are valid")
    func eXPERIMENTALTxStatusRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALTxStatus.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALTxStatus.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_tx_status request and error response types are valid")
    func eXPERIMENTALTxStatusRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALTxStatus.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALTxStatus.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_validators_ordered request and success response types are valid")
    func eXPERIMENTALValidatorsOrderedRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALValidatorsOrdered.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALValidatorsOrdered.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError.self, from: responseData)
    }

    @Test("EXPERIMENTAL_validators_ordered request and error response types are valid")
    func eXPERIMENTALValidatorsOrderedRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForEXPERIMENTALValidatorsOrdered.json")
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALValidatorsOrdered.self, from: requestData)

        // Test error response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError.self, from: responseData)
    }

    @Test("block request and success response types are valid")
    func blockRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForBlock.json")
        _ = try decoder.decode(JsonRpcRequestForBlock.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcBlockResponseAndRpcBlockError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcBlockResponseAndRpcBlockError.self, from: responseData)
    }

    @Test("block request and error response types are valid")
    func blockRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForBlock.json")
        _ = try decoder.decode(JsonRpcRequestForBlock.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcBlockResponseAndRpcBlockError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcBlockResponseAndRpcBlockError.self, from: responseData)
    }

    @Test("block_effects request and success response types are valid")
    func blockEffectsRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForBlockEffects.json")
        _ = try decoder.decode(JsonRpcRequestForBlockEffects.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError_Success.json",
            )
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError.self,
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
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError_Error.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError.self,
            from: responseData,
        )
    }

    @Test("broadcast_tx_async request and success response types are valid")
    func broadcastTxAsyncRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForBroadcastTxAsync.json")
        _ = try decoder.decode(JsonRpcRequestForBroadcastTxAsync.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForCryptoHashAndRpcTransactionError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForCryptoHashAndRpcTransactionError.self, from: responseData)
    }

    @Test("broadcast_tx_async request and error response types are valid")
    func broadcastTxAsyncRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForBroadcastTxAsync.json")
        _ = try decoder.decode(JsonRpcRequestForBroadcastTxAsync.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForCryptoHashAndRpcTransactionError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForCryptoHashAndRpcTransactionError.self, from: responseData)
    }

    @Test("broadcast_tx_commit request and success response types are valid")
    func broadcastTxCommitRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForBroadcastTxCommit.json")
        _ = try decoder.decode(JsonRpcRequestForBroadcastTxCommit.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self, from: responseData)
    }

    @Test("broadcast_tx_commit request and error response types are valid")
    func broadcastTxCommitRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForBroadcastTxCommit.json")
        _ = try decoder.decode(JsonRpcRequestForBroadcastTxCommit.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self, from: responseData)
    }

    @Test("changes request and success response types are valid")
    func changesRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForChanges.json")
        _ = try decoder.decode(JsonRpcRequestForChanges.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError_Success.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError.self,
            from: responseData,
        )
    }

    @Test("changes request and error response types are valid")
    func changesRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForChanges.json")
        _ = try decoder.decode(JsonRpcRequestForChanges.self, from: requestData)

        // Test error response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError_Error.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError.self,
            from: responseData,
        )
    }

    @Test("chunk request and success response types are valid")
    func chunkRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForChunk.json")
        _ = try decoder.decode(JsonRpcRequestForChunk.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcChunkResponseAndRpcChunkError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcChunkResponseAndRpcChunkError.self, from: responseData)
    }

    @Test("chunk request and error response types are valid")
    func chunkRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForChunk.json")
        _ = try decoder.decode(JsonRpcRequestForChunk.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcChunkResponseAndRpcChunkError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcChunkResponseAndRpcChunkError.self, from: responseData)
    }

    @Test("client_config request and success response types are valid")
    func clientConfigRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForClientConfig.json")
        _ = try decoder.decode(JsonRpcRequestForClientConfig.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError_Success.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError.self,
            from: responseData,
        )
    }

    @Test("client_config request and error response types are valid")
    func clientConfigRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForClientConfig.json")
        _ = try decoder.decode(JsonRpcRequestForClientConfig.self, from: requestData)

        // Test error response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError_Error.json")
        _ = try decoder.decode(
            JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError.self,
            from: responseData,
        )
    }

    @Test("gas_price request and success response types are valid")
    func gasPriceRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForGasPrice.json")
        _ = try decoder.decode(JsonRpcRequestForGasPrice.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError.self, from: responseData)
    }

    @Test("gas_price request and error response types are valid")
    func gasPriceRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForGasPrice.json")
        _ = try decoder.decode(JsonRpcRequestForGasPrice.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError.self, from: responseData)
    }

    @Test("genesis_config request and success response types are valid")
    func genesisConfigRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForGenesisConfig.json")
        _ = try decoder.decode(JsonRpcRequestForGenesisConfig.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForGenesisConfigAndGenesisConfigError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForGenesisConfigAndGenesisConfigError.self, from: responseData)
    }

    @Test("genesis_config request and error response types are valid")
    func genesisConfigRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForGenesisConfig.json")
        _ = try decoder.decode(JsonRpcRequestForGenesisConfig.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForGenesisConfigAndGenesisConfigError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForGenesisConfigAndGenesisConfigError.self, from: responseData)
    }

    @Test("health request and success response types are valid")
    func healthRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForHealth.json")
        _ = try decoder.decode(JsonRpcRequestForHealth.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError.self, from: responseData)
    }

    @Test("health request and error response types are valid")
    func healthRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForHealth.json")
        _ = try decoder.decode(JsonRpcRequestForHealth.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError.self, from: responseData)
    }

    @Test("light_client_proof request and success response types are valid")
    func lightClientProofRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForLightClientProof.json")
        _ = try decoder.decode(JsonRpcRequestForLightClientProof.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError_Success.json",
            )
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError.self,
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
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError_Error.json",
            )
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError.self,
            from: responseData,
        )
    }

    @Test("maintenance_windows request and success response types are valid")
    func maintenanceWindowsRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForMaintenanceWindows.json")
        _ = try decoder.decode(JsonRpcRequestForMaintenanceWindows.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError_Success.json")
        _ = try decoder.decode(
            JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError.self,
            from: responseData,
        )
    }

    @Test("maintenance_windows request and error response types are valid")
    func maintenanceWindowsRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForMaintenanceWindows.json")
        _ = try decoder.decode(JsonRpcRequestForMaintenanceWindows.self, from: requestData)

        // Test error response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError_Error.json")
        _ = try decoder.decode(
            JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError.self,
            from: responseData,
        )
    }

    @Test("network_info request and success response types are valid")
    func networkInfoRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForNetworkInfo.json")
        _ = try decoder.decode(JsonRpcRequestForNetworkInfo.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError.self, from: responseData)
    }

    @Test("network_info request and error response types are valid")
    func networkInfoRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForNetworkInfo.json")
        _ = try decoder.decode(JsonRpcRequestForNetworkInfo.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError.self, from: responseData)
    }

    @Test("next_light_client_block request and success response types are valid")
    func nextLightClientBlockRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForNextLightClientBlock.json")
        _ = try decoder.decode(JsonRpcRequestForNextLightClientBlock.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError_Success.json",
            )
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError.self,
            from: responseData,
        )
    }

    @Test("next_light_client_block request and error response types are valid")
    func nextLightClientBlockRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForNextLightClientBlock.json")
        _ = try decoder.decode(JsonRpcRequestForNextLightClientBlock.self, from: requestData)

        // Test error response type decoding
        let responseData =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError_Error.json",
            )
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError.self,
            from: responseData,
        )
    }

    @Test("query request and success response types are valid")
    func queryRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForQuery.json")
        _ = try decoder.decode(JsonRpcRequestForQuery.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcQueryResponseAndRpcQueryError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcQueryResponseAndRpcQueryError.self, from: responseData)
    }

    @Test("query request and error response types are valid")
    func queryRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForQuery.json")
        _ = try decoder.decode(JsonRpcRequestForQuery.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcQueryResponseAndRpcQueryError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcQueryResponseAndRpcQueryError.self, from: responseData)
    }

    @Test("send_tx request and success response types are valid")
    func sendTxRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForSendTx.json")
        _ = try decoder.decode(JsonRpcRequestForSendTx.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self, from: responseData)
    }

    @Test("send_tx request and error response types are valid")
    func sendTxRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForSendTx.json")
        _ = try decoder.decode(JsonRpcRequestForSendTx.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self, from: responseData)
    }

    @Test("status request and success response types are valid")
    func statusRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForStatus.json")
        _ = try decoder.decode(JsonRpcRequestForStatus.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcStatusResponseAndRpcStatusError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcStatusResponseAndRpcStatusError.self, from: responseData)
    }

    @Test("status request and error response types are valid")
    func statusRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForStatus.json")
        _ = try decoder.decode(JsonRpcRequestForStatus.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcStatusResponseAndRpcStatusError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcStatusResponseAndRpcStatusError.self, from: responseData)
    }

    @Test("tx request and success response types are valid")
    func txRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForTx.json")
        _ = try decoder.decode(JsonRpcRequestForTx.self, from: requestData)

        // Test success response type decoding
        let responseData =
            try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self, from: responseData)
    }

    @Test("tx request and error response types are valid")
    func txRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForTx.json")
        _ = try decoder.decode(JsonRpcRequestForTx.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self, from: responseData)
    }

    @Test("validators request and success response types are valid")
    func validatorsRequestAndSuccessResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForValidators.json")
        _ = try decoder.decode(JsonRpcRequestForValidators.self, from: requestData)

        // Test success response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError_Success.json")
        _ = try decoder.decode(JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError.self, from: responseData)
    }

    @Test("validators request and error response types are valid")
    func validatorsRequestAndErrorResponse() throws {
        // Test request type decoding
        let requestData = try loadMockJSON("JsonRpcRequestForValidators.json")
        _ = try decoder.decode(JsonRpcRequestForValidators.self, from: requestData)

        // Test error response type decoding
        let responseData = try loadMockJSON("JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError_Error.json")
        _ = try decoder.decode(JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError.self, from: responseData)
    }
}
