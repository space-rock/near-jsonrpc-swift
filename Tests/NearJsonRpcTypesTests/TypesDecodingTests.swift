
import Foundation
@testable import NearJsonRpcTypes
import Testing

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

    @Test("JsonRpcRequestForBlock can be decoded and re-encoded")
    func jsonRpcRequestForBlockDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForBlock.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForBlock.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForBlock.self, from: encoded)
    }

    @Test("JsonRpcRequestForBlockEffects can be decoded and re-encoded")
    func jsonRpcRequestForBlockEffectsDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForBlockEffects.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForBlockEffects.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForBlockEffects.self, from: encoded)
    }

    @Test("JsonRpcRequestForBroadcastTxAsync can be decoded and re-encoded")
    func jsonRpcRequestForBroadcastTxAsyncDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForBroadcastTxAsync.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForBroadcastTxAsync.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForBroadcastTxAsync.self, from: encoded)
    }

    @Test("JsonRpcRequestForBroadcastTxCommit can be decoded and re-encoded")
    func jsonRpcRequestForBroadcastTxCommitDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForBroadcastTxCommit.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForBroadcastTxCommit.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForBroadcastTxCommit.self, from: encoded)
    }

    @Test("JsonRpcRequestForChanges can be decoded and re-encoded")
    func jsonRpcRequestForChangesDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForChanges.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForChanges.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForChanges.self, from: encoded)
    }

    @Test("JsonRpcRequestForChunk can be decoded and re-encoded")
    func jsonRpcRequestForChunkDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForChunk.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForChunk.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForChunk.self, from: encoded)
    }

    @Test("JsonRpcRequestForClientConfig can be decoded and re-encoded")
    func jsonRpcRequestForClientConfigDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForClientConfig.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForClientConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForClientConfig.self, from: encoded)
    }

    @Test("JsonRpcRequestForEXPERIMENTALChanges can be decoded and re-encoded")
    func jsonRpcRequestForEXPERIMENTALChangesDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForEXPERIMENTALChanges.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForEXPERIMENTALChanges.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALChanges.self, from: encoded)
    }

    @Test("JsonRpcRequestForEXPERIMENTALChangesInBlock can be decoded and re-encoded")
    func jsonRpcRequestForEXPERIMENTALChangesInBlockDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForEXPERIMENTALChangesInBlock.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForEXPERIMENTALChangesInBlock.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALChangesInBlock.self, from: encoded)
    }

    @Test("JsonRpcRequestForEXPERIMENTALCongestionLevel can be decoded and re-encoded")
    func jsonRpcRequestForEXPERIMENTALCongestionLevelDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForEXPERIMENTALCongestionLevel.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForEXPERIMENTALCongestionLevel.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALCongestionLevel.self, from: encoded)
    }

    @Test("JsonRpcRequestForEXPERIMENTALGenesisConfig can be decoded and re-encoded")
    func jsonRpcRequestForEXPERIMENTALGenesisConfigDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForEXPERIMENTALGenesisConfig.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForEXPERIMENTALGenesisConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALGenesisConfig.self, from: encoded)
    }

    @Test("JsonRpcRequestForEXPERIMENTALLightClientBlockProof can be decoded and re-encoded")
    func jsonRpcRequestForEXPERIMENTALLightClientBlockProofDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForEXPERIMENTALLightClientBlockProof.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForEXPERIMENTALLightClientBlockProof.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALLightClientBlockProof.self, from: encoded)
    }

    @Test("JsonRpcRequestForEXPERIMENTALLightClientProof can be decoded and re-encoded")
    func jsonRpcRequestForEXPERIMENTALLightClientProofDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForEXPERIMENTALLightClientProof.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForEXPERIMENTALLightClientProof.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALLightClientProof.self, from: encoded)
    }

    @Test("JsonRpcRequestForEXPERIMENTALMaintenanceWindows can be decoded and re-encoded")
    func jsonRpcRequestForEXPERIMENTALMaintenanceWindowsDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForEXPERIMENTALMaintenanceWindows.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForEXPERIMENTALMaintenanceWindows.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALMaintenanceWindows.self, from: encoded)
    }

    @Test("JsonRpcRequestForEXPERIMENTALProtocolConfig can be decoded and re-encoded")
    func jsonRpcRequestForEXPERIMENTALProtocolConfigDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForEXPERIMENTALProtocolConfig.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForEXPERIMENTALProtocolConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALProtocolConfig.self, from: encoded)
    }

    @Test("JsonRpcRequestForEXPERIMENTALReceipt can be decoded and re-encoded")
    func jsonRpcRequestForEXPERIMENTALReceiptDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForEXPERIMENTALReceipt.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForEXPERIMENTALReceipt.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALReceipt.self, from: encoded)
    }

    @Test("JsonRpcRequestForEXPERIMENTALSplitStorageInfo can be decoded and re-encoded")
    func jsonRpcRequestForEXPERIMENTALSplitStorageInfoDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForEXPERIMENTALSplitStorageInfo.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForEXPERIMENTALSplitStorageInfo.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALSplitStorageInfo.self, from: encoded)
    }

    @Test("JsonRpcRequestForEXPERIMENTALTxStatus can be decoded and re-encoded")
    func jsonRpcRequestForEXPERIMENTALTxStatusDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForEXPERIMENTALTxStatus.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForEXPERIMENTALTxStatus.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALTxStatus.self, from: encoded)
    }

    @Test("JsonRpcRequestForEXPERIMENTALValidatorsOrdered can be decoded and re-encoded")
    func jsonRpcRequestForEXPERIMENTALValidatorsOrderedDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForEXPERIMENTALValidatorsOrdered.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForEXPERIMENTALValidatorsOrdered.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForEXPERIMENTALValidatorsOrdered.self, from: encoded)
    }

    @Test("JsonRpcRequestForGasPrice can be decoded and re-encoded")
    func jsonRpcRequestForGasPriceDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForGasPrice.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForGasPrice.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForGasPrice.self, from: encoded)
    }

    @Test("JsonRpcRequestForGenesisConfig can be decoded and re-encoded")
    func jsonRpcRequestForGenesisConfigDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForGenesisConfig.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForGenesisConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForGenesisConfig.self, from: encoded)
    }

    @Test("JsonRpcRequestForHealth can be decoded and re-encoded")
    func jsonRpcRequestForHealthDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForHealth.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForHealth.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForHealth.self, from: encoded)
    }

    @Test("JsonRpcRequestForLightClientProof can be decoded and re-encoded")
    func jsonRpcRequestForLightClientProofDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForLightClientProof.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForLightClientProof.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForLightClientProof.self, from: encoded)
    }

    @Test("JsonRpcRequestForMaintenanceWindows can be decoded and re-encoded")
    func jsonRpcRequestForMaintenanceWindowsDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForMaintenanceWindows.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForMaintenanceWindows.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForMaintenanceWindows.self, from: encoded)
    }

    @Test("JsonRpcRequestForNetworkInfo can be decoded and re-encoded")
    func jsonRpcRequestForNetworkInfoDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForNetworkInfo.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForNetworkInfo.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForNetworkInfo.self, from: encoded)
    }

    @Test("JsonRpcRequestForNextLightClientBlock can be decoded and re-encoded")
    func jsonRpcRequestForNextLightClientBlockDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForNextLightClientBlock.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForNextLightClientBlock.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForNextLightClientBlock.self, from: encoded)
    }

    @Test("JsonRpcRequestForQuery can be decoded and re-encoded")
    func jsonRpcRequestForQueryDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForQuery.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForQuery.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForQuery.self, from: encoded)
    }

    @Test("JsonRpcRequestForSendTx can be decoded and re-encoded")
    func jsonRpcRequestForSendTxDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForSendTx.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForSendTx.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForSendTx.self, from: encoded)
    }

    @Test("JsonRpcRequestForStatus can be decoded and re-encoded")
    func jsonRpcRequestForStatusDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForStatus.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForStatus.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForStatus.self, from: encoded)
    }

    @Test("JsonRpcRequestForTx can be decoded and re-encoded")
    func jsonRpcRequestForTxDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForTx.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForTx.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForTx.self, from: encoded)
    }

    @Test("JsonRpcRequestForValidators can be decoded and re-encoded")
    func jsonRpcRequestForValidatorsDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcRequestForValidators.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcRequestForValidators.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcRequestForValidators.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError success response can be decoded and re-encoded",
    )
    func jsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError error response can be decoded and re-encoded",
    )
    func jsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError success response can be decoded and re-encoded",
    )
    func jsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError error response can be decoded and re-encoded",
    )
    func jsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError.self, from: encoded)
    }

    @Test("JsonRpcResponseForCryptoHashAndRpcTransactionError success response can be decoded and re-encoded")
    func jsonRpcResponseForCryptoHashAndRpcTransactionErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForCryptoHashAndRpcTransactionError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForCryptoHashAndRpcTransactionError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForCryptoHashAndRpcTransactionError.self, from: encoded)
    }

    @Test("JsonRpcResponseForCryptoHashAndRpcTransactionError error response can be decoded and re-encoded")
    func jsonRpcResponseForCryptoHashAndRpcTransactionErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForCryptoHashAndRpcTransactionError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForCryptoHashAndRpcTransactionError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForCryptoHashAndRpcTransactionError.self, from: encoded)
    }

    @Test("JsonRpcResponseForGenesisConfigAndGenesisConfigError success response can be decoded and re-encoded")
    func jsonRpcResponseForGenesisConfigAndGenesisConfigErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForGenesisConfigAndGenesisConfigError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForGenesisConfigAndGenesisConfigError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForGenesisConfigAndGenesisConfigError.self, from: encoded)
    }

    @Test("JsonRpcResponseForGenesisConfigAndGenesisConfigError error response can be decoded and re-encoded")
    func jsonRpcResponseForGenesisConfigAndGenesisConfigErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForGenesisConfigAndGenesisConfigError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForGenesisConfigAndGenesisConfigError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForGenesisConfigAndGenesisConfigError.self, from: encoded)
    }

    @Test("JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError success response can be decoded and re-encoded")
    func jsonRpcResponseForNullableRpcHealthResponseAndRpcStatusErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError.self, from: encoded)
    }

    @Test("JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError error response can be decoded and re-encoded")
    func jsonRpcResponseForNullableRpcHealthResponseAndRpcStatusErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcBlockResponseAndRpcBlockError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcBlockResponseAndRpcBlockErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcBlockResponseAndRpcBlockError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcBlockResponseAndRpcBlockError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcBlockResponseAndRpcBlockError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcBlockResponseAndRpcBlockError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcBlockResponseAndRpcBlockErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcBlockResponseAndRpcBlockError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcBlockResponseAndRpcBlockError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcBlockResponseAndRpcBlockError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcChunkResponseAndRpcChunkError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcChunkResponseAndRpcChunkErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcChunkResponseAndRpcChunkError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcChunkResponseAndRpcChunkError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcChunkResponseAndRpcChunkError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcChunkResponseAndRpcChunkError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcChunkResponseAndRpcChunkErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcChunkResponseAndRpcChunkError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcChunkResponseAndRpcChunkError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcChunkResponseAndRpcChunkError.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError success response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError error response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError success response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofErrorSuccessDecodingAndEncoding(
    ) throws {
        let data =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError_Success.json",
            )

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError.self,
            from: encoded,
        )
    }

    @Test(
        "JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError error response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofErrorErrorDecodingAndEncoding() throws {
        let data =
            try loadMockJSON("JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError.self,
            from: encoded,
        )
    }

    @Test(
        "JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError success response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofErrorSuccessDecodingAndEncoding(
    ) throws {
        let data =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError_Success.json",
            )

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError.self,
            from: encoded,
        )
    }

    @Test(
        "JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError error response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofErrorErrorDecodingAndEncoding(
    ) throws {
        let data =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError_Error.json",
            )

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError.self,
            from: encoded,
        )
    }

    @Test(
        "JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError success response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockErrorSuccessDecodingAndEncoding(
    ) throws {
        let data =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError_Success.json",
            )

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError.self,
            from: encoded,
        )
    }

    @Test(
        "JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError error response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockErrorErrorDecodingAndEncoding(
    ) throws {
        let data =
            try loadMockJSON(
                "JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError_Error.json",
            )

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(
            JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError.self,
            from: encoded,
        )
    }

    @Test(
        "JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError success response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError success response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError error response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcQueryResponseAndRpcQueryError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcQueryResponseAndRpcQueryErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcQueryResponseAndRpcQueryError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcQueryResponseAndRpcQueryError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcQueryResponseAndRpcQueryError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcQueryResponseAndRpcQueryError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcQueryResponseAndRpcQueryErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcQueryResponseAndRpcQueryError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcQueryResponseAndRpcQueryError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcQueryResponseAndRpcQueryError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcReceiptResponseAndRpcReceiptErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcReceiptResponseAndRpcReceiptErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError success response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoErrorSuccessDecodingAndEncoding() throws {
        let data =
            try loadMockJSON("JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(
            JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError.self,
            from: encoded,
        )
    }

    @Test(
        "JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError error response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoErrorErrorDecodingAndEncoding() throws {
        let data =
            try loadMockJSON("JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(
            JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError.self,
            from: encoded,
        )
    }

    @Test(
        "JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError success response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesErrorSuccessDecodingAndEncoding(
    ) throws {
        let data =
            try loadMockJSON(
                "JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError_Success.json",
            )

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError.self,
            from: encoded,
        )
    }

    @Test(
        "JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError error response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesErrorErrorDecodingAndEncoding() throws {
        let data =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError.self,
            from: encoded,
        )
    }

    @Test(
        "JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError success response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesErrorSuccessDecodingAndEncoding() throws {
        let data =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError.self,
            from: encoded,
        )
    }

    @Test(
        "JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError error response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesErrorErrorDecodingAndEncoding() throws {
        let data =
            try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError.self,
            from: encoded,
        )
    }

    @Test("JsonRpcResponseForRpcStatusResponseAndRpcStatusError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcStatusResponseAndRpcStatusErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcStatusResponseAndRpcStatusError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcStatusResponseAndRpcStatusError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcStatusResponseAndRpcStatusError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcStatusResponseAndRpcStatusError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcStatusResponseAndRpcStatusErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcStatusResponseAndRpcStatusError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcStatusResponseAndRpcStatusError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcStatusResponseAndRpcStatusError.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError success response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcTransactionResponseAndRpcTransactionErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcTransactionResponseAndRpcTransactionErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcValidatorResponseAndRpcValidatorErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcValidatorResponseAndRpcValidatorErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError.self, from: encoded)
    }
}
