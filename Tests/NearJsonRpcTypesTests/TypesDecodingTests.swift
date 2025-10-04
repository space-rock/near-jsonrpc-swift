
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

    @Test("JsonRpcResponseForArrayOfRangeOfUint64AndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForArrayOfRangeOfUint64AndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForArrayOfRangeOfUint64AndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForArrayOfRangeOfUint64AndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForArrayOfRangeOfUint64AndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForArrayOfRangeOfUint64AndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForArrayOfRangeOfUint64AndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForArrayOfRangeOfUint64AndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForArrayOfRangeOfUint64AndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForArrayOfValidatorStakeViewAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForArrayOfValidatorStakeViewAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForCryptoHashAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForCryptoHashAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForCryptoHashAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForCryptoHashAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForCryptoHashAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForCryptoHashAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForCryptoHashAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForCryptoHashAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForCryptoHashAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForCryptoHashAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForGenesisConfigAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForGenesisConfigAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForGenesisConfigAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForGenesisConfigAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForGenesisConfigAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForGenesisConfigAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForGenesisConfigAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForGenesisConfigAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForGenesisConfigAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForGenesisConfigAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForNullableRpcHealthResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForNullableRpcHealthResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForNullableRpcHealthResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForNullableRpcHealthResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForNullableRpcHealthResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForNullableRpcHealthResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForNullableRpcHealthResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForNullableRpcHealthResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForNullableRpcHealthResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForNullableRpcHealthResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcBlockResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcBlockResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcBlockResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcBlockResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcBlockResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcBlockResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcBlockResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcBlockResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcBlockResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcBlockResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcChunkResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcChunkResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcChunkResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcChunkResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcChunkResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcChunkResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcChunkResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcChunkResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcChunkResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcChunkResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcClientConfigResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcClientConfigResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcClientConfigResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcClientConfigResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcClientConfigResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcClientConfigResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcClientConfigResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcClientConfigResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcClientConfigResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcClientConfigResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcCongestionLevelResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcCongestionLevelResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcCongestionLevelResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcCongestionLevelResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcCongestionLevelResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcCongestionLevelResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcCongestionLevelResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcCongestionLevelResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcCongestionLevelResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcCongestionLevelResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcGasPriceResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcGasPriceResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcGasPriceResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcGasPriceResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcGasPriceResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcGasPriceResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcGasPriceResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcGasPriceResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcGasPriceResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcGasPriceResponseAndRpcError.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError success response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcLightClientBlockProofResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcLightClientBlockProofResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError success response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError error response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcLightClientNextBlockResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcLightClientNextBlockResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcNetworkInfoResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcNetworkInfoResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcNetworkInfoResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcNetworkInfoResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcNetworkInfoResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcNetworkInfoResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcNetworkInfoResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcNetworkInfoResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcNetworkInfoResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcNetworkInfoResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcProtocolConfigResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcProtocolConfigResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcProtocolConfigResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcProtocolConfigResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcProtocolConfigResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcProtocolConfigResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcProtocolConfigResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcProtocolConfigResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcProtocolConfigResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcProtocolConfigResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcQueryResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcQueryResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcQueryResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcQueryResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcQueryResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcQueryResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcQueryResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcQueryResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcQueryResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcQueryResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcReceiptResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcReceiptResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcReceiptResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcReceiptResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcReceiptResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcReceiptResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcReceiptResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcReceiptResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcReceiptResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcReceiptResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcSplitStorageInfoResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcSplitStorageInfoResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError success response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError.self, from: encoded)
    }

    @Test(
        "JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError error response can be decoded and re-encoded",
    )
    func jsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(
            JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError.self,
            from: data,
        )

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcStateChangesInBlockResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcStateChangesInBlockResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcStatusResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcStatusResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcStatusResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcStatusResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcStatusResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcStatusResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcStatusResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcStatusResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcStatusResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcStatusResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcTransactionResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcTransactionResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcTransactionResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcTransactionResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcTransactionResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcTransactionResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcValidatorResponseAndRpcError success response can be decoded and re-encoded")
    func jsonRpcResponseForRpcValidatorResponseAndRpcErrorSuccessDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcValidatorResponseAndRpcError_Success.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcValidatorResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcValidatorResponseAndRpcError.self, from: encoded)
    }

    @Test("JsonRpcResponseForRpcValidatorResponseAndRpcError error response can be decoded and re-encoded")
    func jsonRpcResponseForRpcValidatorResponseAndRpcErrorErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("JsonRpcResponseForRpcValidatorResponseAndRpcError_Error.json")

        // Test decoding
        let decoded = try decoder.decode(JsonRpcResponseForRpcValidatorResponseAndRpcError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(JsonRpcResponseForRpcValidatorResponseAndRpcError.self, from: encoded)
    }
}
