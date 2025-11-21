
import Foundation
@testable import NearJsonRpcTypes
import Testing

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

    @Test("AccessKey can be decoded from mock and re-encoded")
    func accessKeyDecodingAndEncoding() throws {
        let data = try loadMockJSON("AccessKey.json")

        // Test decoding
        let decoded = try decoder.decode(AccessKey.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AccessKey.self, from: encoded)
    }

    @Test("AccessKeyCreationConfigView can be decoded from mock and re-encoded")
    func accessKeyCreationConfigViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("AccessKeyCreationConfigView.json")

        // Test decoding
        let decoded = try decoder.decode(AccessKeyCreationConfigView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AccessKeyCreationConfigView.self, from: encoded)
    }

    @Test("AccessKeyInfoView can be decoded from mock and re-encoded")
    func accessKeyInfoViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("AccessKeyInfoView.json")

        // Test decoding
        let decoded = try decoder.decode(AccessKeyInfoView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AccessKeyInfoView.self, from: encoded)
    }

    @Test("AccessKeyList can be decoded from mock and re-encoded")
    func accessKeyListDecodingAndEncoding() throws {
        let data = try loadMockJSON("AccessKeyList.json")

        // Test decoding
        let decoded = try decoder.decode(AccessKeyList.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AccessKeyList.self, from: encoded)
    }

    @Test("AccessKeyPermission variant 0 can be decoded and re-encoded")
    func accessKeyPermissionVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("AccessKeyPermission_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(AccessKeyPermission.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AccessKeyPermission.self, from: encoded)
    }

    @Test("AccessKeyPermission variant 1 can be decoded and re-encoded")
    func accessKeyPermissionVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("AccessKeyPermission_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(AccessKeyPermission.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AccessKeyPermission.self, from: encoded)
    }

    @Test("AccessKeyPermissionView variant 0 can be decoded and re-encoded")
    func accessKeyPermissionViewVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("AccessKeyPermissionView_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(AccessKeyPermissionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AccessKeyPermissionView.self, from: encoded)
    }

    @Test("AccessKeyPermissionView variant 1 can be decoded and re-encoded")
    func accessKeyPermissionViewVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("AccessKeyPermissionView_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(AccessKeyPermissionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AccessKeyPermissionView.self, from: encoded)
    }

    @Test("AccessKeyView can be decoded from mock and re-encoded")
    func accessKeyViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("AccessKeyView.json")

        // Test decoding
        let decoded = try decoder.decode(AccessKeyView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AccessKeyView.self, from: encoded)
    }

    @Test("AccountCreationConfigView can be decoded from mock and re-encoded")
    func accountCreationConfigViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("AccountCreationConfigView.json")

        // Test decoding
        let decoded = try decoder.decode(AccountCreationConfigView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AccountCreationConfigView.self, from: encoded)
    }

    @Test("AccountDataView can be decoded from mock and re-encoded")
    func accountDataViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("AccountDataView.json")

        // Test decoding
        let decoded = try decoder.decode(AccountDataView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AccountDataView.self, from: encoded)
    }

    @Test("AccountInfo can be decoded from mock and re-encoded")
    func accountInfoDecodingAndEncoding() throws {
        let data = try loadMockJSON("AccountInfo.json")

        // Test decoding
        let decoded = try decoder.decode(AccountInfo.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AccountInfo.self, from: encoded)
    }

    @Test("AccountView can be decoded from mock and re-encoded")
    func accountViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("AccountView.json")

        // Test decoding
        let decoded = try decoder.decode(AccountView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AccountView.self, from: encoded)
    }

    @Test("AccountWithPublicKey can be decoded from mock and re-encoded")
    func accountWithPublicKeyDecodingAndEncoding() throws {
        let data = try loadMockJSON("AccountWithPublicKey.json")

        // Test decoding
        let decoded = try decoder.decode(AccountWithPublicKey.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AccountWithPublicKey.self, from: encoded)
    }

    @Test("ActionCreationConfigView can be decoded from mock and re-encoded")
    func actionCreationConfigViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionCreationConfigView.json")

        // Test decoding
        let decoded = try decoder.decode(ActionCreationConfigView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionCreationConfigView.self, from: encoded)
    }

    @Test("ActionError can be decoded from mock and re-encoded")
    func actionErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionError.json")

        // Test decoding
        let decoded = try decoder.decode(ActionError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionError.self, from: encoded)
    }

    @Test("ActionErrorKind variant 0 can be decoded and re-encoded")
    func actionErrorKindVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 1 can be decoded and re-encoded")
    func actionErrorKindVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 10 can be decoded and re-encoded")
    func actionErrorKindVariant10DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant10.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 11 can be decoded and re-encoded")
    func actionErrorKindVariant11DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant11.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 12 can be decoded and re-encoded")
    func actionErrorKindVariant12DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant12.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 13 can be decoded and re-encoded")
    func actionErrorKindVariant13DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant13.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 14 can be decoded and re-encoded")
    func actionErrorKindVariant14DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant14.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 15 can be decoded and re-encoded")
    func actionErrorKindVariant15DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant15.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 16 can be decoded and re-encoded")
    func actionErrorKindVariant16DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant16.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 17 can be decoded and re-encoded")
    func actionErrorKindVariant17DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant17.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 18 can be decoded and re-encoded")
    func actionErrorKindVariant18DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant18.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 19 can be decoded and re-encoded")
    func actionErrorKindVariant19DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant19.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 2 can be decoded and re-encoded")
    func actionErrorKindVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 20 can be decoded and re-encoded")
    func actionErrorKindVariant20DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant20.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 21 can be decoded and re-encoded")
    func actionErrorKindVariant21DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant21.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 22 can be decoded and re-encoded")
    func actionErrorKindVariant22DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant22.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 23 can be decoded and re-encoded")
    func actionErrorKindVariant23DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant23.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 24 can be decoded and re-encoded")
    func actionErrorKindVariant24DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant24.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 3 can be decoded and re-encoded")
    func actionErrorKindVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 4 can be decoded and re-encoded")
    func actionErrorKindVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 5 can be decoded and re-encoded")
    func actionErrorKindVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 6 can be decoded and re-encoded")
    func actionErrorKindVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 7 can be decoded and re-encoded")
    func actionErrorKindVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 8 can be decoded and re-encoded")
    func actionErrorKindVariant8DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant8.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionErrorKind variant 9 can be decoded and re-encoded")
    func actionErrorKindVariant9DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant9.json")

        // Test decoding
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionErrorKind.self, from: encoded)
    }

    @Test("ActionView variant 0 can be decoded and re-encoded")
    func actionViewVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 1 can be decoded and re-encoded")
    func actionViewVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 10 can be decoded and re-encoded")
    func actionViewVariant10DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant10.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 11 can be decoded and re-encoded")
    func actionViewVariant11DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant11.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 12 can be decoded and re-encoded")
    func actionViewVariant12DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant12.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 13 can be decoded and re-encoded")
    func actionViewVariant13DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant13.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 14 can be decoded and re-encoded")
    func actionViewVariant14DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant14.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 15 can be decoded and re-encoded")
    func actionViewVariant15DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant15.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 16 can be decoded and re-encoded")
    func actionViewVariant16DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant16.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 2 can be decoded and re-encoded")
    func actionViewVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 3 can be decoded and re-encoded")
    func actionViewVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 4 can be decoded and re-encoded")
    func actionViewVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 5 can be decoded and re-encoded")
    func actionViewVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 6 can be decoded and re-encoded")
    func actionViewVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 7 can be decoded and re-encoded")
    func actionViewVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 8 can be decoded and re-encoded")
    func actionViewVariant8DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant8.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionView variant 9 can be decoded and re-encoded")
    func actionViewVariant9DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionView_Variant9.json")

        // Test decoding
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionView.self, from: encoded)
    }

    @Test("ActionsValidationError variant 0 can be decoded and re-encoded")
    func actionsValidationErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 1 can be decoded and re-encoded")
    func actionsValidationErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 10 can be decoded and re-encoded")
    func actionsValidationErrorVariant10DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant10.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 11 can be decoded and re-encoded")
    func actionsValidationErrorVariant11DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant11.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 12 can be decoded and re-encoded")
    func actionsValidationErrorVariant12DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant12.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 13 can be decoded and re-encoded")
    func actionsValidationErrorVariant13DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant13.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 14 can be decoded and re-encoded")
    func actionsValidationErrorVariant14DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant14.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 15 can be decoded and re-encoded")
    func actionsValidationErrorVariant15DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant15.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 16 can be decoded and re-encoded")
    func actionsValidationErrorVariant16DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant16.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 17 can be decoded and re-encoded")
    func actionsValidationErrorVariant17DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant17.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 18 can be decoded and re-encoded")
    func actionsValidationErrorVariant18DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant18.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 2 can be decoded and re-encoded")
    func actionsValidationErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 3 can be decoded and re-encoded")
    func actionsValidationErrorVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 4 can be decoded and re-encoded")
    func actionsValidationErrorVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 5 can be decoded and re-encoded")
    func actionsValidationErrorVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 6 can be decoded and re-encoded")
    func actionsValidationErrorVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 7 can be decoded and re-encoded")
    func actionsValidationErrorVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 8 can be decoded and re-encoded")
    func actionsValidationErrorVariant8DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant8.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("ActionsValidationError variant 9 can be decoded and re-encoded")
    func actionsValidationErrorVariant9DecodingAndEncoding() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant9.json")

        // Test decoding
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ActionsValidationError.self, from: encoded)
    }

    @Test("AddGasKeyAction can be decoded from mock and re-encoded")
    func addGasKeyActionDecodingAndEncoding() throws {
        let data = try loadMockJSON("AddGasKeyAction.json")

        // Test decoding
        let decoded = try decoder.decode(AddGasKeyAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AddGasKeyAction.self, from: encoded)
    }

    @Test("AddKeyAction can be decoded from mock and re-encoded")
    func addKeyActionDecodingAndEncoding() throws {
        let data = try loadMockJSON("AddKeyAction.json")

        // Test decoding
        let decoded = try decoder.decode(AddKeyAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(AddKeyAction.self, from: encoded)
    }

    @Test("BandwidthRequest can be decoded from mock and re-encoded")
    func bandwidthRequestDecodingAndEncoding() throws {
        let data = try loadMockJSON("BandwidthRequest.json")

        // Test decoding
        let decoded = try decoder.decode(BandwidthRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(BandwidthRequest.self, from: encoded)
    }

    @Test("BandwidthRequestBitmap can be decoded from mock and re-encoded")
    func bandwidthRequestBitmapDecodingAndEncoding() throws {
        let data = try loadMockJSON("BandwidthRequestBitmap.json")

        // Test decoding
        let decoded = try decoder.decode(BandwidthRequestBitmap.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(BandwidthRequestBitmap.self, from: encoded)
    }

    @Test("BandwidthRequests variant 0 can be decoded and re-encoded")
    func bandwidthRequestsVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("BandwidthRequests_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(BandwidthRequests.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(BandwidthRequests.self, from: encoded)
    }

    @Test("BandwidthRequestsV1 can be decoded from mock and re-encoded")
    func bandwidthRequestsV1DecodingAndEncoding() throws {
        let data = try loadMockJSON("BandwidthRequestsV1.json")

        // Test decoding
        let decoded = try decoder.decode(BandwidthRequestsV1.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(BandwidthRequestsV1.self, from: encoded)
    }

    @Test("BlockHeaderInnerLiteView can be decoded from mock and re-encoded")
    func blockHeaderInnerLiteViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("BlockHeaderInnerLiteView.json")

        // Test decoding
        let decoded = try decoder.decode(BlockHeaderInnerLiteView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(BlockHeaderInnerLiteView.self, from: encoded)
    }

    @Test("BlockHeaderView can be decoded from mock and re-encoded")
    func blockHeaderViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("BlockHeaderView.json")

        // Test decoding
        let decoded = try decoder.decode(BlockHeaderView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(BlockHeaderView.self, from: encoded)
    }

    @Test("BlockId variant 0 can be decoded and re-encoded")
    func blockIdVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("BlockId_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(BlockId.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(BlockId.self, from: encoded)
    }

    @Test("BlockId variant 1 can be decoded and re-encoded")
    func blockIdVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("BlockId_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(BlockId.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(BlockId.self, from: encoded)
    }

    @Test("BlockReference variant 0 can be decoded and re-encoded")
    func blockReferenceVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("BlockReference_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(BlockReference.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(BlockReference.self, from: encoded)
    }

    @Test("BlockReference variant 1 can be decoded and re-encoded")
    func blockReferenceVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("BlockReference_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(BlockReference.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(BlockReference.self, from: encoded)
    }

    @Test("BlockReference variant 2 can be decoded and re-encoded")
    func blockReferenceVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("BlockReference_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(BlockReference.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(BlockReference.self, from: encoded)
    }

    @Test("BlockStatusView can be decoded from mock and re-encoded")
    func blockStatusViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("BlockStatusView.json")

        // Test decoding
        let decoded = try decoder.decode(BlockStatusView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(BlockStatusView.self, from: encoded)
    }

    @Test("CallResult can be decoded from mock and re-encoded")
    func callResultDecodingAndEncoding() throws {
        let data = try loadMockJSON("CallResult.json")

        // Test decoding
        let decoded = try decoder.decode(CallResult.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(CallResult.self, from: encoded)
    }

    @Test("CatchupStatusView can be decoded from mock and re-encoded")
    func catchupStatusViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("CatchupStatusView.json")

        // Test decoding
        let decoded = try decoder.decode(CatchupStatusView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(CatchupStatusView.self, from: encoded)
    }

    @Test("ChunkDistributionNetworkConfig can be decoded from mock and re-encoded")
    func chunkDistributionNetworkConfigDecodingAndEncoding() throws {
        let data = try loadMockJSON("ChunkDistributionNetworkConfig.json")

        // Test decoding
        let decoded = try decoder.decode(ChunkDistributionNetworkConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ChunkDistributionNetworkConfig.self, from: encoded)
    }

    @Test("ChunkDistributionUris can be decoded from mock and re-encoded")
    func chunkDistributionUrisDecodingAndEncoding() throws {
        let data = try loadMockJSON("ChunkDistributionUris.json")

        // Test decoding
        let decoded = try decoder.decode(ChunkDistributionUris.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ChunkDistributionUris.self, from: encoded)
    }

    @Test("ChunkHeaderView can be decoded from mock and re-encoded")
    func chunkHeaderViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("ChunkHeaderView.json")

        // Test decoding
        let decoded = try decoder.decode(ChunkHeaderView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ChunkHeaderView.self, from: encoded)
    }

    @Test("CloudArchivalWriterConfig can be decoded from mock and re-encoded")
    func cloudArchivalWriterConfigDecodingAndEncoding() throws {
        let data = try loadMockJSON("CloudArchivalWriterConfig.json")

        // Test decoding
        let decoded = try decoder.decode(CloudArchivalWriterConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(CloudArchivalWriterConfig.self, from: encoded)
    }

    @Test("CompilationError variant 0 can be decoded and re-encoded")
    func compilationErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("CompilationError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(CompilationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(CompilationError.self, from: encoded)
    }

    @Test("CompilationError variant 1 can be decoded and re-encoded")
    func compilationErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("CompilationError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(CompilationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(CompilationError.self, from: encoded)
    }

    @Test("CompilationError variant 2 can be decoded and re-encoded")
    func compilationErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("CompilationError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(CompilationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(CompilationError.self, from: encoded)
    }

    @Test("CongestionControlConfigView can be decoded from mock and re-encoded")
    func congestionControlConfigViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("CongestionControlConfigView.json")

        // Test decoding
        let decoded = try decoder.decode(CongestionControlConfigView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(CongestionControlConfigView.self, from: encoded)
    }

    @Test("CongestionInfoView can be decoded from mock and re-encoded")
    func congestionInfoViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("CongestionInfoView.json")

        // Test decoding
        let decoded = try decoder.decode(CongestionInfoView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(CongestionInfoView.self, from: encoded)
    }

    @Test("ContractCodeView can be decoded from mock and re-encoded")
    func contractCodeViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("ContractCodeView.json")

        // Test decoding
        let decoded = try decoder.decode(ContractCodeView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ContractCodeView.self, from: encoded)
    }

    @Test("CostGasUsed can be decoded from mock and re-encoded")
    func costGasUsedDecodingAndEncoding() throws {
        let data = try loadMockJSON("CostGasUsed.json")

        // Test decoding
        let decoded = try decoder.decode(CostGasUsed.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(CostGasUsed.self, from: encoded)
    }

    @Test("CurrentEpochValidatorInfo can be decoded from mock and re-encoded")
    func currentEpochValidatorInfoDecodingAndEncoding() throws {
        let data = try loadMockJSON("CurrentEpochValidatorInfo.json")

        // Test decoding
        let decoded = try decoder.decode(CurrentEpochValidatorInfo.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(CurrentEpochValidatorInfo.self, from: encoded)
    }

    @Test("DataReceiptCreationConfigView can be decoded from mock and re-encoded")
    func dataReceiptCreationConfigViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("DataReceiptCreationConfigView.json")

        // Test decoding
        let decoded = try decoder.decode(DataReceiptCreationConfigView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(DataReceiptCreationConfigView.self, from: encoded)
    }

    @Test("DataReceiverView can be decoded from mock and re-encoded")
    func dataReceiverViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("DataReceiverView.json")

        // Test decoding
        let decoded = try decoder.decode(DataReceiverView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(DataReceiverView.self, from: encoded)
    }

    @Test("DelegateAction can be decoded from mock and re-encoded")
    func delegateActionDecodingAndEncoding() throws {
        let data = try loadMockJSON("DelegateAction.json")

        // Test decoding
        let decoded = try decoder.decode(DelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(DelegateAction.self, from: encoded)
    }

    @Test("DeleteAccountAction can be decoded from mock and re-encoded")
    func deleteAccountActionDecodingAndEncoding() throws {
        let data = try loadMockJSON("DeleteAccountAction.json")

        // Test decoding
        let decoded = try decoder.decode(DeleteAccountAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(DeleteAccountAction.self, from: encoded)
    }

    @Test("DeleteGasKeyAction can be decoded from mock and re-encoded")
    func deleteGasKeyActionDecodingAndEncoding() throws {
        let data = try loadMockJSON("DeleteGasKeyAction.json")

        // Test decoding
        let decoded = try decoder.decode(DeleteGasKeyAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(DeleteGasKeyAction.self, from: encoded)
    }

    @Test("DeleteKeyAction can be decoded from mock and re-encoded")
    func deleteKeyActionDecodingAndEncoding() throws {
        let data = try loadMockJSON("DeleteKeyAction.json")

        // Test decoding
        let decoded = try decoder.decode(DeleteKeyAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(DeleteKeyAction.self, from: encoded)
    }

    @Test("DeployContractAction can be decoded from mock and re-encoded")
    func deployContractActionDecodingAndEncoding() throws {
        let data = try loadMockJSON("DeployContractAction.json")

        // Test decoding
        let decoded = try decoder.decode(DeployContractAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(DeployContractAction.self, from: encoded)
    }

    @Test("DeployGlobalContractAction can be decoded from mock and re-encoded")
    func deployGlobalContractActionDecodingAndEncoding() throws {
        let data = try loadMockJSON("DeployGlobalContractAction.json")

        // Test decoding
        let decoded = try decoder.decode(DeployGlobalContractAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(DeployGlobalContractAction.self, from: encoded)
    }

    @Test("DetailedDebugStatus can be decoded from mock and re-encoded")
    func detailedDebugStatusDecodingAndEncoding() throws {
        let data = try loadMockJSON("DetailedDebugStatus.json")

        // Test decoding
        let decoded = try decoder.decode(DetailedDebugStatus.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(DetailedDebugStatus.self, from: encoded)
    }

    @Test("DeterministicAccountStateInit variant 0 can be decoded and re-encoded")
    func deterministicAccountStateInitVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("DeterministicAccountStateInit_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(DeterministicAccountStateInit.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(DeterministicAccountStateInit.self, from: encoded)
    }

    @Test("DeterministicAccountStateInitV1 can be decoded from mock and re-encoded")
    func deterministicAccountStateInitV1DecodingAndEncoding() throws {
        let data = try loadMockJSON("DeterministicAccountStateInitV1.json")

        // Test decoding
        let decoded = try decoder.decode(DeterministicAccountStateInitV1.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(DeterministicAccountStateInitV1.self, from: encoded)
    }

    @Test("DeterministicStateInitAction can be decoded from mock and re-encoded")
    func deterministicStateInitActionDecodingAndEncoding() throws {
        let data = try loadMockJSON("DeterministicStateInitAction.json")

        // Test decoding
        let decoded = try decoder.decode(DeterministicStateInitAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(DeterministicStateInitAction.self, from: encoded)
    }

    @Test("Direction can be decoded from mock and re-encoded")
    func directionDecodingAndEncoding() throws {
        let data = try loadMockJSON("Direction.json")

        // Test decoding
        let decoded = try decoder.decode(Direction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(Direction.self, from: encoded)
    }

    @Test("DumpConfig can be decoded from mock and re-encoded")
    func dumpConfigDecodingAndEncoding() throws {
        let data = try loadMockJSON("DumpConfig.json")

        // Test decoding
        let decoded = try decoder.decode(DumpConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(DumpConfig.self, from: encoded)
    }

    @Test("DurationAsStdSchemaProvider can be decoded from mock and re-encoded")
    func durationAsStdSchemaProviderDecodingAndEncoding() throws {
        let data = try loadMockJSON("DurationAsStdSchemaProvider.json")

        // Test decoding
        let decoded = try decoder.decode(DurationAsStdSchemaProvider.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(DurationAsStdSchemaProvider.self, from: encoded)
    }

    @Test("EpochId can be decoded from mock and re-encoded")
    func epochIdDecodingAndEncoding() throws {
        let data = try loadMockJSON("EpochId.json")

        // Test decoding
        let decoded = try decoder.decode(EpochId.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(EpochId.self, from: encoded)
    }

    @Test("EpochSyncConfig can be decoded from mock and re-encoded")
    func epochSyncConfigDecodingAndEncoding() throws {
        let data = try loadMockJSON("EpochSyncConfig.json")

        // Test decoding
        let decoded = try decoder.decode(EpochSyncConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(EpochSyncConfig.self, from: encoded)
    }

    @Test("ExecutionMetadataView can be decoded from mock and re-encoded")
    func executionMetadataViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("ExecutionMetadataView.json")

        // Test decoding
        let decoded = try decoder.decode(ExecutionMetadataView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ExecutionMetadataView.self, from: encoded)
    }

    @Test("ExecutionOutcomeView can be decoded from mock and re-encoded")
    func executionOutcomeViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("ExecutionOutcomeView.json")

        // Test decoding
        let decoded = try decoder.decode(ExecutionOutcomeView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ExecutionOutcomeView.self, from: encoded)
    }

    @Test("ExecutionOutcomeWithIdView can be decoded from mock and re-encoded")
    func executionOutcomeWithIdViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("ExecutionOutcomeWithIdView.json")

        // Test decoding
        let decoded = try decoder.decode(ExecutionOutcomeWithIdView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ExecutionOutcomeWithIdView.self, from: encoded)
    }

    @Test("ExecutionStatusView variant 0 can be decoded and re-encoded")
    func executionStatusViewVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("ExecutionStatusView_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(ExecutionStatusView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ExecutionStatusView.self, from: encoded)
    }

    @Test("ExecutionStatusView variant 1 can be decoded and re-encoded")
    func executionStatusViewVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("ExecutionStatusView_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(ExecutionStatusView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ExecutionStatusView.self, from: encoded)
    }

    @Test("ExecutionStatusView variant 2 can be decoded and re-encoded")
    func executionStatusViewVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("ExecutionStatusView_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(ExecutionStatusView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ExecutionStatusView.self, from: encoded)
    }

    @Test("ExecutionStatusView variant 3 can be decoded and re-encoded")
    func executionStatusViewVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("ExecutionStatusView_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(ExecutionStatusView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ExecutionStatusView.self, from: encoded)
    }

    @Test("ExtCostsConfigView can be decoded from mock and re-encoded")
    func extCostsConfigViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("ExtCostsConfigView.json")

        // Test decoding
        let decoded = try decoder.decode(ExtCostsConfigView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ExtCostsConfigView.self, from: encoded)
    }

    @Test("ExternalStorageConfig can be decoded from mock and re-encoded")
    func externalStorageConfigDecodingAndEncoding() throws {
        let data = try loadMockJSON("ExternalStorageConfig.json")

        // Test decoding
        let decoded = try decoder.decode(ExternalStorageConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ExternalStorageConfig.self, from: encoded)
    }

    @Test("ExternalStorageLocation variant 0 can be decoded and re-encoded")
    func externalStorageLocationVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("ExternalStorageLocation_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(ExternalStorageLocation.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ExternalStorageLocation.self, from: encoded)
    }

    @Test("ExternalStorageLocation variant 1 can be decoded and re-encoded")
    func externalStorageLocationVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("ExternalStorageLocation_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(ExternalStorageLocation.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ExternalStorageLocation.self, from: encoded)
    }

    @Test("ExternalStorageLocation variant 2 can be decoded and re-encoded")
    func externalStorageLocationVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("ExternalStorageLocation_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(ExternalStorageLocation.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ExternalStorageLocation.self, from: encoded)
    }

    @Test("Fee can be decoded from mock and re-encoded")
    func feeDecodingAndEncoding() throws {
        let data = try loadMockJSON("Fee.json")

        // Test decoding
        let decoded = try decoder.decode(Fee.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(Fee.self, from: encoded)
    }

    @Test("FinalExecutionOutcomeView can be decoded from mock and re-encoded")
    func finalExecutionOutcomeViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("FinalExecutionOutcomeView.json")

        // Test decoding
        let decoded = try decoder.decode(FinalExecutionOutcomeView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(FinalExecutionOutcomeView.self, from: encoded)
    }

    @Test("FinalExecutionOutcomeWithReceiptView can be decoded from mock and re-encoded")
    func finalExecutionOutcomeWithReceiptViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("FinalExecutionOutcomeWithReceiptView.json")

        // Test decoding
        let decoded = try decoder.decode(FinalExecutionOutcomeWithReceiptView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(FinalExecutionOutcomeWithReceiptView.self, from: encoded)
    }

    @Test("FinalExecutionStatus variant 0 can be decoded and re-encoded")
    func finalExecutionStatusVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("FinalExecutionStatus_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(FinalExecutionStatus.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(FinalExecutionStatus.self, from: encoded)
    }

    @Test("FinalExecutionStatus variant 1 can be decoded and re-encoded")
    func finalExecutionStatusVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("FinalExecutionStatus_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(FinalExecutionStatus.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(FinalExecutionStatus.self, from: encoded)
    }

    @Test("FinalExecutionStatus variant 2 can be decoded and re-encoded")
    func finalExecutionStatusVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("FinalExecutionStatus_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(FinalExecutionStatus.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(FinalExecutionStatus.self, from: encoded)
    }

    @Test("FinalExecutionStatus variant 3 can be decoded and re-encoded")
    func finalExecutionStatusVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("FinalExecutionStatus_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(FinalExecutionStatus.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(FinalExecutionStatus.self, from: encoded)
    }

    @Test("Finality can be decoded from mock and re-encoded")
    func finalityDecodingAndEncoding() throws {
        let data = try loadMockJSON("Finality.json")

        // Test decoding
        let decoded = try decoder.decode(Finality.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(Finality.self, from: encoded)
    }

    @Test("FunctionCallAction can be decoded from mock and re-encoded")
    func functionCallActionDecodingAndEncoding() throws {
        let data = try loadMockJSON("FunctionCallAction.json")

        // Test decoding
        let decoded = try decoder.decode(FunctionCallAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(FunctionCallAction.self, from: encoded)
    }

    @Test("FunctionCallError variant 0 can be decoded and re-encoded")
    func functionCallErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("FunctionCallError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(FunctionCallError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(FunctionCallError.self, from: encoded)
    }

    @Test("FunctionCallError variant 1 can be decoded and re-encoded")
    func functionCallErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("FunctionCallError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(FunctionCallError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(FunctionCallError.self, from: encoded)
    }

    @Test("FunctionCallError variant 2 can be decoded and re-encoded")
    func functionCallErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("FunctionCallError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(FunctionCallError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(FunctionCallError.self, from: encoded)
    }

    @Test("FunctionCallError variant 3 can be decoded and re-encoded")
    func functionCallErrorVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("FunctionCallError_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(FunctionCallError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(FunctionCallError.self, from: encoded)
    }

    @Test("FunctionCallError variant 4 can be decoded and re-encoded")
    func functionCallErrorVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("FunctionCallError_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(FunctionCallError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(FunctionCallError.self, from: encoded)
    }

    @Test("FunctionCallError variant 5 can be decoded and re-encoded")
    func functionCallErrorVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("FunctionCallError_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(FunctionCallError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(FunctionCallError.self, from: encoded)
    }

    @Test("FunctionCallError variant 6 can be decoded and re-encoded")
    func functionCallErrorVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("FunctionCallError_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(FunctionCallError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(FunctionCallError.self, from: encoded)
    }

    @Test("FunctionCallPermission can be decoded from mock and re-encoded")
    func functionCallPermissionDecodingAndEncoding() throws {
        let data = try loadMockJSON("FunctionCallPermission.json")

        // Test decoding
        let decoded = try decoder.decode(FunctionCallPermission.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(FunctionCallPermission.self, from: encoded)
    }

    @Test("GCConfig can be decoded from mock and re-encoded")
    func gCConfigDecodingAndEncoding() throws {
        let data = try loadMockJSON("GCConfig.json")

        // Test decoding
        let decoded = try decoder.decode(GCConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(GCConfig.self, from: encoded)
    }

    @Test("GasKey can be decoded from mock and re-encoded")
    func gasKeyDecodingAndEncoding() throws {
        let data = try loadMockJSON("GasKey.json")

        // Test decoding
        let decoded = try decoder.decode(GasKey.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(GasKey.self, from: encoded)
    }

    @Test("GasKeyInfoView can be decoded from mock and re-encoded")
    func gasKeyInfoViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("GasKeyInfoView.json")

        // Test decoding
        let decoded = try decoder.decode(GasKeyInfoView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(GasKeyInfoView.self, from: encoded)
    }

    @Test("GasKeyList can be decoded from mock and re-encoded")
    func gasKeyListDecodingAndEncoding() throws {
        let data = try loadMockJSON("GasKeyList.json")

        // Test decoding
        let decoded = try decoder.decode(GasKeyList.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(GasKeyList.self, from: encoded)
    }

    @Test("GasKeyView can be decoded from mock and re-encoded")
    func gasKeyViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("GasKeyView.json")

        // Test decoding
        let decoded = try decoder.decode(GasKeyView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(GasKeyView.self, from: encoded)
    }

    @Test("GenesisConfig can be decoded from mock and re-encoded")
    func genesisConfigDecodingAndEncoding() throws {
        let data = try loadMockJSON("GenesisConfig.json")

        // Test decoding
        let decoded = try decoder.decode(GenesisConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(GenesisConfig.self, from: encoded)
    }

    @Test("GenesisConfigError can be decoded from mock and re-encoded")
    func genesisConfigErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("GenesisConfigError.json")

        // Test decoding
        let decoded = try decoder.decode(GenesisConfigError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(GenesisConfigError.self, from: encoded)
    }

    @Test("GenesisConfigRequest can be decoded from mock and re-encoded")
    func genesisConfigRequestDecodingAndEncoding() throws {
        let data = try loadMockJSON("GenesisConfigRequest.json")

        // Test decoding
        let decoded = try decoder.decode(GenesisConfigRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(GenesisConfigRequest.self, from: encoded)
    }

    @Test("GlobalContractDeployMode variant 0 can be decoded and re-encoded")
    func globalContractDeployModeVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("GlobalContractDeployMode_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(GlobalContractDeployMode.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(GlobalContractDeployMode.self, from: encoded)
    }

    @Test("GlobalContractDeployMode variant 1 can be decoded and re-encoded")
    func globalContractDeployModeVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("GlobalContractDeployMode_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(GlobalContractDeployMode.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(GlobalContractDeployMode.self, from: encoded)
    }

    @Test("GlobalContractIdentifier variant 0 can be decoded and re-encoded")
    func globalContractIdentifierVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("GlobalContractIdentifier_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(GlobalContractIdentifier.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(GlobalContractIdentifier.self, from: encoded)
    }

    @Test("GlobalContractIdentifier variant 1 can be decoded and re-encoded")
    func globalContractIdentifierVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("GlobalContractIdentifier_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(GlobalContractIdentifier.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(GlobalContractIdentifier.self, from: encoded)
    }

    @Test("GlobalContractIdentifierView variant 0 can be decoded and re-encoded")
    func globalContractIdentifierViewVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("GlobalContractIdentifierView_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(GlobalContractIdentifierView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(GlobalContractIdentifierView.self, from: encoded)
    }

    @Test("GlobalContractIdentifierView variant 1 can be decoded and re-encoded")
    func globalContractIdentifierViewVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("GlobalContractIdentifierView_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(GlobalContractIdentifierView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(GlobalContractIdentifierView.self, from: encoded)
    }

    @Test("HostError variant 0 can be decoded and re-encoded")
    func hostErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 1 can be decoded and re-encoded")
    func hostErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 10 can be decoded and re-encoded")
    func hostErrorVariant10DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant10.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 11 can be decoded and re-encoded")
    func hostErrorVariant11DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant11.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 12 can be decoded and re-encoded")
    func hostErrorVariant12DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant12.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 13 can be decoded and re-encoded")
    func hostErrorVariant13DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant13.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 14 can be decoded and re-encoded")
    func hostErrorVariant14DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant14.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 15 can be decoded and re-encoded")
    func hostErrorVariant15DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant15.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 16 can be decoded and re-encoded")
    func hostErrorVariant16DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant16.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 17 can be decoded and re-encoded")
    func hostErrorVariant17DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant17.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 18 can be decoded and re-encoded")
    func hostErrorVariant18DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant18.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 19 can be decoded and re-encoded")
    func hostErrorVariant19DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant19.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 2 can be decoded and re-encoded")
    func hostErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 20 can be decoded and re-encoded")
    func hostErrorVariant20DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant20.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 21 can be decoded and re-encoded")
    func hostErrorVariant21DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant21.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 22 can be decoded and re-encoded")
    func hostErrorVariant22DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant22.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 23 can be decoded and re-encoded")
    func hostErrorVariant23DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant23.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 24 can be decoded and re-encoded")
    func hostErrorVariant24DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant24.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 25 can be decoded and re-encoded")
    func hostErrorVariant25DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant25.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 26 can be decoded and re-encoded")
    func hostErrorVariant26DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant26.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 27 can be decoded and re-encoded")
    func hostErrorVariant27DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant27.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 28 can be decoded and re-encoded")
    func hostErrorVariant28DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant28.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 29 can be decoded and re-encoded")
    func hostErrorVariant29DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant29.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 3 can be decoded and re-encoded")
    func hostErrorVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 30 can be decoded and re-encoded")
    func hostErrorVariant30DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant30.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 31 can be decoded and re-encoded")
    func hostErrorVariant31DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant31.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 32 can be decoded and re-encoded")
    func hostErrorVariant32DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant32.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 4 can be decoded and re-encoded")
    func hostErrorVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 5 can be decoded and re-encoded")
    func hostErrorVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 6 can be decoded and re-encoded")
    func hostErrorVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 7 can be decoded and re-encoded")
    func hostErrorVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 8 can be decoded and re-encoded")
    func hostErrorVariant8DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant8.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("HostError variant 9 can be decoded and re-encoded")
    func hostErrorVariant9DecodingAndEncoding() throws {
        let data = try loadMockJSON("HostError_Variant9.json")

        // Test decoding
        let decoded = try decoder.decode(HostError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(HostError.self, from: encoded)
    }

    @Test("InternalError variant 0 can be decoded and re-encoded")
    func internalErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("InternalError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(InternalError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InternalError.self, from: encoded)
    }

    @Test("InvalidAccessKeyError variant 0 can be decoded and re-encoded")
    func invalidAccessKeyErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidAccessKeyError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidAccessKeyError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidAccessKeyError.self, from: encoded)
    }

    @Test("InvalidAccessKeyError variant 1 can be decoded and re-encoded")
    func invalidAccessKeyErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidAccessKeyError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidAccessKeyError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidAccessKeyError.self, from: encoded)
    }

    @Test("InvalidAccessKeyError variant 2 can be decoded and re-encoded")
    func invalidAccessKeyErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidAccessKeyError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidAccessKeyError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidAccessKeyError.self, from: encoded)
    }

    @Test("InvalidAccessKeyError variant 3 can be decoded and re-encoded")
    func invalidAccessKeyErrorVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidAccessKeyError_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidAccessKeyError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidAccessKeyError.self, from: encoded)
    }

    @Test("InvalidAccessKeyError variant 4 can be decoded and re-encoded")
    func invalidAccessKeyErrorVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidAccessKeyError_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidAccessKeyError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidAccessKeyError.self, from: encoded)
    }

    @Test("InvalidAccessKeyError variant 5 can be decoded and re-encoded")
    func invalidAccessKeyErrorVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidAccessKeyError_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidAccessKeyError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidAccessKeyError.self, from: encoded)
    }

    @Test("InvalidTxError variant 0 can be decoded and re-encoded")
    func invalidTxErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 1 can be decoded and re-encoded")
    func invalidTxErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 10 can be decoded and re-encoded")
    func invalidTxErrorVariant10DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant10.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 11 can be decoded and re-encoded")
    func invalidTxErrorVariant11DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant11.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 12 can be decoded and re-encoded")
    func invalidTxErrorVariant12DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant12.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 13 can be decoded and re-encoded")
    func invalidTxErrorVariant13DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant13.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 14 can be decoded and re-encoded")
    func invalidTxErrorVariant14DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant14.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 15 can be decoded and re-encoded")
    func invalidTxErrorVariant15DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant15.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 16 can be decoded and re-encoded")
    func invalidTxErrorVariant16DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant16.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 17 can be decoded and re-encoded")
    func invalidTxErrorVariant17DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant17.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 2 can be decoded and re-encoded")
    func invalidTxErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 3 can be decoded and re-encoded")
    func invalidTxErrorVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 4 can be decoded and re-encoded")
    func invalidTxErrorVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 5 can be decoded and re-encoded")
    func invalidTxErrorVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 6 can be decoded and re-encoded")
    func invalidTxErrorVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 7 can be decoded and re-encoded")
    func invalidTxErrorVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 8 can be decoded and re-encoded")
    func invalidTxErrorVariant8DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant8.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("InvalidTxError variant 9 can be decoded and re-encoded")
    func invalidTxErrorVariant9DecodingAndEncoding() throws {
        let data = try loadMockJSON("InvalidTxError_Variant9.json")

        // Test decoding
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(InvalidTxError.self, from: encoded)
    }

    @Test("KnownProducerView can be decoded from mock and re-encoded")
    func knownProducerViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("KnownProducerView.json")

        // Test decoding
        let decoded = try decoder.decode(KnownProducerView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(KnownProducerView.self, from: encoded)
    }

    @Test("LightClientBlockLiteView can be decoded from mock and re-encoded")
    func lightClientBlockLiteViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("LightClientBlockLiteView.json")

        // Test decoding
        let decoded = try decoder.decode(LightClientBlockLiteView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(LightClientBlockLiteView.self, from: encoded)
    }

    @Test("LimitConfig can be decoded from mock and re-encoded")
    func limitConfigDecodingAndEncoding() throws {
        let data = try loadMockJSON("LimitConfig.json")

        // Test decoding
        let decoded = try decoder.decode(LimitConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(LimitConfig.self, from: encoded)
    }

    @Test("LogSummaryStyle can be decoded from mock and re-encoded")
    func logSummaryStyleDecodingAndEncoding() throws {
        let data = try loadMockJSON("LogSummaryStyle.json")

        // Test decoding
        let decoded = try decoder.decode(LogSummaryStyle.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(LogSummaryStyle.self, from: encoded)
    }

    @Test("MerklePathItem can be decoded from mock and re-encoded")
    func merklePathItemDecodingAndEncoding() throws {
        let data = try loadMockJSON("MerklePathItem.json")

        // Test decoding
        let decoded = try decoder.decode(MerklePathItem.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(MerklePathItem.self, from: encoded)
    }

    @Test("MethodResolveError can be decoded from mock and re-encoded")
    func methodResolveErrorDecodingAndEncoding() throws {
        let data = try loadMockJSON("MethodResolveError.json")

        // Test decoding
        let decoded = try decoder.decode(MethodResolveError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(MethodResolveError.self, from: encoded)
    }

    @Test("MissingTrieValue can be decoded from mock and re-encoded")
    func missingTrieValueDecodingAndEncoding() throws {
        let data = try loadMockJSON("MissingTrieValue.json")

        // Test decoding
        let decoded = try decoder.decode(MissingTrieValue.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(MissingTrieValue.self, from: encoded)
    }

    @Test("MissingTrieValueContext variant 0 can be decoded and re-encoded")
    func missingTrieValueContextVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("MissingTrieValueContext_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(MissingTrieValueContext.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(MissingTrieValueContext.self, from: encoded)
    }

    @Test("MissingTrieValueContext variant 1 can be decoded and re-encoded")
    func missingTrieValueContextVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("MissingTrieValueContext_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(MissingTrieValueContext.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(MissingTrieValueContext.self, from: encoded)
    }

    @Test("MissingTrieValueContext variant 2 can be decoded and re-encoded")
    func missingTrieValueContextVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("MissingTrieValueContext_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(MissingTrieValueContext.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(MissingTrieValueContext.self, from: encoded)
    }

    @Test("MissingTrieValueContext variant 3 can be decoded and re-encoded")
    func missingTrieValueContextVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("MissingTrieValueContext_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(MissingTrieValueContext.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(MissingTrieValueContext.self, from: encoded)
    }

    @Test("NetworkInfoView can be decoded from mock and re-encoded")
    func networkInfoViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("NetworkInfoView.json")

        // Test decoding
        let decoded = try decoder.decode(NetworkInfoView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NetworkInfoView.self, from: encoded)
    }

    @Test("NextEpochValidatorInfo can be decoded from mock and re-encoded")
    func nextEpochValidatorInfoDecodingAndEncoding() throws {
        let data = try loadMockJSON("NextEpochValidatorInfo.json")

        // Test decoding
        let decoded = try decoder.decode(NextEpochValidatorInfo.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NextEpochValidatorInfo.self, from: encoded)
    }

    @Test("NonDelegateAction variant 0 can be decoded and re-encoded")
    func nonDelegateActionVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NonDelegateAction.self, from: encoded)
    }

    @Test("NonDelegateAction variant 1 can be decoded and re-encoded")
    func nonDelegateActionVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NonDelegateAction.self, from: encoded)
    }

    @Test("NonDelegateAction variant 10 can be decoded and re-encoded")
    func nonDelegateActionVariant10DecodingAndEncoding() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant10.json")

        // Test decoding
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NonDelegateAction.self, from: encoded)
    }

    @Test("NonDelegateAction variant 11 can be decoded and re-encoded")
    func nonDelegateActionVariant11DecodingAndEncoding() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant11.json")

        // Test decoding
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NonDelegateAction.self, from: encoded)
    }

    @Test("NonDelegateAction variant 12 can be decoded and re-encoded")
    func nonDelegateActionVariant12DecodingAndEncoding() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant12.json")

        // Test decoding
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NonDelegateAction.self, from: encoded)
    }

    @Test("NonDelegateAction variant 13 can be decoded and re-encoded")
    func nonDelegateActionVariant13DecodingAndEncoding() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant13.json")

        // Test decoding
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NonDelegateAction.self, from: encoded)
    }

    @Test("NonDelegateAction variant 2 can be decoded and re-encoded")
    func nonDelegateActionVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NonDelegateAction.self, from: encoded)
    }

    @Test("NonDelegateAction variant 3 can be decoded and re-encoded")
    func nonDelegateActionVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NonDelegateAction.self, from: encoded)
    }

    @Test("NonDelegateAction variant 4 can be decoded and re-encoded")
    func nonDelegateActionVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NonDelegateAction.self, from: encoded)
    }

    @Test("NonDelegateAction variant 5 can be decoded and re-encoded")
    func nonDelegateActionVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NonDelegateAction.self, from: encoded)
    }

    @Test("NonDelegateAction variant 6 can be decoded and re-encoded")
    func nonDelegateActionVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NonDelegateAction.self, from: encoded)
    }

    @Test("NonDelegateAction variant 7 can be decoded and re-encoded")
    func nonDelegateActionVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NonDelegateAction.self, from: encoded)
    }

    @Test("NonDelegateAction variant 8 can be decoded and re-encoded")
    func nonDelegateActionVariant8DecodingAndEncoding() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant8.json")

        // Test decoding
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NonDelegateAction.self, from: encoded)
    }

    @Test("NonDelegateAction variant 9 can be decoded and re-encoded")
    func nonDelegateActionVariant9DecodingAndEncoding() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant9.json")

        // Test decoding
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(NonDelegateAction.self, from: encoded)
    }

    @Test("PeerId can be decoded from mock and re-encoded")
    func peerIdDecodingAndEncoding() throws {
        let data = try loadMockJSON("PeerId.json")

        // Test decoding
        let decoded = try decoder.decode(PeerId.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(PeerId.self, from: encoded)
    }

    @Test("PeerInfoView can be decoded from mock and re-encoded")
    func peerInfoViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("PeerInfoView.json")

        // Test decoding
        let decoded = try decoder.decode(PeerInfoView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(PeerInfoView.self, from: encoded)
    }

    @Test("PrepareError variant 0 can be decoded and re-encoded")
    func prepareErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("PrepareError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(PrepareError.self, from: encoded)
    }

    @Test("PrepareError variant 1 can be decoded and re-encoded")
    func prepareErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("PrepareError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(PrepareError.self, from: encoded)
    }

    @Test("PrepareError variant 10 can be decoded and re-encoded")
    func prepareErrorVariant10DecodingAndEncoding() throws {
        let data = try loadMockJSON("PrepareError_Variant10.json")

        // Test decoding
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(PrepareError.self, from: encoded)
    }

    @Test("PrepareError variant 2 can be decoded and re-encoded")
    func prepareErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("PrepareError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(PrepareError.self, from: encoded)
    }

    @Test("PrepareError variant 3 can be decoded and re-encoded")
    func prepareErrorVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("PrepareError_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(PrepareError.self, from: encoded)
    }

    @Test("PrepareError variant 4 can be decoded and re-encoded")
    func prepareErrorVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("PrepareError_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(PrepareError.self, from: encoded)
    }

    @Test("PrepareError variant 5 can be decoded and re-encoded")
    func prepareErrorVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("PrepareError_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(PrepareError.self, from: encoded)
    }

    @Test("PrepareError variant 6 can be decoded and re-encoded")
    func prepareErrorVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("PrepareError_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(PrepareError.self, from: encoded)
    }

    @Test("PrepareError variant 7 can be decoded and re-encoded")
    func prepareErrorVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("PrepareError_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(PrepareError.self, from: encoded)
    }

    @Test("PrepareError variant 8 can be decoded and re-encoded")
    func prepareErrorVariant8DecodingAndEncoding() throws {
        let data = try loadMockJSON("PrepareError_Variant8.json")

        // Test decoding
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(PrepareError.self, from: encoded)
    }

    @Test("PrepareError variant 9 can be decoded and re-encoded")
    func prepareErrorVariant9DecodingAndEncoding() throws {
        let data = try loadMockJSON("PrepareError_Variant9.json")

        // Test decoding
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(PrepareError.self, from: encoded)
    }

    @Test("ProtocolVersionCheckConfig can be decoded from mock and re-encoded")
    func protocolVersionCheckConfigDecodingAndEncoding() throws {
        let data = try loadMockJSON("ProtocolVersionCheckConfig.json")

        // Test decoding
        let decoded = try decoder.decode(ProtocolVersionCheckConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ProtocolVersionCheckConfig.self, from: encoded)
    }

    @Test("RangeOfUint64 can be decoded from mock and re-encoded")
    func rangeOfUint64DecodingAndEncoding() throws {
        let data = try loadMockJSON("RangeOfUint64.json")

        // Test decoding
        let decoded = try decoder.decode(RangeOfUint64.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RangeOfUint64.self, from: encoded)
    }

    @Test("ReceiptEnumView variant 0 can be decoded and re-encoded")
    func receiptEnumViewVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("ReceiptEnumView_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(ReceiptEnumView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ReceiptEnumView.self, from: encoded)
    }

    @Test("ReceiptEnumView variant 1 can be decoded and re-encoded")
    func receiptEnumViewVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("ReceiptEnumView_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(ReceiptEnumView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ReceiptEnumView.self, from: encoded)
    }

    @Test("ReceiptEnumView variant 2 can be decoded and re-encoded")
    func receiptEnumViewVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("ReceiptEnumView_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(ReceiptEnumView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ReceiptEnumView.self, from: encoded)
    }

    @Test("ReceiptValidationError variant 0 can be decoded and re-encoded")
    func receiptValidationErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ReceiptValidationError.self, from: encoded)
    }

    @Test("ReceiptValidationError variant 1 can be decoded and re-encoded")
    func receiptValidationErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ReceiptValidationError.self, from: encoded)
    }

    @Test("ReceiptValidationError variant 2 can be decoded and re-encoded")
    func receiptValidationErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ReceiptValidationError.self, from: encoded)
    }

    @Test("ReceiptValidationError variant 3 can be decoded and re-encoded")
    func receiptValidationErrorVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ReceiptValidationError.self, from: encoded)
    }

    @Test("ReceiptValidationError variant 4 can be decoded and re-encoded")
    func receiptValidationErrorVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ReceiptValidationError.self, from: encoded)
    }

    @Test("ReceiptValidationError variant 5 can be decoded and re-encoded")
    func receiptValidationErrorVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ReceiptValidationError.self, from: encoded)
    }

    @Test("ReceiptValidationError variant 6 can be decoded and re-encoded")
    func receiptValidationErrorVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ReceiptValidationError.self, from: encoded)
    }

    @Test("ReceiptValidationError variant 7 can be decoded and re-encoded")
    func receiptValidationErrorVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ReceiptValidationError.self, from: encoded)
    }

    @Test("ReceiptValidationError variant 8 can be decoded and re-encoded")
    func receiptValidationErrorVariant8DecodingAndEncoding() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant8.json")

        // Test decoding
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ReceiptValidationError.self, from: encoded)
    }

    @Test("ReceiptView can be decoded from mock and re-encoded")
    func receiptViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("ReceiptView.json")

        // Test decoding
        let decoded = try decoder.decode(ReceiptView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ReceiptView.self, from: encoded)
    }

    @Test("RpcBlockError variant 0 can be decoded and re-encoded")
    func rpcBlockErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcBlockError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcBlockError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcBlockError.self, from: encoded)
    }

    @Test("RpcBlockError variant 1 can be decoded and re-encoded")
    func rpcBlockErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcBlockError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcBlockError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcBlockError.self, from: encoded)
    }

    @Test("RpcBlockError variant 2 can be decoded and re-encoded")
    func rpcBlockErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcBlockError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcBlockError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcBlockError.self, from: encoded)
    }

    @Test("RpcBlockRequest variant 0 can be decoded and re-encoded")
    func rpcBlockRequestVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcBlockRequest_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcBlockRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcBlockRequest.self, from: encoded)
    }

    @Test("RpcBlockRequest variant 1 can be decoded and re-encoded")
    func rpcBlockRequestVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcBlockRequest_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcBlockRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcBlockRequest.self, from: encoded)
    }

    @Test("RpcBlockRequest variant 2 can be decoded and re-encoded")
    func rpcBlockRequestVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcBlockRequest_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcBlockRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcBlockRequest.self, from: encoded)
    }

    @Test("RpcBlockResponse can be decoded from mock and re-encoded")
    func rpcBlockResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcBlockResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcBlockResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcBlockResponse.self, from: encoded)
    }

    @Test("RpcChunkError variant 0 can be decoded and re-encoded")
    func rpcChunkErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcChunkError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcChunkError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcChunkError.self, from: encoded)
    }

    @Test("RpcChunkError variant 1 can be decoded and re-encoded")
    func rpcChunkErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcChunkError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcChunkError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcChunkError.self, from: encoded)
    }

    @Test("RpcChunkError variant 2 can be decoded and re-encoded")
    func rpcChunkErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcChunkError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcChunkError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcChunkError.self, from: encoded)
    }

    @Test("RpcChunkError variant 3 can be decoded and re-encoded")
    func rpcChunkErrorVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcChunkError_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(RpcChunkError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcChunkError.self, from: encoded)
    }

    @Test("RpcChunkRequest variant 0 can be decoded and re-encoded")
    func rpcChunkRequestVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcChunkRequest_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcChunkRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcChunkRequest.self, from: encoded)
    }

    @Test("RpcChunkRequest variant 1 can be decoded and re-encoded")
    func rpcChunkRequestVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcChunkRequest_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcChunkRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcChunkRequest.self, from: encoded)
    }

    @Test("RpcChunkResponse can be decoded from mock and re-encoded")
    func rpcChunkResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcChunkResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcChunkResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcChunkResponse.self, from: encoded)
    }

    @Test("RpcClientConfigError variant 0 can be decoded and re-encoded")
    func rpcClientConfigErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcClientConfigError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcClientConfigError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcClientConfigError.self, from: encoded)
    }

    @Test("RpcClientConfigRequest can be decoded from mock and re-encoded")
    func rpcClientConfigRequestDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcClientConfigRequest.json")

        // Test decoding
        let decoded = try decoder.decode(RpcClientConfigRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcClientConfigRequest.self, from: encoded)
    }

    @Test("RpcClientConfigResponse can be decoded from mock and re-encoded")
    func rpcClientConfigResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcClientConfigResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcClientConfigResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcClientConfigResponse.self, from: encoded)
    }

    @Test("RpcCongestionLevelRequest variant 0 can be decoded and re-encoded")
    func rpcCongestionLevelRequestVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcCongestionLevelRequest_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcCongestionLevelRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcCongestionLevelRequest.self, from: encoded)
    }

    @Test("RpcCongestionLevelRequest variant 1 can be decoded and re-encoded")
    func rpcCongestionLevelRequestVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcCongestionLevelRequest_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcCongestionLevelRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcCongestionLevelRequest.self, from: encoded)
    }

    @Test("RpcCongestionLevelResponse can be decoded from mock and re-encoded")
    func rpcCongestionLevelResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcCongestionLevelResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcCongestionLevelResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcCongestionLevelResponse.self, from: encoded)
    }

    @Test("RpcGasPriceError variant 0 can be decoded and re-encoded")
    func rpcGasPriceErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcGasPriceError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcGasPriceError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcGasPriceError.self, from: encoded)
    }

    @Test("RpcGasPriceError variant 1 can be decoded and re-encoded")
    func rpcGasPriceErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcGasPriceError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcGasPriceError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcGasPriceError.self, from: encoded)
    }

    @Test("RpcGasPriceRequest can be decoded from mock and re-encoded")
    func rpcGasPriceRequestDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcGasPriceRequest.json")

        // Test decoding
        let decoded = try decoder.decode(RpcGasPriceRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcGasPriceRequest.self, from: encoded)
    }

    @Test("RpcGasPriceResponse can be decoded from mock and re-encoded")
    func rpcGasPriceResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcGasPriceResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcGasPriceResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcGasPriceResponse.self, from: encoded)
    }

    @Test("RpcHealthRequest can be decoded from mock and re-encoded")
    func rpcHealthRequestDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcHealthRequest.json")

        // Test decoding
        let decoded = try decoder.decode(RpcHealthRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcHealthRequest.self, from: encoded)
    }

    @Test("RpcHealthResponse can be decoded from mock and re-encoded")
    func rpcHealthResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcHealthResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcHealthResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcHealthResponse.self, from: encoded)
    }

    @Test("RpcKnownProducer can be decoded from mock and re-encoded")
    func rpcKnownProducerDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcKnownProducer.json")

        // Test decoding
        let decoded = try decoder.decode(RpcKnownProducer.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcKnownProducer.self, from: encoded)
    }

    @Test("RpcLightClientBlockProofRequest can be decoded from mock and re-encoded")
    func rpcLightClientBlockProofRequestDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientBlockProofRequest.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientBlockProofRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientBlockProofRequest.self, from: encoded)
    }

    @Test("RpcLightClientBlockProofResponse can be decoded from mock and re-encoded")
    func rpcLightClientBlockProofResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientBlockProofResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientBlockProofResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientBlockProofResponse.self, from: encoded)
    }

    @Test("RpcLightClientExecutionProofRequest variant 0 can be decoded and re-encoded")
    func rpcLightClientExecutionProofRequestVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientExecutionProofRequest_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientExecutionProofRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientExecutionProofRequest.self, from: encoded)
    }

    @Test("RpcLightClientExecutionProofRequest variant 1 can be decoded and re-encoded")
    func rpcLightClientExecutionProofRequestVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientExecutionProofRequest_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientExecutionProofRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientExecutionProofRequest.self, from: encoded)
    }

    @Test("RpcLightClientExecutionProofResponse can be decoded from mock and re-encoded")
    func rpcLightClientExecutionProofResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientExecutionProofResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientExecutionProofResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientExecutionProofResponse.self, from: encoded)
    }

    @Test("RpcLightClientNextBlockError variant 0 can be decoded and re-encoded")
    func rpcLightClientNextBlockErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientNextBlockError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientNextBlockError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientNextBlockError.self, from: encoded)
    }

    @Test("RpcLightClientNextBlockError variant 1 can be decoded and re-encoded")
    func rpcLightClientNextBlockErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientNextBlockError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientNextBlockError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientNextBlockError.self, from: encoded)
    }

    @Test("RpcLightClientNextBlockError variant 2 can be decoded and re-encoded")
    func rpcLightClientNextBlockErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientNextBlockError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientNextBlockError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientNextBlockError.self, from: encoded)
    }

    @Test("RpcLightClientNextBlockRequest can be decoded from mock and re-encoded")
    func rpcLightClientNextBlockRequestDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientNextBlockRequest.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientNextBlockRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientNextBlockRequest.self, from: encoded)
    }

    @Test("RpcLightClientNextBlockResponse can be decoded from mock and re-encoded")
    func rpcLightClientNextBlockResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientNextBlockResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientNextBlockResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientNextBlockResponse.self, from: encoded)
    }

    @Test("RpcLightClientProofError variant 0 can be decoded and re-encoded")
    func rpcLightClientProofErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientProofError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientProofError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientProofError.self, from: encoded)
    }

    @Test("RpcLightClientProofError variant 1 can be decoded and re-encoded")
    func rpcLightClientProofErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientProofError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientProofError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientProofError.self, from: encoded)
    }

    @Test("RpcLightClientProofError variant 2 can be decoded and re-encoded")
    func rpcLightClientProofErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientProofError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientProofError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientProofError.self, from: encoded)
    }

    @Test("RpcLightClientProofError variant 3 can be decoded and re-encoded")
    func rpcLightClientProofErrorVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientProofError_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientProofError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientProofError.self, from: encoded)
    }

    @Test("RpcLightClientProofError variant 4 can be decoded and re-encoded")
    func rpcLightClientProofErrorVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientProofError_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientProofError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientProofError.self, from: encoded)
    }

    @Test("RpcLightClientProofError variant 5 can be decoded and re-encoded")
    func rpcLightClientProofErrorVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcLightClientProofError_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(RpcLightClientProofError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcLightClientProofError.self, from: encoded)
    }

    @Test("RpcMaintenanceWindowsError variant 0 can be decoded and re-encoded")
    func rpcMaintenanceWindowsErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcMaintenanceWindowsError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcMaintenanceWindowsError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcMaintenanceWindowsError.self, from: encoded)
    }

    @Test("RpcMaintenanceWindowsRequest can be decoded from mock and re-encoded")
    func rpcMaintenanceWindowsRequestDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcMaintenanceWindowsRequest.json")

        // Test decoding
        let decoded = try decoder.decode(RpcMaintenanceWindowsRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcMaintenanceWindowsRequest.self, from: encoded)
    }

    @Test("RpcNetworkInfoError variant 0 can be decoded and re-encoded")
    func rpcNetworkInfoErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcNetworkInfoError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcNetworkInfoError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcNetworkInfoError.self, from: encoded)
    }

    @Test("RpcNetworkInfoRequest can be decoded from mock and re-encoded")
    func rpcNetworkInfoRequestDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcNetworkInfoRequest.json")

        // Test decoding
        let decoded = try decoder.decode(RpcNetworkInfoRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcNetworkInfoRequest.self, from: encoded)
    }

    @Test("RpcNetworkInfoResponse can be decoded from mock and re-encoded")
    func rpcNetworkInfoResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcNetworkInfoResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcNetworkInfoResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcNetworkInfoResponse.self, from: encoded)
    }

    @Test("RpcPeerInfo can be decoded from mock and re-encoded")
    func rpcPeerInfoDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcPeerInfo.json")

        // Test decoding
        let decoded = try decoder.decode(RpcPeerInfo.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcPeerInfo.self, from: encoded)
    }

    @Test("RpcProtocolConfigError variant 0 can be decoded and re-encoded")
    func rpcProtocolConfigErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcProtocolConfigError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcProtocolConfigError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcProtocolConfigError.self, from: encoded)
    }

    @Test("RpcProtocolConfigError variant 1 can be decoded and re-encoded")
    func rpcProtocolConfigErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcProtocolConfigError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcProtocolConfigError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcProtocolConfigError.self, from: encoded)
    }

    @Test("RpcProtocolConfigRequest variant 0 can be decoded and re-encoded")
    func rpcProtocolConfigRequestVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcProtocolConfigRequest_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcProtocolConfigRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcProtocolConfigRequest.self, from: encoded)
    }

    @Test("RpcProtocolConfigRequest variant 1 can be decoded and re-encoded")
    func rpcProtocolConfigRequestVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcProtocolConfigRequest_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcProtocolConfigRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcProtocolConfigRequest.self, from: encoded)
    }

    @Test("RpcProtocolConfigRequest variant 2 can be decoded and re-encoded")
    func rpcProtocolConfigRequestVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcProtocolConfigRequest_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcProtocolConfigRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcProtocolConfigRequest.self, from: encoded)
    }

    @Test("RpcProtocolConfigResponse can be decoded from mock and re-encoded")
    func rpcProtocolConfigResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcProtocolConfigResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcProtocolConfigResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcProtocolConfigResponse.self, from: encoded)
    }

    @Test("RpcQueryError variant 0 can be decoded and re-encoded")
    func rpcQueryErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryError.self, from: encoded)
    }

    @Test("RpcQueryError variant 1 can be decoded and re-encoded")
    func rpcQueryErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryError.self, from: encoded)
    }

    @Test("RpcQueryError variant 10 can be decoded and re-encoded")
    func rpcQueryErrorVariant10DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryError_Variant10.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryError.self, from: encoded)
    }

    @Test("RpcQueryError variant 11 can be decoded and re-encoded")
    func rpcQueryErrorVariant11DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryError_Variant11.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryError.self, from: encoded)
    }

    @Test("RpcQueryError variant 12 can be decoded and re-encoded")
    func rpcQueryErrorVariant12DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryError_Variant12.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryError.self, from: encoded)
    }

    @Test("RpcQueryError variant 2 can be decoded and re-encoded")
    func rpcQueryErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryError.self, from: encoded)
    }

    @Test("RpcQueryError variant 3 can be decoded and re-encoded")
    func rpcQueryErrorVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryError_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryError.self, from: encoded)
    }

    @Test("RpcQueryError variant 4 can be decoded and re-encoded")
    func rpcQueryErrorVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryError_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryError.self, from: encoded)
    }

    @Test("RpcQueryError variant 5 can be decoded and re-encoded")
    func rpcQueryErrorVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryError_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryError.self, from: encoded)
    }

    @Test("RpcQueryError variant 6 can be decoded and re-encoded")
    func rpcQueryErrorVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryError_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryError.self, from: encoded)
    }

    @Test("RpcQueryError variant 7 can be decoded and re-encoded")
    func rpcQueryErrorVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryError_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryError.self, from: encoded)
    }

    @Test("RpcQueryError variant 8 can be decoded and re-encoded")
    func rpcQueryErrorVariant8DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryError_Variant8.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryError.self, from: encoded)
    }

    @Test("RpcQueryError variant 9 can be decoded and re-encoded")
    func rpcQueryErrorVariant9DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryError_Variant9.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryError.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 0 can be decoded and re-encoded")
    func rpcQueryRequestVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 1 can be decoded and re-encoded")
    func rpcQueryRequestVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 10 can be decoded and re-encoded")
    func rpcQueryRequestVariant10DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant10.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 11 can be decoded and re-encoded")
    func rpcQueryRequestVariant11DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant11.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 12 can be decoded and re-encoded")
    func rpcQueryRequestVariant12DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant12.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 13 can be decoded and re-encoded")
    func rpcQueryRequestVariant13DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant13.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 14 can be decoded and re-encoded")
    func rpcQueryRequestVariant14DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant14.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 15 can be decoded and re-encoded")
    func rpcQueryRequestVariant15DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant15.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 16 can be decoded and re-encoded")
    func rpcQueryRequestVariant16DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant16.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 17 can be decoded and re-encoded")
    func rpcQueryRequestVariant17DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant17.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 18 can be decoded and re-encoded")
    func rpcQueryRequestVariant18DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant18.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 19 can be decoded and re-encoded")
    func rpcQueryRequestVariant19DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant19.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 2 can be decoded and re-encoded")
    func rpcQueryRequestVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 20 can be decoded and re-encoded")
    func rpcQueryRequestVariant20DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant20.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 21 can be decoded and re-encoded")
    func rpcQueryRequestVariant21DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant21.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 22 can be decoded and re-encoded")
    func rpcQueryRequestVariant22DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant22.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 23 can be decoded and re-encoded")
    func rpcQueryRequestVariant23DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant23.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 24 can be decoded and re-encoded")
    func rpcQueryRequestVariant24DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant24.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 25 can be decoded and re-encoded")
    func rpcQueryRequestVariant25DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant25.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 26 can be decoded and re-encoded")
    func rpcQueryRequestVariant26DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant26.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 27 can be decoded and re-encoded")
    func rpcQueryRequestVariant27DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant27.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 28 can be decoded and re-encoded")
    func rpcQueryRequestVariant28DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant28.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 29 can be decoded and re-encoded")
    func rpcQueryRequestVariant29DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant29.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 3 can be decoded and re-encoded")
    func rpcQueryRequestVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 4 can be decoded and re-encoded")
    func rpcQueryRequestVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 5 can be decoded and re-encoded")
    func rpcQueryRequestVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 6 can be decoded and re-encoded")
    func rpcQueryRequestVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 7 can be decoded and re-encoded")
    func rpcQueryRequestVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 8 can be decoded and re-encoded")
    func rpcQueryRequestVariant8DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant8.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryRequest variant 9 can be decoded and re-encoded")
    func rpcQueryRequestVariant9DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant9.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryRequest.self, from: encoded)
    }

    @Test("RpcQueryResponse variant 0 can be decoded and re-encoded")
    func rpcQueryResponseVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryResponse.self, from: encoded)
    }

    @Test("RpcQueryResponse variant 1 can be decoded and re-encoded")
    func rpcQueryResponseVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryResponse.self, from: encoded)
    }

    @Test("RpcQueryResponse variant 2 can be decoded and re-encoded")
    func rpcQueryResponseVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryResponse.self, from: encoded)
    }

    @Test("RpcQueryResponse variant 3 can be decoded and re-encoded")
    func rpcQueryResponseVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryResponse.self, from: encoded)
    }

    @Test("RpcQueryResponse variant 4 can be decoded and re-encoded")
    func rpcQueryResponseVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryResponse.self, from: encoded)
    }

    @Test("RpcQueryResponse variant 5 can be decoded and re-encoded")
    func rpcQueryResponseVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryResponse.self, from: encoded)
    }

    @Test("RpcQueryResponse variant 6 can be decoded and re-encoded")
    func rpcQueryResponseVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryResponse.self, from: encoded)
    }

    @Test("RpcQueryResponse variant 7 can be decoded and re-encoded")
    func rpcQueryResponseVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcQueryResponse.self, from: encoded)
    }

    @Test("RpcReceiptError variant 0 can be decoded and re-encoded")
    func rpcReceiptErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcReceiptError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcReceiptError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcReceiptError.self, from: encoded)
    }

    @Test("RpcReceiptError variant 1 can be decoded and re-encoded")
    func rpcReceiptErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcReceiptError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcReceiptError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcReceiptError.self, from: encoded)
    }

    @Test("RpcReceiptRequest can be decoded from mock and re-encoded")
    func rpcReceiptRequestDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcReceiptRequest.json")

        // Test decoding
        let decoded = try decoder.decode(RpcReceiptRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcReceiptRequest.self, from: encoded)
    }

    @Test("RpcReceiptResponse can be decoded from mock and re-encoded")
    func rpcReceiptResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcReceiptResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcReceiptResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcReceiptResponse.self, from: encoded)
    }

    @Test("RpcRequestValidationErrorKind variant 0 can be decoded and re-encoded")
    func rpcRequestValidationErrorKindVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcRequestValidationErrorKind_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcRequestValidationErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcRequestValidationErrorKind.self, from: encoded)
    }

    @Test("RpcRequestValidationErrorKind variant 1 can be decoded and re-encoded")
    func rpcRequestValidationErrorKindVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcRequestValidationErrorKind_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcRequestValidationErrorKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcRequestValidationErrorKind.self, from: encoded)
    }

    @Test("RpcSendTransactionRequest can be decoded from mock and re-encoded")
    func rpcSendTransactionRequestDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcSendTransactionRequest.json")

        // Test decoding
        let decoded = try decoder.decode(RpcSendTransactionRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcSendTransactionRequest.self, from: encoded)
    }

    @Test("RpcSplitStorageInfoError variant 0 can be decoded and re-encoded")
    func rpcSplitStorageInfoErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcSplitStorageInfoError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcSplitStorageInfoError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcSplitStorageInfoError.self, from: encoded)
    }

    @Test("RpcSplitStorageInfoResponse can be decoded from mock and re-encoded")
    func rpcSplitStorageInfoResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcSplitStorageInfoResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcSplitStorageInfoResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcSplitStorageInfoResponse.self, from: encoded)
    }

    @Test("RpcStateChangesError variant 0 can be decoded and re-encoded")
    func rpcStateChangesErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesError.self, from: encoded)
    }

    @Test("RpcStateChangesError variant 1 can be decoded and re-encoded")
    func rpcStateChangesErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesError.self, from: encoded)
    }

    @Test("RpcStateChangesError variant 2 can be decoded and re-encoded")
    func rpcStateChangesErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesError.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 0 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 1 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 10 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant10DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant10.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 11 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant11DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant11.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 12 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant12DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant12.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 13 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant13DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant13.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 14 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant14DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant14.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 15 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant15DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant15.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 16 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant16DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant16.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 17 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant17DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant17.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 18 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant18DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant18.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 19 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant19DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant19.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 2 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 20 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant20DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant20.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 3 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 4 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 5 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 6 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 7 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 8 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant8DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant8.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 9 can be decoded and re-encoded")
    func rpcStateChangesInBlockByTypeRequestVariant9DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant9.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockByTypeResponse can be decoded from mock and re-encoded")
    func rpcStateChangesInBlockByTypeResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockByTypeResponse.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockRequest variant 0 can be decoded and re-encoded")
    func rpcStateChangesInBlockRequestVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockRequest_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockRequest variant 1 can be decoded and re-encoded")
    func rpcStateChangesInBlockRequestVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockRequest_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockRequest variant 2 can be decoded and re-encoded")
    func rpcStateChangesInBlockRequestVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockRequest_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockRequest.self, from: encoded)
    }

    @Test("RpcStateChangesInBlockResponse can be decoded from mock and re-encoded")
    func rpcStateChangesInBlockResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStateChangesInBlockResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStateChangesInBlockResponse.self, from: encoded)
    }

    @Test("RpcStatusError variant 0 can be decoded and re-encoded")
    func rpcStatusErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStatusError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStatusError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStatusError.self, from: encoded)
    }

    @Test("RpcStatusError variant 1 can be decoded and re-encoded")
    func rpcStatusErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStatusError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStatusError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStatusError.self, from: encoded)
    }

    @Test("RpcStatusError variant 2 can be decoded and re-encoded")
    func rpcStatusErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStatusError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStatusError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStatusError.self, from: encoded)
    }

    @Test("RpcStatusError variant 3 can be decoded and re-encoded")
    func rpcStatusErrorVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStatusError_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStatusError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStatusError.self, from: encoded)
    }

    @Test("RpcStatusRequest can be decoded from mock and re-encoded")
    func rpcStatusRequestDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStatusRequest.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStatusRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStatusRequest.self, from: encoded)
    }

    @Test("RpcStatusResponse can be decoded from mock and re-encoded")
    func rpcStatusResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcStatusResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcStatusResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcStatusResponse.self, from: encoded)
    }

    @Test("RpcTransactionError variant 0 can be decoded and re-encoded")
    func rpcTransactionErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcTransactionError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcTransactionError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcTransactionError.self, from: encoded)
    }

    @Test("RpcTransactionError variant 1 can be decoded and re-encoded")
    func rpcTransactionErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcTransactionError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcTransactionError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcTransactionError.self, from: encoded)
    }

    @Test("RpcTransactionError variant 2 can be decoded and re-encoded")
    func rpcTransactionErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcTransactionError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcTransactionError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcTransactionError.self, from: encoded)
    }

    @Test("RpcTransactionError variant 3 can be decoded and re-encoded")
    func rpcTransactionErrorVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcTransactionError_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(RpcTransactionError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcTransactionError.self, from: encoded)
    }

    @Test("RpcTransactionError variant 4 can be decoded and re-encoded")
    func rpcTransactionErrorVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcTransactionError_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(RpcTransactionError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcTransactionError.self, from: encoded)
    }

    @Test("RpcTransactionError variant 5 can be decoded and re-encoded")
    func rpcTransactionErrorVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcTransactionError_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(RpcTransactionError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcTransactionError.self, from: encoded)
    }

    @Test("RpcTransactionResponse variant 0 can be decoded and re-encoded")
    func rpcTransactionResponseVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcTransactionResponse_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcTransactionResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcTransactionResponse.self, from: encoded)
    }

    @Test("RpcTransactionResponse variant 1 can be decoded and re-encoded")
    func rpcTransactionResponseVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcTransactionResponse_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcTransactionResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcTransactionResponse.self, from: encoded)
    }

    @Test("RpcTransactionStatusRequest variant 0 can be decoded and re-encoded")
    func rpcTransactionStatusRequestVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcTransactionStatusRequest_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcTransactionStatusRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcTransactionStatusRequest.self, from: encoded)
    }

    @Test("RpcTransactionStatusRequest variant 1 can be decoded and re-encoded")
    func rpcTransactionStatusRequestVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcTransactionStatusRequest_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcTransactionStatusRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcTransactionStatusRequest.self, from: encoded)
    }

    @Test("RpcValidatorError variant 0 can be decoded and re-encoded")
    func rpcValidatorErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcValidatorError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcValidatorError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcValidatorError.self, from: encoded)
    }

    @Test("RpcValidatorError variant 1 can be decoded and re-encoded")
    func rpcValidatorErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcValidatorError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcValidatorError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcValidatorError.self, from: encoded)
    }

    @Test("RpcValidatorError variant 2 can be decoded and re-encoded")
    func rpcValidatorErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcValidatorError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcValidatorError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcValidatorError.self, from: encoded)
    }

    @Test("RpcValidatorRequest variant 0 can be decoded and re-encoded")
    func rpcValidatorRequestVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcValidatorRequest_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(RpcValidatorRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcValidatorRequest.self, from: encoded)
    }

    @Test("RpcValidatorRequest variant 1 can be decoded and re-encoded")
    func rpcValidatorRequestVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcValidatorRequest_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(RpcValidatorRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcValidatorRequest.self, from: encoded)
    }

    @Test("RpcValidatorRequest variant 2 can be decoded and re-encoded")
    func rpcValidatorRequestVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcValidatorRequest_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(RpcValidatorRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcValidatorRequest.self, from: encoded)
    }

    @Test("RpcValidatorResponse can be decoded from mock and re-encoded")
    func rpcValidatorResponseDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcValidatorResponse.json")

        // Test decoding
        let decoded = try decoder.decode(RpcValidatorResponse.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcValidatorResponse.self, from: encoded)
    }

    @Test("RpcValidatorsOrderedRequest can be decoded from mock and re-encoded")
    func rpcValidatorsOrderedRequestDecodingAndEncoding() throws {
        let data = try loadMockJSON("RpcValidatorsOrderedRequest.json")

        // Test decoding
        let decoded = try decoder.decode(RpcValidatorsOrderedRequest.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RpcValidatorsOrderedRequest.self, from: encoded)
    }

    @Test("RuntimeConfigView can be decoded from mock and re-encoded")
    func runtimeConfigViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("RuntimeConfigView.json")

        // Test decoding
        let decoded = try decoder.decode(RuntimeConfigView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RuntimeConfigView.self, from: encoded)
    }

    @Test("RuntimeFeesConfigView can be decoded from mock and re-encoded")
    func runtimeFeesConfigViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("RuntimeFeesConfigView.json")

        // Test decoding
        let decoded = try decoder.decode(RuntimeFeesConfigView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(RuntimeFeesConfigView.self, from: encoded)
    }

    @Test("ShardLayout variant 0 can be decoded and re-encoded")
    func shardLayoutVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("ShardLayout_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(ShardLayout.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ShardLayout.self, from: encoded)
    }

    @Test("ShardLayout variant 1 can be decoded and re-encoded")
    func shardLayoutVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("ShardLayout_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(ShardLayout.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ShardLayout.self, from: encoded)
    }

    @Test("ShardLayout variant 2 can be decoded and re-encoded")
    func shardLayoutVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("ShardLayout_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(ShardLayout.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ShardLayout.self, from: encoded)
    }

    @Test("ShardLayoutV0 can be decoded from mock and re-encoded")
    func shardLayoutV0DecodingAndEncoding() throws {
        let data = try loadMockJSON("ShardLayoutV0.json")

        // Test decoding
        let decoded = try decoder.decode(ShardLayoutV0.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ShardLayoutV0.self, from: encoded)
    }

    @Test("ShardLayoutV1 can be decoded from mock and re-encoded")
    func shardLayoutV1DecodingAndEncoding() throws {
        let data = try loadMockJSON("ShardLayoutV1.json")

        // Test decoding
        let decoded = try decoder.decode(ShardLayoutV1.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ShardLayoutV1.self, from: encoded)
    }

    @Test("ShardLayoutV2 can be decoded from mock and re-encoded")
    func shardLayoutV2DecodingAndEncoding() throws {
        let data = try loadMockJSON("ShardLayoutV2.json")

        // Test decoding
        let decoded = try decoder.decode(ShardLayoutV2.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ShardLayoutV2.self, from: encoded)
    }

    @Test("ShardUId can be decoded from mock and re-encoded")
    func shardUIdDecodingAndEncoding() throws {
        let data = try loadMockJSON("ShardUId.json")

        // Test decoding
        let decoded = try decoder.decode(ShardUId.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ShardUId.self, from: encoded)
    }

    @Test("SignedDelegateAction can be decoded from mock and re-encoded")
    func signedDelegateActionDecodingAndEncoding() throws {
        let data = try loadMockJSON("SignedDelegateAction.json")

        // Test decoding
        let decoded = try decoder.decode(SignedDelegateAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(SignedDelegateAction.self, from: encoded)
    }

    @Test("SignedTransactionView can be decoded from mock and re-encoded")
    func signedTransactionViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("SignedTransactionView.json")

        // Test decoding
        let decoded = try decoder.decode(SignedTransactionView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(SignedTransactionView.self, from: encoded)
    }

    @Test("SlashedValidator can be decoded from mock and re-encoded")
    func slashedValidatorDecodingAndEncoding() throws {
        let data = try loadMockJSON("SlashedValidator.json")

        // Test decoding
        let decoded = try decoder.decode(SlashedValidator.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(SlashedValidator.self, from: encoded)
    }

    @Test("StakeAction can be decoded from mock and re-encoded")
    func stakeActionDecodingAndEncoding() throws {
        let data = try loadMockJSON("StakeAction.json")

        // Test decoding
        let decoded = try decoder.decode(StakeAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StakeAction.self, from: encoded)
    }

    @Test("StateChangeCauseView variant 0 can be decoded and re-encoded")
    func stateChangeCauseViewVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeCauseView.self, from: encoded)
    }

    @Test("StateChangeCauseView variant 1 can be decoded and re-encoded")
    func stateChangeCauseViewVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeCauseView.self, from: encoded)
    }

    @Test("StateChangeCauseView variant 10 can be decoded and re-encoded")
    func stateChangeCauseViewVariant10DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant10.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeCauseView.self, from: encoded)
    }

    @Test("StateChangeCauseView variant 2 can be decoded and re-encoded")
    func stateChangeCauseViewVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeCauseView.self, from: encoded)
    }

    @Test("StateChangeCauseView variant 3 can be decoded and re-encoded")
    func stateChangeCauseViewVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeCauseView.self, from: encoded)
    }

    @Test("StateChangeCauseView variant 4 can be decoded and re-encoded")
    func stateChangeCauseViewVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeCauseView.self, from: encoded)
    }

    @Test("StateChangeCauseView variant 5 can be decoded and re-encoded")
    func stateChangeCauseViewVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeCauseView.self, from: encoded)
    }

    @Test("StateChangeCauseView variant 6 can be decoded and re-encoded")
    func stateChangeCauseViewVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeCauseView.self, from: encoded)
    }

    @Test("StateChangeCauseView variant 7 can be decoded and re-encoded")
    func stateChangeCauseViewVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeCauseView.self, from: encoded)
    }

    @Test("StateChangeCauseView variant 8 can be decoded and re-encoded")
    func stateChangeCauseViewVariant8DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant8.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeCauseView.self, from: encoded)
    }

    @Test("StateChangeCauseView variant 9 can be decoded and re-encoded")
    func stateChangeCauseViewVariant9DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant9.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeCauseView.self, from: encoded)
    }

    @Test("StateChangeKindView variant 0 can be decoded and re-encoded")
    func stateChangeKindViewVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeKindView_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeKindView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeKindView.self, from: encoded)
    }

    @Test("StateChangeKindView variant 1 can be decoded and re-encoded")
    func stateChangeKindViewVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeKindView_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeKindView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeKindView.self, from: encoded)
    }

    @Test("StateChangeKindView variant 2 can be decoded and re-encoded")
    func stateChangeKindViewVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeKindView_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeKindView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeKindView.self, from: encoded)
    }

    @Test("StateChangeKindView variant 3 can be decoded and re-encoded")
    func stateChangeKindViewVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeKindView_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeKindView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeKindView.self, from: encoded)
    }

    @Test("StateChangeWithCauseView variant 0 can be decoded and re-encoded")
    func stateChangeWithCauseViewVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeWithCauseView.self, from: encoded)
    }

    @Test("StateChangeWithCauseView variant 1 can be decoded and re-encoded")
    func stateChangeWithCauseViewVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeWithCauseView.self, from: encoded)
    }

    @Test("StateChangeWithCauseView variant 10 can be decoded and re-encoded")
    func stateChangeWithCauseViewVariant10DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant10.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeWithCauseView.self, from: encoded)
    }

    @Test("StateChangeWithCauseView variant 2 can be decoded and re-encoded")
    func stateChangeWithCauseViewVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeWithCauseView.self, from: encoded)
    }

    @Test("StateChangeWithCauseView variant 3 can be decoded and re-encoded")
    func stateChangeWithCauseViewVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeWithCauseView.self, from: encoded)
    }

    @Test("StateChangeWithCauseView variant 4 can be decoded and re-encoded")
    func stateChangeWithCauseViewVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeWithCauseView.self, from: encoded)
    }

    @Test("StateChangeWithCauseView variant 5 can be decoded and re-encoded")
    func stateChangeWithCauseViewVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeWithCauseView.self, from: encoded)
    }

    @Test("StateChangeWithCauseView variant 6 can be decoded and re-encoded")
    func stateChangeWithCauseViewVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeWithCauseView.self, from: encoded)
    }

    @Test("StateChangeWithCauseView variant 7 can be decoded and re-encoded")
    func stateChangeWithCauseViewVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeWithCauseView.self, from: encoded)
    }

    @Test("StateChangeWithCauseView variant 8 can be decoded and re-encoded")
    func stateChangeWithCauseViewVariant8DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant8.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeWithCauseView.self, from: encoded)
    }

    @Test("StateChangeWithCauseView variant 9 can be decoded and re-encoded")
    func stateChangeWithCauseViewVariant9DecodingAndEncoding() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant9.json")

        // Test decoding
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateChangeWithCauseView.self, from: encoded)
    }

    @Test("StateItem can be decoded from mock and re-encoded")
    func stateItemDecodingAndEncoding() throws {
        let data = try loadMockJSON("StateItem.json")

        // Test decoding
        let decoded = try decoder.decode(StateItem.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateItem.self, from: encoded)
    }

    @Test("StateSyncConfig can be decoded from mock and re-encoded")
    func stateSyncConfigDecodingAndEncoding() throws {
        let data = try loadMockJSON("StateSyncConfig.json")

        // Test decoding
        let decoded = try decoder.decode(StateSyncConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StateSyncConfig.self, from: encoded)
    }

    @Test("StatusSyncInfo can be decoded from mock and re-encoded")
    func statusSyncInfoDecodingAndEncoding() throws {
        let data = try loadMockJSON("StatusSyncInfo.json")

        // Test decoding
        let decoded = try decoder.decode(StatusSyncInfo.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StatusSyncInfo.self, from: encoded)
    }

    @Test("StorageError variant 0 can be decoded and re-encoded")
    func storageErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("StorageError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(StorageError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StorageError.self, from: encoded)
    }

    @Test("StorageError variant 1 can be decoded and re-encoded")
    func storageErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("StorageError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(StorageError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StorageError.self, from: encoded)
    }

    @Test("StorageError variant 2 can be decoded and re-encoded")
    func storageErrorVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("StorageError_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(StorageError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StorageError.self, from: encoded)
    }

    @Test("StorageError variant 3 can be decoded and re-encoded")
    func storageErrorVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("StorageError_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(StorageError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StorageError.self, from: encoded)
    }

    @Test("StorageError variant 4 can be decoded and re-encoded")
    func storageErrorVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("StorageError_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(StorageError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StorageError.self, from: encoded)
    }

    @Test("StorageError variant 5 can be decoded and re-encoded")
    func storageErrorVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("StorageError_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(StorageError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StorageError.self, from: encoded)
    }

    @Test("StorageGetMode can be decoded from mock and re-encoded")
    func storageGetModeDecodingAndEncoding() throws {
        let data = try loadMockJSON("StorageGetMode.json")

        // Test decoding
        let decoded = try decoder.decode(StorageGetMode.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StorageGetMode.self, from: encoded)
    }

    @Test("StorageUsageConfigView can be decoded from mock and re-encoded")
    func storageUsageConfigViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("StorageUsageConfigView.json")

        // Test decoding
        let decoded = try decoder.decode(StorageUsageConfigView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(StorageUsageConfigView.self, from: encoded)
    }

    @Test("SyncCheckpoint can be decoded from mock and re-encoded")
    func syncCheckpointDecodingAndEncoding() throws {
        let data = try loadMockJSON("SyncCheckpoint.json")

        // Test decoding
        let decoded = try decoder.decode(SyncCheckpoint.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(SyncCheckpoint.self, from: encoded)
    }

    @Test("SyncConcurrency can be decoded from mock and re-encoded")
    func syncConcurrencyDecodingAndEncoding() throws {
        let data = try loadMockJSON("SyncConcurrency.json")

        // Test decoding
        let decoded = try decoder.decode(SyncConcurrency.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(SyncConcurrency.self, from: encoded)
    }

    @Test("SyncConfig variant 0 can be decoded and re-encoded")
    func syncConfigVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("SyncConfig_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(SyncConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(SyncConfig.self, from: encoded)
    }

    @Test("SyncConfig variant 1 can be decoded and re-encoded")
    func syncConfigVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("SyncConfig_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(SyncConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(SyncConfig.self, from: encoded)
    }

    @Test("Tier1ProxyView can be decoded from mock and re-encoded")
    func tier1ProxyViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("Tier1ProxyView.json")

        // Test decoding
        let decoded = try decoder.decode(Tier1ProxyView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(Tier1ProxyView.self, from: encoded)
    }

    @Test("TrackedShardsConfig variant 0 can be decoded and re-encoded")
    func trackedShardsConfigVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("TrackedShardsConfig_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(TrackedShardsConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TrackedShardsConfig.self, from: encoded)
    }

    @Test("TrackedShardsConfig variant 1 can be decoded and re-encoded")
    func trackedShardsConfigVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("TrackedShardsConfig_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(TrackedShardsConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TrackedShardsConfig.self, from: encoded)
    }

    @Test("TrackedShardsConfig variant 2 can be decoded and re-encoded")
    func trackedShardsConfigVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("TrackedShardsConfig_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(TrackedShardsConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TrackedShardsConfig.self, from: encoded)
    }

    @Test("TrackedShardsConfig variant 3 can be decoded and re-encoded")
    func trackedShardsConfigVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("TrackedShardsConfig_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(TrackedShardsConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TrackedShardsConfig.self, from: encoded)
    }

    @Test("TrackedShardsConfig variant 4 can be decoded and re-encoded")
    func trackedShardsConfigVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("TrackedShardsConfig_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(TrackedShardsConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TrackedShardsConfig.self, from: encoded)
    }

    @Test("TrackedShardsConfig variant 5 can be decoded and re-encoded")
    func trackedShardsConfigVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("TrackedShardsConfig_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(TrackedShardsConfig.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TrackedShardsConfig.self, from: encoded)
    }

    @Test("TransferAction can be decoded from mock and re-encoded")
    func transferActionDecodingAndEncoding() throws {
        let data = try loadMockJSON("TransferAction.json")

        // Test decoding
        let decoded = try decoder.decode(TransferAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TransferAction.self, from: encoded)
    }

    @Test("TransferToGasKeyAction can be decoded from mock and re-encoded")
    func transferToGasKeyActionDecodingAndEncoding() throws {
        let data = try loadMockJSON("TransferToGasKeyAction.json")

        // Test decoding
        let decoded = try decoder.decode(TransferToGasKeyAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TransferToGasKeyAction.self, from: encoded)
    }

    @Test("TxExecutionError variant 0 can be decoded and re-encoded")
    func txExecutionErrorVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("TxExecutionError_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(TxExecutionError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TxExecutionError.self, from: encoded)
    }

    @Test("TxExecutionError variant 1 can be decoded and re-encoded")
    func txExecutionErrorVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("TxExecutionError_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(TxExecutionError.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TxExecutionError.self, from: encoded)
    }

    @Test("TxExecutionStatus variant 0 can be decoded and re-encoded")
    func txExecutionStatusVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("TxExecutionStatus_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(TxExecutionStatus.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TxExecutionStatus.self, from: encoded)
    }

    @Test("TxExecutionStatus variant 1 can be decoded and re-encoded")
    func txExecutionStatusVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("TxExecutionStatus_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(TxExecutionStatus.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TxExecutionStatus.self, from: encoded)
    }

    @Test("TxExecutionStatus variant 2 can be decoded and re-encoded")
    func txExecutionStatusVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("TxExecutionStatus_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(TxExecutionStatus.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TxExecutionStatus.self, from: encoded)
    }

    @Test("TxExecutionStatus variant 3 can be decoded and re-encoded")
    func txExecutionStatusVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("TxExecutionStatus_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(TxExecutionStatus.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TxExecutionStatus.self, from: encoded)
    }

    @Test("TxExecutionStatus variant 4 can be decoded and re-encoded")
    func txExecutionStatusVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("TxExecutionStatus_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(TxExecutionStatus.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TxExecutionStatus.self, from: encoded)
    }

    @Test("TxExecutionStatus variant 5 can be decoded and re-encoded")
    func txExecutionStatusVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("TxExecutionStatus_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(TxExecutionStatus.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(TxExecutionStatus.self, from: encoded)
    }

    @Test("UseGlobalContractAction can be decoded from mock and re-encoded")
    func useGlobalContractActionDecodingAndEncoding() throws {
        let data = try loadMockJSON("UseGlobalContractAction.json")

        // Test decoding
        let decoded = try decoder.decode(UseGlobalContractAction.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(UseGlobalContractAction.self, from: encoded)
    }

    @Test("VMConfigView can be decoded from mock and re-encoded")
    func vMConfigViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("VMConfigView.json")

        // Test decoding
        let decoded = try decoder.decode(VMConfigView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(VMConfigView.self, from: encoded)
    }

    @Test("VMKind variant 0 can be decoded and re-encoded")
    func vMKindVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("VMKind_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(VMKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(VMKind.self, from: encoded)
    }

    @Test("VMKind variant 1 can be decoded and re-encoded")
    func vMKindVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("VMKind_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(VMKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(VMKind.self, from: encoded)
    }

    @Test("VMKind variant 2 can be decoded and re-encoded")
    func vMKindVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("VMKind_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(VMKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(VMKind.self, from: encoded)
    }

    @Test("VMKind variant 3 can be decoded and re-encoded")
    func vMKindVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("VMKind_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(VMKind.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(VMKind.self, from: encoded)
    }

    @Test("ValidatorInfo can be decoded from mock and re-encoded")
    func validatorInfoDecodingAndEncoding() throws {
        let data = try loadMockJSON("ValidatorInfo.json")

        // Test decoding
        let decoded = try decoder.decode(ValidatorInfo.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ValidatorInfo.self, from: encoded)
    }

    @Test("ValidatorKickoutReason variant 0 can be decoded and re-encoded")
    func validatorKickoutReasonVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ValidatorKickoutReason.self, from: encoded)
    }

    @Test("ValidatorKickoutReason variant 1 can be decoded and re-encoded")
    func validatorKickoutReasonVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ValidatorKickoutReason.self, from: encoded)
    }

    @Test("ValidatorKickoutReason variant 2 can be decoded and re-encoded")
    func validatorKickoutReasonVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ValidatorKickoutReason.self, from: encoded)
    }

    @Test("ValidatorKickoutReason variant 3 can be decoded and re-encoded")
    func validatorKickoutReasonVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ValidatorKickoutReason.self, from: encoded)
    }

    @Test("ValidatorKickoutReason variant 4 can be decoded and re-encoded")
    func validatorKickoutReasonVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ValidatorKickoutReason.self, from: encoded)
    }

    @Test("ValidatorKickoutReason variant 5 can be decoded and re-encoded")
    func validatorKickoutReasonVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ValidatorKickoutReason.self, from: encoded)
    }

    @Test("ValidatorKickoutReason variant 6 can be decoded and re-encoded")
    func validatorKickoutReasonVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ValidatorKickoutReason.self, from: encoded)
    }

    @Test("ValidatorKickoutReason variant 7 can be decoded and re-encoded")
    func validatorKickoutReasonVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ValidatorKickoutReason.self, from: encoded)
    }

    @Test("ValidatorKickoutView can be decoded from mock and re-encoded")
    func validatorKickoutViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("ValidatorKickoutView.json")

        // Test decoding
        let decoded = try decoder.decode(ValidatorKickoutView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ValidatorKickoutView.self, from: encoded)
    }

    @Test("ValidatorStakeView variant 0 can be decoded and re-encoded")
    func validatorStakeViewVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("ValidatorStakeView_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(ValidatorStakeView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ValidatorStakeView.self, from: encoded)
    }

    @Test("ValidatorStakeViewV1 can be decoded from mock and re-encoded")
    func validatorStakeViewV1DecodingAndEncoding() throws {
        let data = try loadMockJSON("ValidatorStakeViewV1.json")

        // Test decoding
        let decoded = try decoder.decode(ValidatorStakeViewV1.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ValidatorStakeViewV1.self, from: encoded)
    }

    @Test("Version can be decoded from mock and re-encoded")
    func versionDecodingAndEncoding() throws {
        let data = try loadMockJSON("Version.json")

        // Test decoding
        let decoded = try decoder.decode(Version.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(Version.self, from: encoded)
    }

    @Test("ViewStateResult can be decoded from mock and re-encoded")
    func viewStateResultDecodingAndEncoding() throws {
        let data = try loadMockJSON("ViewStateResult.json")

        // Test decoding
        let decoded = try decoder.decode(ViewStateResult.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(ViewStateResult.self, from: encoded)
    }

    @Test("WasmTrap variant 0 can be decoded and re-encoded")
    func wasmTrapVariant0DecodingAndEncoding() throws {
        let data = try loadMockJSON("WasmTrap_Variant0.json")

        // Test decoding
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(WasmTrap.self, from: encoded)
    }

    @Test("WasmTrap variant 1 can be decoded and re-encoded")
    func wasmTrapVariant1DecodingAndEncoding() throws {
        let data = try loadMockJSON("WasmTrap_Variant1.json")

        // Test decoding
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(WasmTrap.self, from: encoded)
    }

    @Test("WasmTrap variant 2 can be decoded and re-encoded")
    func wasmTrapVariant2DecodingAndEncoding() throws {
        let data = try loadMockJSON("WasmTrap_Variant2.json")

        // Test decoding
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(WasmTrap.self, from: encoded)
    }

    @Test("WasmTrap variant 3 can be decoded and re-encoded")
    func wasmTrapVariant3DecodingAndEncoding() throws {
        let data = try loadMockJSON("WasmTrap_Variant3.json")

        // Test decoding
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(WasmTrap.self, from: encoded)
    }

    @Test("WasmTrap variant 4 can be decoded and re-encoded")
    func wasmTrapVariant4DecodingAndEncoding() throws {
        let data = try loadMockJSON("WasmTrap_Variant4.json")

        // Test decoding
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(WasmTrap.self, from: encoded)
    }

    @Test("WasmTrap variant 5 can be decoded and re-encoded")
    func wasmTrapVariant5DecodingAndEncoding() throws {
        let data = try loadMockJSON("WasmTrap_Variant5.json")

        // Test decoding
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(WasmTrap.self, from: encoded)
    }

    @Test("WasmTrap variant 6 can be decoded and re-encoded")
    func wasmTrapVariant6DecodingAndEncoding() throws {
        let data = try loadMockJSON("WasmTrap_Variant6.json")

        // Test decoding
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(WasmTrap.self, from: encoded)
    }

    @Test("WasmTrap variant 7 can be decoded and re-encoded")
    func wasmTrapVariant7DecodingAndEncoding() throws {
        let data = try loadMockJSON("WasmTrap_Variant7.json")

        // Test decoding
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(WasmTrap.self, from: encoded)
    }

    @Test("WasmTrap variant 8 can be decoded and re-encoded")
    func wasmTrapVariant8DecodingAndEncoding() throws {
        let data = try loadMockJSON("WasmTrap_Variant8.json")

        // Test decoding
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(WasmTrap.self, from: encoded)
    }

    @Test("WitnessConfigView can be decoded from mock and re-encoded")
    func witnessConfigViewDecodingAndEncoding() throws {
        let data = try loadMockJSON("WitnessConfigView.json")

        // Test decoding
        let decoded = try decoder.decode(WitnessConfigView.self, from: data)

        // Test encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Test round-trip
        _ = try decoder.decode(WitnessConfigView.self, from: encoded)
    }
}
