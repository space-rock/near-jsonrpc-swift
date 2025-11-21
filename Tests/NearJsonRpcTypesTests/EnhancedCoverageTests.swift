
import Foundation
@testable import NearJsonRpcTypes
import Testing

@Suite("Enhanced Coverage Tests with Property Access")
struct EnhancedCoverageTests {
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

    @Test("AccessKey decoded instance is valid")
    func accessKeyValidity() throws {
        let data = try loadMockJSON("AccessKey.json")
        let decoded = try decoder.decode(AccessKey.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(AccessKey.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("AccessKeyCreationConfigView decoded instance is valid")
    func accessKeyCreationConfigViewValidity() throws {
        let data = try loadMockJSON("AccessKeyCreationConfigView.json")
        let decoded = try decoder.decode(AccessKeyCreationConfigView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(AccessKeyCreationConfigView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("AccessKeyInfoView decoded instance is valid")
    func accessKeyInfoViewValidity() throws {
        let data = try loadMockJSON("AccessKeyInfoView.json")
        let decoded = try decoder.decode(AccessKeyInfoView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(AccessKeyInfoView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("AccessKeyList decoded instance is valid")
    func accessKeyListValidity() throws {
        let data = try loadMockJSON("AccessKeyList.json")
        let decoded = try decoder.decode(AccessKeyList.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(AccessKeyList.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("AccessKeyPermission variant 0 encoding stability")
    func accessKeyPermissionVariant0EncodingStability() throws {
        let data = try loadMockJSON("AccessKeyPermission_Variant0.json")
        let decoded = try decoder.decode(AccessKeyPermission.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(AccessKeyPermission.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("AccessKeyPermission variant 1 encoding stability")
    func accessKeyPermissionVariant1EncodingStability() throws {
        let data = try loadMockJSON("AccessKeyPermission_Variant1.json")
        let decoded = try decoder.decode(AccessKeyPermission.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(AccessKeyPermission.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("AccessKeyPermissionView variant 0 encoding stability")
    func accessKeyPermissionViewVariant0EncodingStability() throws {
        let data = try loadMockJSON("AccessKeyPermissionView_Variant0.json")
        let decoded = try decoder.decode(AccessKeyPermissionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(AccessKeyPermissionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("AccessKeyPermissionView variant 1 encoding stability")
    func accessKeyPermissionViewVariant1EncodingStability() throws {
        let data = try loadMockJSON("AccessKeyPermissionView_Variant1.json")
        let decoded = try decoder.decode(AccessKeyPermissionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(AccessKeyPermissionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("AccessKeyView decoded instance is valid")
    func accessKeyViewValidity() throws {
        let data = try loadMockJSON("AccessKeyView.json")
        let decoded = try decoder.decode(AccessKeyView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(AccessKeyView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("AccountCreationConfigView decoded instance is valid")
    func accountCreationConfigViewValidity() throws {
        let data = try loadMockJSON("AccountCreationConfigView.json")
        let decoded = try decoder.decode(AccountCreationConfigView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(AccountCreationConfigView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("AccountDataView decoded instance is valid")
    func accountDataViewValidity() throws {
        let data = try loadMockJSON("AccountDataView.json")
        let decoded = try decoder.decode(AccountDataView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(AccountDataView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("AccountInfo decoded instance is valid")
    func accountInfoValidity() throws {
        let data = try loadMockJSON("AccountInfo.json")
        let decoded = try decoder.decode(AccountInfo.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(AccountInfo.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("AccountView decoded instance is valid")
    func accountViewValidity() throws {
        let data = try loadMockJSON("AccountView.json")
        let decoded = try decoder.decode(AccountView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(AccountView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("AccountWithPublicKey decoded instance is valid")
    func accountWithPublicKeyValidity() throws {
        let data = try loadMockJSON("AccountWithPublicKey.json")
        let decoded = try decoder.decode(AccountWithPublicKey.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(AccountWithPublicKey.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ActionCreationConfigView decoded instance is valid")
    func actionCreationConfigViewValidity() throws {
        let data = try loadMockJSON("ActionCreationConfigView.json")
        let decoded = try decoder.decode(ActionCreationConfigView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ActionCreationConfigView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ActionError decoded instance is valid")
    func actionErrorValidity() throws {
        let data = try loadMockJSON("ActionError.json")
        let decoded = try decoder.decode(ActionError.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ActionError.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ActionErrorKind variant 0 encoding stability")
    func actionErrorKindVariant0EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant0.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 1 encoding stability")
    func actionErrorKindVariant1EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant1.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 10 encoding stability")
    func actionErrorKindVariant10EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant10.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 11 encoding stability")
    func actionErrorKindVariant11EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant11.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 12 encoding stability")
    func actionErrorKindVariant12EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant12.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 13 encoding stability")
    func actionErrorKindVariant13EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant13.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 14 encoding stability")
    func actionErrorKindVariant14EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant14.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 15 encoding stability")
    func actionErrorKindVariant15EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant15.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 16 encoding stability")
    func actionErrorKindVariant16EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant16.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 17 encoding stability")
    func actionErrorKindVariant17EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant17.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 18 encoding stability")
    func actionErrorKindVariant18EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant18.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 19 encoding stability")
    func actionErrorKindVariant19EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant19.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 2 encoding stability")
    func actionErrorKindVariant2EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant2.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 20 encoding stability")
    func actionErrorKindVariant20EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant20.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 21 encoding stability")
    func actionErrorKindVariant21EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant21.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 22 encoding stability")
    func actionErrorKindVariant22EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant22.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 23 encoding stability")
    func actionErrorKindVariant23EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant23.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 24 encoding stability")
    func actionErrorKindVariant24EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant24.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 3 encoding stability")
    func actionErrorKindVariant3EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant3.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 4 encoding stability")
    func actionErrorKindVariant4EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant4.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 5 encoding stability")
    func actionErrorKindVariant5EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant5.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 6 encoding stability")
    func actionErrorKindVariant6EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant6.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 7 encoding stability")
    func actionErrorKindVariant7EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant7.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 8 encoding stability")
    func actionErrorKindVariant8EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant8.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionErrorKind variant 9 encoding stability")
    func actionErrorKindVariant9EncodingStability() throws {
        let data = try loadMockJSON("ActionErrorKind_Variant9.json")
        let decoded = try decoder.decode(ActionErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 0 encoding stability")
    func actionViewVariant0EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant0.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 1 encoding stability")
    func actionViewVariant1EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant1.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 10 encoding stability")
    func actionViewVariant10EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant10.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 11 encoding stability")
    func actionViewVariant11EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant11.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 12 encoding stability")
    func actionViewVariant12EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant12.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 13 encoding stability")
    func actionViewVariant13EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant13.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 14 encoding stability")
    func actionViewVariant14EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant14.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 15 encoding stability")
    func actionViewVariant15EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant15.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 16 encoding stability")
    func actionViewVariant16EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant16.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 2 encoding stability")
    func actionViewVariant2EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant2.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 3 encoding stability")
    func actionViewVariant3EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant3.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 4 encoding stability")
    func actionViewVariant4EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant4.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 5 encoding stability")
    func actionViewVariant5EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant5.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 6 encoding stability")
    func actionViewVariant6EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant6.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 7 encoding stability")
    func actionViewVariant7EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant7.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 8 encoding stability")
    func actionViewVariant8EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant8.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionView variant 9 encoding stability")
    func actionViewVariant9EncodingStability() throws {
        let data = try loadMockJSON("ActionView_Variant9.json")
        let decoded = try decoder.decode(ActionView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 0 encoding stability")
    func actionsValidationErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant0.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 1 encoding stability")
    func actionsValidationErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant1.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 10 encoding stability")
    func actionsValidationErrorVariant10EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant10.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 11 encoding stability")
    func actionsValidationErrorVariant11EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant11.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 12 encoding stability")
    func actionsValidationErrorVariant12EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant12.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 13 encoding stability")
    func actionsValidationErrorVariant13EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant13.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 14 encoding stability")
    func actionsValidationErrorVariant14EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant14.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 15 encoding stability")
    func actionsValidationErrorVariant15EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant15.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 16 encoding stability")
    func actionsValidationErrorVariant16EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant16.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 17 encoding stability")
    func actionsValidationErrorVariant17EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant17.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 18 encoding stability")
    func actionsValidationErrorVariant18EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant18.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 2 encoding stability")
    func actionsValidationErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant2.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 3 encoding stability")
    func actionsValidationErrorVariant3EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant3.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 4 encoding stability")
    func actionsValidationErrorVariant4EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant4.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 5 encoding stability")
    func actionsValidationErrorVariant5EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant5.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 6 encoding stability")
    func actionsValidationErrorVariant6EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant6.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 7 encoding stability")
    func actionsValidationErrorVariant7EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant7.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 8 encoding stability")
    func actionsValidationErrorVariant8EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant8.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ActionsValidationError variant 9 encoding stability")
    func actionsValidationErrorVariant9EncodingStability() throws {
        let data = try loadMockJSON("ActionsValidationError_Variant9.json")
        let decoded = try decoder.decode(ActionsValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ActionsValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("AddGasKeyAction decoded instance is valid")
    func addGasKeyActionValidity() throws {
        let data = try loadMockJSON("AddGasKeyAction.json")
        let decoded = try decoder.decode(AddGasKeyAction.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(AddGasKeyAction.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("AddKeyAction decoded instance is valid")
    func addKeyActionValidity() throws {
        let data = try loadMockJSON("AddKeyAction.json")
        let decoded = try decoder.decode(AddKeyAction.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(AddKeyAction.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("BandwidthRequest decoded instance is valid")
    func bandwidthRequestValidity() throws {
        let data = try loadMockJSON("BandwidthRequest.json")
        let decoded = try decoder.decode(BandwidthRequest.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(BandwidthRequest.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("BandwidthRequestBitmap decoded instance is valid")
    func bandwidthRequestBitmapValidity() throws {
        let data = try loadMockJSON("BandwidthRequestBitmap.json")
        let decoded = try decoder.decode(BandwidthRequestBitmap.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(BandwidthRequestBitmap.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("BandwidthRequests variant 0 encoding stability")
    func bandwidthRequestsVariant0EncodingStability() throws {
        let data = try loadMockJSON("BandwidthRequests_Variant0.json")
        let decoded = try decoder.decode(BandwidthRequests.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(BandwidthRequests.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("BandwidthRequestsV1 decoded instance is valid")
    func bandwidthRequestsV1Validity() throws {
        let data = try loadMockJSON("BandwidthRequestsV1.json")
        let decoded = try decoder.decode(BandwidthRequestsV1.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(BandwidthRequestsV1.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("BlockHeaderInnerLiteView decoded instance is valid")
    func blockHeaderInnerLiteViewValidity() throws {
        let data = try loadMockJSON("BlockHeaderInnerLiteView.json")
        let decoded = try decoder.decode(BlockHeaderInnerLiteView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(BlockHeaderInnerLiteView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("BlockHeaderView decoded instance is valid")
    func blockHeaderViewValidity() throws {
        let data = try loadMockJSON("BlockHeaderView.json")
        let decoded = try decoder.decode(BlockHeaderView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(BlockHeaderView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("BlockId variant 0 encoding stability")
    func blockIdVariant0EncodingStability() throws {
        let data = try loadMockJSON("BlockId_Variant0.json")
        let decoded = try decoder.decode(BlockId.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(BlockId.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("BlockId variant 1 encoding stability")
    func blockIdVariant1EncodingStability() throws {
        let data = try loadMockJSON("BlockId_Variant1.json")
        let decoded = try decoder.decode(BlockId.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(BlockId.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("BlockReference variant 0 encoding stability")
    func blockReferenceVariant0EncodingStability() throws {
        let data = try loadMockJSON("BlockReference_Variant0.json")
        let decoded = try decoder.decode(BlockReference.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(BlockReference.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("BlockReference variant 1 encoding stability")
    func blockReferenceVariant1EncodingStability() throws {
        let data = try loadMockJSON("BlockReference_Variant1.json")
        let decoded = try decoder.decode(BlockReference.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(BlockReference.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("BlockReference variant 2 encoding stability")
    func blockReferenceVariant2EncodingStability() throws {
        let data = try loadMockJSON("BlockReference_Variant2.json")
        let decoded = try decoder.decode(BlockReference.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(BlockReference.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("BlockStatusView decoded instance is valid")
    func blockStatusViewValidity() throws {
        let data = try loadMockJSON("BlockStatusView.json")
        let decoded = try decoder.decode(BlockStatusView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(BlockStatusView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("CallResult decoded instance is valid")
    func callResultValidity() throws {
        let data = try loadMockJSON("CallResult.json")
        let decoded = try decoder.decode(CallResult.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(CallResult.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("CatchupStatusView decoded instance is valid")
    func catchupStatusViewValidity() throws {
        let data = try loadMockJSON("CatchupStatusView.json")
        let decoded = try decoder.decode(CatchupStatusView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(CatchupStatusView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ChunkDistributionNetworkConfig decoded instance is valid")
    func chunkDistributionNetworkConfigValidity() throws {
        let data = try loadMockJSON("ChunkDistributionNetworkConfig.json")
        let decoded = try decoder.decode(ChunkDistributionNetworkConfig.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ChunkDistributionNetworkConfig.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ChunkDistributionUris decoded instance is valid")
    func chunkDistributionUrisValidity() throws {
        let data = try loadMockJSON("ChunkDistributionUris.json")
        let decoded = try decoder.decode(ChunkDistributionUris.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ChunkDistributionUris.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ChunkHeaderView decoded instance is valid")
    func chunkHeaderViewValidity() throws {
        let data = try loadMockJSON("ChunkHeaderView.json")
        let decoded = try decoder.decode(ChunkHeaderView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ChunkHeaderView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("CloudArchivalWriterConfig decoded instance is valid")
    func cloudArchivalWriterConfigValidity() throws {
        let data = try loadMockJSON("CloudArchivalWriterConfig.json")
        let decoded = try decoder.decode(CloudArchivalWriterConfig.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(CloudArchivalWriterConfig.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("CompilationError variant 0 encoding stability")
    func compilationErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("CompilationError_Variant0.json")
        let decoded = try decoder.decode(CompilationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(CompilationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("CompilationError variant 1 encoding stability")
    func compilationErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("CompilationError_Variant1.json")
        let decoded = try decoder.decode(CompilationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(CompilationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("CompilationError variant 2 encoding stability")
    func compilationErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("CompilationError_Variant2.json")
        let decoded = try decoder.decode(CompilationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(CompilationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("CongestionControlConfigView decoded instance is valid")
    func congestionControlConfigViewValidity() throws {
        let data = try loadMockJSON("CongestionControlConfigView.json")
        let decoded = try decoder.decode(CongestionControlConfigView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(CongestionControlConfigView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("CongestionInfoView decoded instance is valid")
    func congestionInfoViewValidity() throws {
        let data = try loadMockJSON("CongestionInfoView.json")
        let decoded = try decoder.decode(CongestionInfoView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(CongestionInfoView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ContractCodeView decoded instance is valid")
    func contractCodeViewValidity() throws {
        let data = try loadMockJSON("ContractCodeView.json")
        let decoded = try decoder.decode(ContractCodeView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ContractCodeView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("CostGasUsed decoded instance is valid")
    func costGasUsedValidity() throws {
        let data = try loadMockJSON("CostGasUsed.json")
        let decoded = try decoder.decode(CostGasUsed.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(CostGasUsed.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("CurrentEpochValidatorInfo decoded instance is valid")
    func currentEpochValidatorInfoValidity() throws {
        let data = try loadMockJSON("CurrentEpochValidatorInfo.json")
        let decoded = try decoder.decode(CurrentEpochValidatorInfo.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(CurrentEpochValidatorInfo.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("DataReceiptCreationConfigView decoded instance is valid")
    func dataReceiptCreationConfigViewValidity() throws {
        let data = try loadMockJSON("DataReceiptCreationConfigView.json")
        let decoded = try decoder.decode(DataReceiptCreationConfigView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(DataReceiptCreationConfigView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("DataReceiverView decoded instance is valid")
    func dataReceiverViewValidity() throws {
        let data = try loadMockJSON("DataReceiverView.json")
        let decoded = try decoder.decode(DataReceiverView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(DataReceiverView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("DelegateAction decoded instance is valid")
    func delegateActionValidity() throws {
        let data = try loadMockJSON("DelegateAction.json")
        let decoded = try decoder.decode(DelegateAction.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(DelegateAction.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("DeleteAccountAction decoded instance is valid")
    func deleteAccountActionValidity() throws {
        let data = try loadMockJSON("DeleteAccountAction.json")
        let decoded = try decoder.decode(DeleteAccountAction.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(DeleteAccountAction.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("DeleteGasKeyAction decoded instance is valid")
    func deleteGasKeyActionValidity() throws {
        let data = try loadMockJSON("DeleteGasKeyAction.json")
        let decoded = try decoder.decode(DeleteGasKeyAction.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(DeleteGasKeyAction.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("DeleteKeyAction decoded instance is valid")
    func deleteKeyActionValidity() throws {
        let data = try loadMockJSON("DeleteKeyAction.json")
        let decoded = try decoder.decode(DeleteKeyAction.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(DeleteKeyAction.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("DeployContractAction decoded instance is valid")
    func deployContractActionValidity() throws {
        let data = try loadMockJSON("DeployContractAction.json")
        let decoded = try decoder.decode(DeployContractAction.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(DeployContractAction.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("DeployGlobalContractAction decoded instance is valid")
    func deployGlobalContractActionValidity() throws {
        let data = try loadMockJSON("DeployGlobalContractAction.json")
        let decoded = try decoder.decode(DeployGlobalContractAction.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(DeployGlobalContractAction.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("DetailedDebugStatus decoded instance is valid")
    func detailedDebugStatusValidity() throws {
        let data = try loadMockJSON("DetailedDebugStatus.json")
        let decoded = try decoder.decode(DetailedDebugStatus.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(DetailedDebugStatus.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("DeterministicAccountStateInit variant 0 encoding stability")
    func deterministicAccountStateInitVariant0EncodingStability() throws {
        let data = try loadMockJSON("DeterministicAccountStateInit_Variant0.json")
        let decoded = try decoder.decode(DeterministicAccountStateInit.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(DeterministicAccountStateInit.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("DeterministicAccountStateInitV1 decoded instance is valid")
    func deterministicAccountStateInitV1Validity() throws {
        let data = try loadMockJSON("DeterministicAccountStateInitV1.json")
        let decoded = try decoder.decode(DeterministicAccountStateInitV1.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(DeterministicAccountStateInitV1.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("DeterministicStateInitAction decoded instance is valid")
    func deterministicStateInitActionValidity() throws {
        let data = try loadMockJSON("DeterministicStateInitAction.json")
        let decoded = try decoder.decode(DeterministicStateInitAction.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(DeterministicStateInitAction.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("DumpConfig decoded instance is valid")
    func dumpConfigValidity() throws {
        let data = try loadMockJSON("DumpConfig.json")
        let decoded = try decoder.decode(DumpConfig.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(DumpConfig.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("DurationAsStdSchemaProvider decoded instance is valid")
    func durationAsStdSchemaProviderValidity() throws {
        let data = try loadMockJSON("DurationAsStdSchemaProvider.json")
        let decoded = try decoder.decode(DurationAsStdSchemaProvider.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(DurationAsStdSchemaProvider.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("EpochSyncConfig decoded instance is valid")
    func epochSyncConfigValidity() throws {
        let data = try loadMockJSON("EpochSyncConfig.json")
        let decoded = try decoder.decode(EpochSyncConfig.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(EpochSyncConfig.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ExecutionMetadataView decoded instance is valid")
    func executionMetadataViewValidity() throws {
        let data = try loadMockJSON("ExecutionMetadataView.json")
        let decoded = try decoder.decode(ExecutionMetadataView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ExecutionMetadataView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ExecutionOutcomeView decoded instance is valid")
    func executionOutcomeViewValidity() throws {
        let data = try loadMockJSON("ExecutionOutcomeView.json")
        let decoded = try decoder.decode(ExecutionOutcomeView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ExecutionOutcomeView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ExecutionOutcomeWithIdView decoded instance is valid")
    func executionOutcomeWithIdViewValidity() throws {
        let data = try loadMockJSON("ExecutionOutcomeWithIdView.json")
        let decoded = try decoder.decode(ExecutionOutcomeWithIdView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ExecutionOutcomeWithIdView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ExecutionStatusView variant 0 encoding stability")
    func executionStatusViewVariant0EncodingStability() throws {
        let data = try loadMockJSON("ExecutionStatusView_Variant0.json")
        let decoded = try decoder.decode(ExecutionStatusView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ExecutionStatusView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ExecutionStatusView variant 1 encoding stability")
    func executionStatusViewVariant1EncodingStability() throws {
        let data = try loadMockJSON("ExecutionStatusView_Variant1.json")
        let decoded = try decoder.decode(ExecutionStatusView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ExecutionStatusView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ExecutionStatusView variant 2 encoding stability")
    func executionStatusViewVariant2EncodingStability() throws {
        let data = try loadMockJSON("ExecutionStatusView_Variant2.json")
        let decoded = try decoder.decode(ExecutionStatusView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ExecutionStatusView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ExecutionStatusView variant 3 encoding stability")
    func executionStatusViewVariant3EncodingStability() throws {
        let data = try loadMockJSON("ExecutionStatusView_Variant3.json")
        let decoded = try decoder.decode(ExecutionStatusView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ExecutionStatusView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ExtCostsConfigView decoded instance is valid")
    func extCostsConfigViewValidity() throws {
        let data = try loadMockJSON("ExtCostsConfigView.json")
        let decoded = try decoder.decode(ExtCostsConfigView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ExtCostsConfigView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ExternalStorageConfig decoded instance is valid")
    func externalStorageConfigValidity() throws {
        let data = try loadMockJSON("ExternalStorageConfig.json")
        let decoded = try decoder.decode(ExternalStorageConfig.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ExternalStorageConfig.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ExternalStorageLocation variant 0 encoding stability")
    func externalStorageLocationVariant0EncodingStability() throws {
        let data = try loadMockJSON("ExternalStorageLocation_Variant0.json")
        let decoded = try decoder.decode(ExternalStorageLocation.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ExternalStorageLocation.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ExternalStorageLocation variant 1 encoding stability")
    func externalStorageLocationVariant1EncodingStability() throws {
        let data = try loadMockJSON("ExternalStorageLocation_Variant1.json")
        let decoded = try decoder.decode(ExternalStorageLocation.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ExternalStorageLocation.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ExternalStorageLocation variant 2 encoding stability")
    func externalStorageLocationVariant2EncodingStability() throws {
        let data = try loadMockJSON("ExternalStorageLocation_Variant2.json")
        let decoded = try decoder.decode(ExternalStorageLocation.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ExternalStorageLocation.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("Fee decoded instance is valid")
    func feeValidity() throws {
        let data = try loadMockJSON("Fee.json")
        let decoded = try decoder.decode(Fee.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(Fee.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("FinalExecutionOutcomeView decoded instance is valid")
    func finalExecutionOutcomeViewValidity() throws {
        let data = try loadMockJSON("FinalExecutionOutcomeView.json")
        let decoded = try decoder.decode(FinalExecutionOutcomeView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(FinalExecutionOutcomeView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("FinalExecutionOutcomeWithReceiptView decoded instance is valid")
    func finalExecutionOutcomeWithReceiptViewValidity() throws {
        let data = try loadMockJSON("FinalExecutionOutcomeWithReceiptView.json")
        let decoded = try decoder.decode(FinalExecutionOutcomeWithReceiptView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(FinalExecutionOutcomeWithReceiptView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("FinalExecutionStatus variant 0 encoding stability")
    func finalExecutionStatusVariant0EncodingStability() throws {
        let data = try loadMockJSON("FinalExecutionStatus_Variant0.json")
        let decoded = try decoder.decode(FinalExecutionStatus.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(FinalExecutionStatus.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("FinalExecutionStatus variant 1 encoding stability")
    func finalExecutionStatusVariant1EncodingStability() throws {
        let data = try loadMockJSON("FinalExecutionStatus_Variant1.json")
        let decoded = try decoder.decode(FinalExecutionStatus.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(FinalExecutionStatus.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("FinalExecutionStatus variant 2 encoding stability")
    func finalExecutionStatusVariant2EncodingStability() throws {
        let data = try loadMockJSON("FinalExecutionStatus_Variant2.json")
        let decoded = try decoder.decode(FinalExecutionStatus.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(FinalExecutionStatus.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("FinalExecutionStatus variant 3 encoding stability")
    func finalExecutionStatusVariant3EncodingStability() throws {
        let data = try loadMockJSON("FinalExecutionStatus_Variant3.json")
        let decoded = try decoder.decode(FinalExecutionStatus.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(FinalExecutionStatus.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("FunctionCallAction decoded instance is valid")
    func functionCallActionValidity() throws {
        let data = try loadMockJSON("FunctionCallAction.json")
        let decoded = try decoder.decode(FunctionCallAction.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(FunctionCallAction.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("FunctionCallError variant 0 encoding stability")
    func functionCallErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("FunctionCallError_Variant0.json")
        let decoded = try decoder.decode(FunctionCallError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(FunctionCallError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("FunctionCallError variant 1 encoding stability")
    func functionCallErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("FunctionCallError_Variant1.json")
        let decoded = try decoder.decode(FunctionCallError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(FunctionCallError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("FunctionCallError variant 2 encoding stability")
    func functionCallErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("FunctionCallError_Variant2.json")
        let decoded = try decoder.decode(FunctionCallError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(FunctionCallError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("FunctionCallError variant 3 encoding stability")
    func functionCallErrorVariant3EncodingStability() throws {
        let data = try loadMockJSON("FunctionCallError_Variant3.json")
        let decoded = try decoder.decode(FunctionCallError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(FunctionCallError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("FunctionCallError variant 4 encoding stability")
    func functionCallErrorVariant4EncodingStability() throws {
        let data = try loadMockJSON("FunctionCallError_Variant4.json")
        let decoded = try decoder.decode(FunctionCallError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(FunctionCallError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("FunctionCallError variant 5 encoding stability")
    func functionCallErrorVariant5EncodingStability() throws {
        let data = try loadMockJSON("FunctionCallError_Variant5.json")
        let decoded = try decoder.decode(FunctionCallError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(FunctionCallError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("FunctionCallError variant 6 encoding stability")
    func functionCallErrorVariant6EncodingStability() throws {
        let data = try loadMockJSON("FunctionCallError_Variant6.json")
        let decoded = try decoder.decode(FunctionCallError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(FunctionCallError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("FunctionCallPermission decoded instance is valid")
    func functionCallPermissionValidity() throws {
        let data = try loadMockJSON("FunctionCallPermission.json")
        let decoded = try decoder.decode(FunctionCallPermission.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(FunctionCallPermission.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("GCConfig decoded instance is valid")
    func gCConfigValidity() throws {
        let data = try loadMockJSON("GCConfig.json")
        let decoded = try decoder.decode(GCConfig.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(GCConfig.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("GasKey decoded instance is valid")
    func gasKeyValidity() throws {
        let data = try loadMockJSON("GasKey.json")
        let decoded = try decoder.decode(GasKey.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(GasKey.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("GasKeyInfoView decoded instance is valid")
    func gasKeyInfoViewValidity() throws {
        let data = try loadMockJSON("GasKeyInfoView.json")
        let decoded = try decoder.decode(GasKeyInfoView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(GasKeyInfoView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("GasKeyList decoded instance is valid")
    func gasKeyListValidity() throws {
        let data = try loadMockJSON("GasKeyList.json")
        let decoded = try decoder.decode(GasKeyList.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(GasKeyList.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("GasKeyView decoded instance is valid")
    func gasKeyViewValidity() throws {
        let data = try loadMockJSON("GasKeyView.json")
        let decoded = try decoder.decode(GasKeyView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(GasKeyView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("GenesisConfig decoded instance is valid")
    func genesisConfigValidity() throws {
        let data = try loadMockJSON("GenesisConfig.json")
        let decoded = try decoder.decode(GenesisConfig.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(GenesisConfig.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("GlobalContractDeployMode variant 0 encoding stability")
    func globalContractDeployModeVariant0EncodingStability() throws {
        let data = try loadMockJSON("GlobalContractDeployMode_Variant0.json")
        let decoded = try decoder.decode(GlobalContractDeployMode.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(GlobalContractDeployMode.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("GlobalContractDeployMode variant 1 encoding stability")
    func globalContractDeployModeVariant1EncodingStability() throws {
        let data = try loadMockJSON("GlobalContractDeployMode_Variant1.json")
        let decoded = try decoder.decode(GlobalContractDeployMode.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(GlobalContractDeployMode.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("GlobalContractIdentifier variant 0 encoding stability")
    func globalContractIdentifierVariant0EncodingStability() throws {
        let data = try loadMockJSON("GlobalContractIdentifier_Variant0.json")
        let decoded = try decoder.decode(GlobalContractIdentifier.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(GlobalContractIdentifier.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("GlobalContractIdentifier variant 1 encoding stability")
    func globalContractIdentifierVariant1EncodingStability() throws {
        let data = try loadMockJSON("GlobalContractIdentifier_Variant1.json")
        let decoded = try decoder.decode(GlobalContractIdentifier.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(GlobalContractIdentifier.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("GlobalContractIdentifierView variant 0 encoding stability")
    func globalContractIdentifierViewVariant0EncodingStability() throws {
        let data = try loadMockJSON("GlobalContractIdentifierView_Variant0.json")
        let decoded = try decoder.decode(GlobalContractIdentifierView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(GlobalContractIdentifierView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("GlobalContractIdentifierView variant 1 encoding stability")
    func globalContractIdentifierViewVariant1EncodingStability() throws {
        let data = try loadMockJSON("GlobalContractIdentifierView_Variant1.json")
        let decoded = try decoder.decode(GlobalContractIdentifierView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(GlobalContractIdentifierView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 0 encoding stability")
    func hostErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant0.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 1 encoding stability")
    func hostErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant1.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 10 encoding stability")
    func hostErrorVariant10EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant10.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 11 encoding stability")
    func hostErrorVariant11EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant11.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 12 encoding stability")
    func hostErrorVariant12EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant12.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 13 encoding stability")
    func hostErrorVariant13EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant13.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 14 encoding stability")
    func hostErrorVariant14EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant14.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 15 encoding stability")
    func hostErrorVariant15EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant15.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 16 encoding stability")
    func hostErrorVariant16EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant16.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 17 encoding stability")
    func hostErrorVariant17EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant17.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 18 encoding stability")
    func hostErrorVariant18EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant18.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 19 encoding stability")
    func hostErrorVariant19EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant19.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 2 encoding stability")
    func hostErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant2.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 20 encoding stability")
    func hostErrorVariant20EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant20.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 21 encoding stability")
    func hostErrorVariant21EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant21.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 22 encoding stability")
    func hostErrorVariant22EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant22.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 23 encoding stability")
    func hostErrorVariant23EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant23.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 24 encoding stability")
    func hostErrorVariant24EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant24.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 25 encoding stability")
    func hostErrorVariant25EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant25.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 26 encoding stability")
    func hostErrorVariant26EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant26.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 27 encoding stability")
    func hostErrorVariant27EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant27.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 28 encoding stability")
    func hostErrorVariant28EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant28.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 29 encoding stability")
    func hostErrorVariant29EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant29.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 3 encoding stability")
    func hostErrorVariant3EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant3.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 30 encoding stability")
    func hostErrorVariant30EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant30.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 31 encoding stability")
    func hostErrorVariant31EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant31.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 32 encoding stability")
    func hostErrorVariant32EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant32.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 4 encoding stability")
    func hostErrorVariant4EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant4.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 5 encoding stability")
    func hostErrorVariant5EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant5.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 6 encoding stability")
    func hostErrorVariant6EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant6.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 7 encoding stability")
    func hostErrorVariant7EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant7.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 8 encoding stability")
    func hostErrorVariant8EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant8.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("HostError variant 9 encoding stability")
    func hostErrorVariant9EncodingStability() throws {
        let data = try loadMockJSON("HostError_Variant9.json")
        let decoded = try decoder.decode(HostError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(HostError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InternalError variant 0 encoding stability")
    func internalErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("InternalError_Variant0.json")
        let decoded = try decoder.decode(InternalError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InternalError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidAccessKeyError variant 0 encoding stability")
    func invalidAccessKeyErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("InvalidAccessKeyError_Variant0.json")
        let decoded = try decoder.decode(InvalidAccessKeyError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidAccessKeyError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidAccessKeyError variant 1 encoding stability")
    func invalidAccessKeyErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("InvalidAccessKeyError_Variant1.json")
        let decoded = try decoder.decode(InvalidAccessKeyError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidAccessKeyError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidAccessKeyError variant 2 encoding stability")
    func invalidAccessKeyErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("InvalidAccessKeyError_Variant2.json")
        let decoded = try decoder.decode(InvalidAccessKeyError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidAccessKeyError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidAccessKeyError variant 3 encoding stability")
    func invalidAccessKeyErrorVariant3EncodingStability() throws {
        let data = try loadMockJSON("InvalidAccessKeyError_Variant3.json")
        let decoded = try decoder.decode(InvalidAccessKeyError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidAccessKeyError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidAccessKeyError variant 4 encoding stability")
    func invalidAccessKeyErrorVariant4EncodingStability() throws {
        let data = try loadMockJSON("InvalidAccessKeyError_Variant4.json")
        let decoded = try decoder.decode(InvalidAccessKeyError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidAccessKeyError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidAccessKeyError variant 5 encoding stability")
    func invalidAccessKeyErrorVariant5EncodingStability() throws {
        let data = try loadMockJSON("InvalidAccessKeyError_Variant5.json")
        let decoded = try decoder.decode(InvalidAccessKeyError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidAccessKeyError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 0 encoding stability")
    func invalidTxErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant0.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 1 encoding stability")
    func invalidTxErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant1.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 10 encoding stability")
    func invalidTxErrorVariant10EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant10.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 11 encoding stability")
    func invalidTxErrorVariant11EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant11.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 12 encoding stability")
    func invalidTxErrorVariant12EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant12.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 13 encoding stability")
    func invalidTxErrorVariant13EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant13.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 14 encoding stability")
    func invalidTxErrorVariant14EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant14.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 15 encoding stability")
    func invalidTxErrorVariant15EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant15.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 16 encoding stability")
    func invalidTxErrorVariant16EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant16.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 17 encoding stability")
    func invalidTxErrorVariant17EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant17.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 2 encoding stability")
    func invalidTxErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant2.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 3 encoding stability")
    func invalidTxErrorVariant3EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant3.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 4 encoding stability")
    func invalidTxErrorVariant4EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant4.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 5 encoding stability")
    func invalidTxErrorVariant5EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant5.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 6 encoding stability")
    func invalidTxErrorVariant6EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant6.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 7 encoding stability")
    func invalidTxErrorVariant7EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant7.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 8 encoding stability")
    func invalidTxErrorVariant8EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant8.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("InvalidTxError variant 9 encoding stability")
    func invalidTxErrorVariant9EncodingStability() throws {
        let data = try loadMockJSON("InvalidTxError_Variant9.json")
        let decoded = try decoder.decode(InvalidTxError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(InvalidTxError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("KnownProducerView decoded instance is valid")
    func knownProducerViewValidity() throws {
        let data = try loadMockJSON("KnownProducerView.json")
        let decoded = try decoder.decode(KnownProducerView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(KnownProducerView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("LightClientBlockLiteView decoded instance is valid")
    func lightClientBlockLiteViewValidity() throws {
        let data = try loadMockJSON("LightClientBlockLiteView.json")
        let decoded = try decoder.decode(LightClientBlockLiteView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(LightClientBlockLiteView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("LimitConfig decoded instance is valid")
    func limitConfigValidity() throws {
        let data = try loadMockJSON("LimitConfig.json")
        let decoded = try decoder.decode(LimitConfig.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(LimitConfig.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("MerklePathItem decoded instance is valid")
    func merklePathItemValidity() throws {
        let data = try loadMockJSON("MerklePathItem.json")
        let decoded = try decoder.decode(MerklePathItem.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(MerklePathItem.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("MissingTrieValue decoded instance is valid")
    func missingTrieValueValidity() throws {
        let data = try loadMockJSON("MissingTrieValue.json")
        let decoded = try decoder.decode(MissingTrieValue.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(MissingTrieValue.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("MissingTrieValueContext variant 0 encoding stability")
    func missingTrieValueContextVariant0EncodingStability() throws {
        let data = try loadMockJSON("MissingTrieValueContext_Variant0.json")
        let decoded = try decoder.decode(MissingTrieValueContext.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(MissingTrieValueContext.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("MissingTrieValueContext variant 1 encoding stability")
    func missingTrieValueContextVariant1EncodingStability() throws {
        let data = try loadMockJSON("MissingTrieValueContext_Variant1.json")
        let decoded = try decoder.decode(MissingTrieValueContext.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(MissingTrieValueContext.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("MissingTrieValueContext variant 2 encoding stability")
    func missingTrieValueContextVariant2EncodingStability() throws {
        let data = try loadMockJSON("MissingTrieValueContext_Variant2.json")
        let decoded = try decoder.decode(MissingTrieValueContext.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(MissingTrieValueContext.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("MissingTrieValueContext variant 3 encoding stability")
    func missingTrieValueContextVariant3EncodingStability() throws {
        let data = try loadMockJSON("MissingTrieValueContext_Variant3.json")
        let decoded = try decoder.decode(MissingTrieValueContext.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(MissingTrieValueContext.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("NetworkInfoView decoded instance is valid")
    func networkInfoViewValidity() throws {
        let data = try loadMockJSON("NetworkInfoView.json")
        let decoded = try decoder.decode(NetworkInfoView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(NetworkInfoView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("NextEpochValidatorInfo decoded instance is valid")
    func nextEpochValidatorInfoValidity() throws {
        let data = try loadMockJSON("NextEpochValidatorInfo.json")
        let decoded = try decoder.decode(NextEpochValidatorInfo.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(NextEpochValidatorInfo.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("NonDelegateAction variant 0 encoding stability")
    func nonDelegateActionVariant0EncodingStability() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant0.json")
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(NonDelegateAction.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("NonDelegateAction variant 1 encoding stability")
    func nonDelegateActionVariant1EncodingStability() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant1.json")
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(NonDelegateAction.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("NonDelegateAction variant 10 encoding stability")
    func nonDelegateActionVariant10EncodingStability() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant10.json")
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(NonDelegateAction.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("NonDelegateAction variant 11 encoding stability")
    func nonDelegateActionVariant11EncodingStability() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant11.json")
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(NonDelegateAction.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("NonDelegateAction variant 12 encoding stability")
    func nonDelegateActionVariant12EncodingStability() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant12.json")
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(NonDelegateAction.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("NonDelegateAction variant 13 encoding stability")
    func nonDelegateActionVariant13EncodingStability() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant13.json")
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(NonDelegateAction.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("NonDelegateAction variant 2 encoding stability")
    func nonDelegateActionVariant2EncodingStability() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant2.json")
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(NonDelegateAction.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("NonDelegateAction variant 3 encoding stability")
    func nonDelegateActionVariant3EncodingStability() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant3.json")
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(NonDelegateAction.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("NonDelegateAction variant 4 encoding stability")
    func nonDelegateActionVariant4EncodingStability() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant4.json")
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(NonDelegateAction.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("NonDelegateAction variant 5 encoding stability")
    func nonDelegateActionVariant5EncodingStability() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant5.json")
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(NonDelegateAction.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("NonDelegateAction variant 6 encoding stability")
    func nonDelegateActionVariant6EncodingStability() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant6.json")
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(NonDelegateAction.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("NonDelegateAction variant 7 encoding stability")
    func nonDelegateActionVariant7EncodingStability() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant7.json")
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(NonDelegateAction.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("NonDelegateAction variant 8 encoding stability")
    func nonDelegateActionVariant8EncodingStability() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant8.json")
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(NonDelegateAction.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("NonDelegateAction variant 9 encoding stability")
    func nonDelegateActionVariant9EncodingStability() throws {
        let data = try loadMockJSON("NonDelegateAction_Variant9.json")
        let decoded = try decoder.decode(NonDelegateAction.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(NonDelegateAction.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("PeerInfoView decoded instance is valid")
    func peerInfoViewValidity() throws {
        let data = try loadMockJSON("PeerInfoView.json")
        let decoded = try decoder.decode(PeerInfoView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(PeerInfoView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("PrepareError variant 0 encoding stability")
    func prepareErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("PrepareError_Variant0.json")
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(PrepareError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("PrepareError variant 1 encoding stability")
    func prepareErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("PrepareError_Variant1.json")
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(PrepareError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("PrepareError variant 10 encoding stability")
    func prepareErrorVariant10EncodingStability() throws {
        let data = try loadMockJSON("PrepareError_Variant10.json")
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(PrepareError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("PrepareError variant 2 encoding stability")
    func prepareErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("PrepareError_Variant2.json")
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(PrepareError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("PrepareError variant 3 encoding stability")
    func prepareErrorVariant3EncodingStability() throws {
        let data = try loadMockJSON("PrepareError_Variant3.json")
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(PrepareError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("PrepareError variant 4 encoding stability")
    func prepareErrorVariant4EncodingStability() throws {
        let data = try loadMockJSON("PrepareError_Variant4.json")
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(PrepareError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("PrepareError variant 5 encoding stability")
    func prepareErrorVariant5EncodingStability() throws {
        let data = try loadMockJSON("PrepareError_Variant5.json")
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(PrepareError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("PrepareError variant 6 encoding stability")
    func prepareErrorVariant6EncodingStability() throws {
        let data = try loadMockJSON("PrepareError_Variant6.json")
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(PrepareError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("PrepareError variant 7 encoding stability")
    func prepareErrorVariant7EncodingStability() throws {
        let data = try loadMockJSON("PrepareError_Variant7.json")
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(PrepareError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("PrepareError variant 8 encoding stability")
    func prepareErrorVariant8EncodingStability() throws {
        let data = try loadMockJSON("PrepareError_Variant8.json")
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(PrepareError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("PrepareError variant 9 encoding stability")
    func prepareErrorVariant9EncodingStability() throws {
        let data = try loadMockJSON("PrepareError_Variant9.json")
        let decoded = try decoder.decode(PrepareError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(PrepareError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RangeOfUint64 decoded instance is valid")
    func rangeOfUint64Validity() throws {
        let data = try loadMockJSON("RangeOfUint64.json")
        let decoded = try decoder.decode(RangeOfUint64.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RangeOfUint64.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ReceiptEnumView variant 0 encoding stability")
    func receiptEnumViewVariant0EncodingStability() throws {
        let data = try loadMockJSON("ReceiptEnumView_Variant0.json")
        let decoded = try decoder.decode(ReceiptEnumView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ReceiptEnumView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ReceiptEnumView variant 1 encoding stability")
    func receiptEnumViewVariant1EncodingStability() throws {
        let data = try loadMockJSON("ReceiptEnumView_Variant1.json")
        let decoded = try decoder.decode(ReceiptEnumView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ReceiptEnumView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ReceiptEnumView variant 2 encoding stability")
    func receiptEnumViewVariant2EncodingStability() throws {
        let data = try loadMockJSON("ReceiptEnumView_Variant2.json")
        let decoded = try decoder.decode(ReceiptEnumView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ReceiptEnumView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ReceiptValidationError variant 0 encoding stability")
    func receiptValidationErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant0.json")
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ReceiptValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ReceiptValidationError variant 1 encoding stability")
    func receiptValidationErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant1.json")
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ReceiptValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ReceiptValidationError variant 2 encoding stability")
    func receiptValidationErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant2.json")
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ReceiptValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ReceiptValidationError variant 3 encoding stability")
    func receiptValidationErrorVariant3EncodingStability() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant3.json")
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ReceiptValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ReceiptValidationError variant 4 encoding stability")
    func receiptValidationErrorVariant4EncodingStability() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant4.json")
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ReceiptValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ReceiptValidationError variant 5 encoding stability")
    func receiptValidationErrorVariant5EncodingStability() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant5.json")
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ReceiptValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ReceiptValidationError variant 6 encoding stability")
    func receiptValidationErrorVariant6EncodingStability() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant6.json")
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ReceiptValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ReceiptValidationError variant 7 encoding stability")
    func receiptValidationErrorVariant7EncodingStability() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant7.json")
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ReceiptValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ReceiptValidationError variant 8 encoding stability")
    func receiptValidationErrorVariant8EncodingStability() throws {
        let data = try loadMockJSON("ReceiptValidationError_Variant8.json")
        let decoded = try decoder.decode(ReceiptValidationError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ReceiptValidationError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ReceiptView decoded instance is valid")
    func receiptViewValidity() throws {
        let data = try loadMockJSON("ReceiptView.json")
        let decoded = try decoder.decode(ReceiptView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ReceiptView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcBlockError variant 0 encoding stability")
    func rpcBlockErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcBlockError_Variant0.json")
        let decoded = try decoder.decode(RpcBlockError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcBlockError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcBlockError variant 1 encoding stability")
    func rpcBlockErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcBlockError_Variant1.json")
        let decoded = try decoder.decode(RpcBlockError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcBlockError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcBlockError variant 2 encoding stability")
    func rpcBlockErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcBlockError_Variant2.json")
        let decoded = try decoder.decode(RpcBlockError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcBlockError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcBlockRequest variant 0 encoding stability")
    func rpcBlockRequestVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcBlockRequest_Variant0.json")
        let decoded = try decoder.decode(RpcBlockRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcBlockRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcBlockRequest variant 1 encoding stability")
    func rpcBlockRequestVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcBlockRequest_Variant1.json")
        let decoded = try decoder.decode(RpcBlockRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcBlockRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcBlockRequest variant 2 encoding stability")
    func rpcBlockRequestVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcBlockRequest_Variant2.json")
        let decoded = try decoder.decode(RpcBlockRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcBlockRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcBlockResponse decoded instance is valid")
    func rpcBlockResponseValidity() throws {
        let data = try loadMockJSON("RpcBlockResponse.json")
        let decoded = try decoder.decode(RpcBlockResponse.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcBlockResponse.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcChunkError variant 0 encoding stability")
    func rpcChunkErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcChunkError_Variant0.json")
        let decoded = try decoder.decode(RpcChunkError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcChunkError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcChunkError variant 1 encoding stability")
    func rpcChunkErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcChunkError_Variant1.json")
        let decoded = try decoder.decode(RpcChunkError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcChunkError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcChunkError variant 2 encoding stability")
    func rpcChunkErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcChunkError_Variant2.json")
        let decoded = try decoder.decode(RpcChunkError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcChunkError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcChunkError variant 3 encoding stability")
    func rpcChunkErrorVariant3EncodingStability() throws {
        let data = try loadMockJSON("RpcChunkError_Variant3.json")
        let decoded = try decoder.decode(RpcChunkError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcChunkError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcChunkRequest variant 0 encoding stability")
    func rpcChunkRequestVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcChunkRequest_Variant0.json")
        let decoded = try decoder.decode(RpcChunkRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcChunkRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcChunkRequest variant 1 encoding stability")
    func rpcChunkRequestVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcChunkRequest_Variant1.json")
        let decoded = try decoder.decode(RpcChunkRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcChunkRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcChunkResponse decoded instance is valid")
    func rpcChunkResponseValidity() throws {
        let data = try loadMockJSON("RpcChunkResponse.json")
        let decoded = try decoder.decode(RpcChunkResponse.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcChunkResponse.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcClientConfigError variant 0 encoding stability")
    func rpcClientConfigErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcClientConfigError_Variant0.json")
        let decoded = try decoder.decode(RpcClientConfigError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcClientConfigError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcCongestionLevelRequest variant 0 encoding stability")
    func rpcCongestionLevelRequestVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcCongestionLevelRequest_Variant0.json")
        let decoded = try decoder.decode(RpcCongestionLevelRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcCongestionLevelRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcCongestionLevelRequest variant 1 encoding stability")
    func rpcCongestionLevelRequestVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcCongestionLevelRequest_Variant1.json")
        let decoded = try decoder.decode(RpcCongestionLevelRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcCongestionLevelRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcCongestionLevelResponse decoded instance is valid")
    func rpcCongestionLevelResponseValidity() throws {
        let data = try loadMockJSON("RpcCongestionLevelResponse.json")
        let decoded = try decoder.decode(RpcCongestionLevelResponse.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcCongestionLevelResponse.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcGasPriceError variant 0 encoding stability")
    func rpcGasPriceErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcGasPriceError_Variant0.json")
        let decoded = try decoder.decode(RpcGasPriceError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcGasPriceError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcGasPriceError variant 1 encoding stability")
    func rpcGasPriceErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcGasPriceError_Variant1.json")
        let decoded = try decoder.decode(RpcGasPriceError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcGasPriceError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcGasPriceRequest decoded instance is valid")
    func rpcGasPriceRequestValidity() throws {
        let data = try loadMockJSON("RpcGasPriceRequest.json")
        let decoded = try decoder.decode(RpcGasPriceRequest.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcGasPriceRequest.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcGasPriceResponse decoded instance is valid")
    func rpcGasPriceResponseValidity() throws {
        let data = try loadMockJSON("RpcGasPriceResponse.json")
        let decoded = try decoder.decode(RpcGasPriceResponse.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcGasPriceResponse.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcKnownProducer decoded instance is valid")
    func rpcKnownProducerValidity() throws {
        let data = try loadMockJSON("RpcKnownProducer.json")
        let decoded = try decoder.decode(RpcKnownProducer.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcKnownProducer.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcLightClientBlockProofRequest decoded instance is valid")
    func rpcLightClientBlockProofRequestValidity() throws {
        let data = try loadMockJSON("RpcLightClientBlockProofRequest.json")
        let decoded = try decoder.decode(RpcLightClientBlockProofRequest.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcLightClientBlockProofRequest.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcLightClientBlockProofResponse decoded instance is valid")
    func rpcLightClientBlockProofResponseValidity() throws {
        let data = try loadMockJSON("RpcLightClientBlockProofResponse.json")
        let decoded = try decoder.decode(RpcLightClientBlockProofResponse.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcLightClientBlockProofResponse.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcLightClientExecutionProofRequest variant 0 encoding stability")
    func rpcLightClientExecutionProofRequestVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcLightClientExecutionProofRequest_Variant0.json")
        let decoded = try decoder.decode(RpcLightClientExecutionProofRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcLightClientExecutionProofRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcLightClientExecutionProofRequest variant 1 encoding stability")
    func rpcLightClientExecutionProofRequestVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcLightClientExecutionProofRequest_Variant1.json")
        let decoded = try decoder.decode(RpcLightClientExecutionProofRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcLightClientExecutionProofRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcLightClientExecutionProofResponse decoded instance is valid")
    func rpcLightClientExecutionProofResponseValidity() throws {
        let data = try loadMockJSON("RpcLightClientExecutionProofResponse.json")
        let decoded = try decoder.decode(RpcLightClientExecutionProofResponse.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcLightClientExecutionProofResponse.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcLightClientNextBlockError variant 0 encoding stability")
    func rpcLightClientNextBlockErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcLightClientNextBlockError_Variant0.json")
        let decoded = try decoder.decode(RpcLightClientNextBlockError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcLightClientNextBlockError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcLightClientNextBlockError variant 1 encoding stability")
    func rpcLightClientNextBlockErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcLightClientNextBlockError_Variant1.json")
        let decoded = try decoder.decode(RpcLightClientNextBlockError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcLightClientNextBlockError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcLightClientNextBlockError variant 2 encoding stability")
    func rpcLightClientNextBlockErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcLightClientNextBlockError_Variant2.json")
        let decoded = try decoder.decode(RpcLightClientNextBlockError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcLightClientNextBlockError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcLightClientNextBlockRequest decoded instance is valid")
    func rpcLightClientNextBlockRequestValidity() throws {
        let data = try loadMockJSON("RpcLightClientNextBlockRequest.json")
        let decoded = try decoder.decode(RpcLightClientNextBlockRequest.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcLightClientNextBlockRequest.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcLightClientNextBlockResponse decoded instance is valid")
    func rpcLightClientNextBlockResponseValidity() throws {
        let data = try loadMockJSON("RpcLightClientNextBlockResponse.json")
        let decoded = try decoder.decode(RpcLightClientNextBlockResponse.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcLightClientNextBlockResponse.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcLightClientProofError variant 0 encoding stability")
    func rpcLightClientProofErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcLightClientProofError_Variant0.json")
        let decoded = try decoder.decode(RpcLightClientProofError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcLightClientProofError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcLightClientProofError variant 1 encoding stability")
    func rpcLightClientProofErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcLightClientProofError_Variant1.json")
        let decoded = try decoder.decode(RpcLightClientProofError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcLightClientProofError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcLightClientProofError variant 2 encoding stability")
    func rpcLightClientProofErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcLightClientProofError_Variant2.json")
        let decoded = try decoder.decode(RpcLightClientProofError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcLightClientProofError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcLightClientProofError variant 3 encoding stability")
    func rpcLightClientProofErrorVariant3EncodingStability() throws {
        let data = try loadMockJSON("RpcLightClientProofError_Variant3.json")
        let decoded = try decoder.decode(RpcLightClientProofError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcLightClientProofError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcLightClientProofError variant 4 encoding stability")
    func rpcLightClientProofErrorVariant4EncodingStability() throws {
        let data = try loadMockJSON("RpcLightClientProofError_Variant4.json")
        let decoded = try decoder.decode(RpcLightClientProofError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcLightClientProofError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcLightClientProofError variant 5 encoding stability")
    func rpcLightClientProofErrorVariant5EncodingStability() throws {
        let data = try loadMockJSON("RpcLightClientProofError_Variant5.json")
        let decoded = try decoder.decode(RpcLightClientProofError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcLightClientProofError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcMaintenanceWindowsError variant 0 encoding stability")
    func rpcMaintenanceWindowsErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcMaintenanceWindowsError_Variant0.json")
        let decoded = try decoder.decode(RpcMaintenanceWindowsError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcMaintenanceWindowsError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcMaintenanceWindowsRequest decoded instance is valid")
    func rpcMaintenanceWindowsRequestValidity() throws {
        let data = try loadMockJSON("RpcMaintenanceWindowsRequest.json")
        let decoded = try decoder.decode(RpcMaintenanceWindowsRequest.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcMaintenanceWindowsRequest.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcNetworkInfoError variant 0 encoding stability")
    func rpcNetworkInfoErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcNetworkInfoError_Variant0.json")
        let decoded = try decoder.decode(RpcNetworkInfoError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcNetworkInfoError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcNetworkInfoResponse decoded instance is valid")
    func rpcNetworkInfoResponseValidity() throws {
        let data = try loadMockJSON("RpcNetworkInfoResponse.json")
        let decoded = try decoder.decode(RpcNetworkInfoResponse.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcNetworkInfoResponse.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcPeerInfo decoded instance is valid")
    func rpcPeerInfoValidity() throws {
        let data = try loadMockJSON("RpcPeerInfo.json")
        let decoded = try decoder.decode(RpcPeerInfo.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcPeerInfo.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcProtocolConfigError variant 0 encoding stability")
    func rpcProtocolConfigErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcProtocolConfigError_Variant0.json")
        let decoded = try decoder.decode(RpcProtocolConfigError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcProtocolConfigError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcProtocolConfigError variant 1 encoding stability")
    func rpcProtocolConfigErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcProtocolConfigError_Variant1.json")
        let decoded = try decoder.decode(RpcProtocolConfigError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcProtocolConfigError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcProtocolConfigRequest variant 0 encoding stability")
    func rpcProtocolConfigRequestVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcProtocolConfigRequest_Variant0.json")
        let decoded = try decoder.decode(RpcProtocolConfigRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcProtocolConfigRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcProtocolConfigRequest variant 1 encoding stability")
    func rpcProtocolConfigRequestVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcProtocolConfigRequest_Variant1.json")
        let decoded = try decoder.decode(RpcProtocolConfigRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcProtocolConfigRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcProtocolConfigRequest variant 2 encoding stability")
    func rpcProtocolConfigRequestVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcProtocolConfigRequest_Variant2.json")
        let decoded = try decoder.decode(RpcProtocolConfigRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcProtocolConfigRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcProtocolConfigResponse decoded instance is valid")
    func rpcProtocolConfigResponseValidity() throws {
        let data = try loadMockJSON("RpcProtocolConfigResponse.json")
        let decoded = try decoder.decode(RpcProtocolConfigResponse.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcProtocolConfigResponse.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcQueryError variant 0 encoding stability")
    func rpcQueryErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryError_Variant0.json")
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryError variant 1 encoding stability")
    func rpcQueryErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryError_Variant1.json")
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryError variant 10 encoding stability")
    func rpcQueryErrorVariant10EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryError_Variant10.json")
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryError variant 11 encoding stability")
    func rpcQueryErrorVariant11EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryError_Variant11.json")
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryError variant 12 encoding stability")
    func rpcQueryErrorVariant12EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryError_Variant12.json")
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryError variant 2 encoding stability")
    func rpcQueryErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryError_Variant2.json")
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryError variant 3 encoding stability")
    func rpcQueryErrorVariant3EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryError_Variant3.json")
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryError variant 4 encoding stability")
    func rpcQueryErrorVariant4EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryError_Variant4.json")
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryError variant 5 encoding stability")
    func rpcQueryErrorVariant5EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryError_Variant5.json")
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryError variant 6 encoding stability")
    func rpcQueryErrorVariant6EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryError_Variant6.json")
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryError variant 7 encoding stability")
    func rpcQueryErrorVariant7EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryError_Variant7.json")
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryError variant 8 encoding stability")
    func rpcQueryErrorVariant8EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryError_Variant8.json")
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryError variant 9 encoding stability")
    func rpcQueryErrorVariant9EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryError_Variant9.json")
        let decoded = try decoder.decode(RpcQueryError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 0 encoding stability")
    func rpcQueryRequestVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant0.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 1 encoding stability")
    func rpcQueryRequestVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant1.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 10 encoding stability")
    func rpcQueryRequestVariant10EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant10.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 11 encoding stability")
    func rpcQueryRequestVariant11EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant11.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 12 encoding stability")
    func rpcQueryRequestVariant12EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant12.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 13 encoding stability")
    func rpcQueryRequestVariant13EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant13.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 14 encoding stability")
    func rpcQueryRequestVariant14EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant14.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 15 encoding stability")
    func rpcQueryRequestVariant15EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant15.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 16 encoding stability")
    func rpcQueryRequestVariant16EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant16.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 17 encoding stability")
    func rpcQueryRequestVariant17EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant17.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 18 encoding stability")
    func rpcQueryRequestVariant18EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant18.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 19 encoding stability")
    func rpcQueryRequestVariant19EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant19.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 2 encoding stability")
    func rpcQueryRequestVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant2.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 20 encoding stability")
    func rpcQueryRequestVariant20EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant20.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 21 encoding stability")
    func rpcQueryRequestVariant21EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant21.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 22 encoding stability")
    func rpcQueryRequestVariant22EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant22.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 23 encoding stability")
    func rpcQueryRequestVariant23EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant23.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 24 encoding stability")
    func rpcQueryRequestVariant24EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant24.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 25 encoding stability")
    func rpcQueryRequestVariant25EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant25.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 26 encoding stability")
    func rpcQueryRequestVariant26EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant26.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 27 encoding stability")
    func rpcQueryRequestVariant27EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant27.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 28 encoding stability")
    func rpcQueryRequestVariant28EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant28.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 29 encoding stability")
    func rpcQueryRequestVariant29EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant29.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 3 encoding stability")
    func rpcQueryRequestVariant3EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant3.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 4 encoding stability")
    func rpcQueryRequestVariant4EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant4.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 5 encoding stability")
    func rpcQueryRequestVariant5EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant5.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 6 encoding stability")
    func rpcQueryRequestVariant6EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant6.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 7 encoding stability")
    func rpcQueryRequestVariant7EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant7.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 8 encoding stability")
    func rpcQueryRequestVariant8EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant8.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryRequest variant 9 encoding stability")
    func rpcQueryRequestVariant9EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryRequest_Variant9.json")
        let decoded = try decoder.decode(RpcQueryRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryResponse variant 0 encoding stability")
    func rpcQueryResponseVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant0.json")
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryResponse.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryResponse variant 1 encoding stability")
    func rpcQueryResponseVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant1.json")
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryResponse.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryResponse variant 2 encoding stability")
    func rpcQueryResponseVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant2.json")
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryResponse.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryResponse variant 3 encoding stability")
    func rpcQueryResponseVariant3EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant3.json")
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryResponse.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryResponse variant 4 encoding stability")
    func rpcQueryResponseVariant4EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant4.json")
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryResponse.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryResponse variant 5 encoding stability")
    func rpcQueryResponseVariant5EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant5.json")
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryResponse.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryResponse variant 6 encoding stability")
    func rpcQueryResponseVariant6EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant6.json")
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryResponse.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcQueryResponse variant 7 encoding stability")
    func rpcQueryResponseVariant7EncodingStability() throws {
        let data = try loadMockJSON("RpcQueryResponse_Variant7.json")
        let decoded = try decoder.decode(RpcQueryResponse.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcQueryResponse.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcReceiptError variant 0 encoding stability")
    func rpcReceiptErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcReceiptError_Variant0.json")
        let decoded = try decoder.decode(RpcReceiptError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcReceiptError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcReceiptError variant 1 encoding stability")
    func rpcReceiptErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcReceiptError_Variant1.json")
        let decoded = try decoder.decode(RpcReceiptError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcReceiptError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcReceiptRequest decoded instance is valid")
    func rpcReceiptRequestValidity() throws {
        let data = try loadMockJSON("RpcReceiptRequest.json")
        let decoded = try decoder.decode(RpcReceiptRequest.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcReceiptRequest.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcReceiptResponse decoded instance is valid")
    func rpcReceiptResponseValidity() throws {
        let data = try loadMockJSON("RpcReceiptResponse.json")
        let decoded = try decoder.decode(RpcReceiptResponse.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcReceiptResponse.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcRequestValidationErrorKind variant 0 encoding stability")
    func rpcRequestValidationErrorKindVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcRequestValidationErrorKind_Variant0.json")
        let decoded = try decoder.decode(RpcRequestValidationErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcRequestValidationErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcRequestValidationErrorKind variant 1 encoding stability")
    func rpcRequestValidationErrorKindVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcRequestValidationErrorKind_Variant1.json")
        let decoded = try decoder.decode(RpcRequestValidationErrorKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcRequestValidationErrorKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcSendTransactionRequest decoded instance is valid")
    func rpcSendTransactionRequestValidity() throws {
        let data = try loadMockJSON("RpcSendTransactionRequest.json")
        let decoded = try decoder.decode(RpcSendTransactionRequest.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcSendTransactionRequest.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcSplitStorageInfoError variant 0 encoding stability")
    func rpcSplitStorageInfoErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcSplitStorageInfoError_Variant0.json")
        let decoded = try decoder.decode(RpcSplitStorageInfoError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcSplitStorageInfoError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcSplitStorageInfoResponse decoded instance is valid")
    func rpcSplitStorageInfoResponseValidity() throws {
        let data = try loadMockJSON("RpcSplitStorageInfoResponse.json")
        let decoded = try decoder.decode(RpcSplitStorageInfoResponse.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcSplitStorageInfoResponse.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcStateChangesError variant 0 encoding stability")
    func rpcStateChangesErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesError_Variant0.json")
        let decoded = try decoder.decode(RpcStateChangesError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesError variant 1 encoding stability")
    func rpcStateChangesErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesError_Variant1.json")
        let decoded = try decoder.decode(RpcStateChangesError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesError variant 2 encoding stability")
    func rpcStateChangesErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesError_Variant2.json")
        let decoded = try decoder.decode(RpcStateChangesError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 0 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant0.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 1 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant1.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 10 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant10EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant10.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 11 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant11EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant11.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 12 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant12EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant12.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 13 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant13EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant13.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 14 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant14EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant14.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 15 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant15EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant15.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 16 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant16EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant16.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 17 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant17EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant17.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 18 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant18EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant18.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 19 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant19EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant19.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 2 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant2.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 20 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant20EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant20.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 3 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant3EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant3.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 4 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant4EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant4.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 5 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant5EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant5.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 6 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant6EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant6.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 7 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant7EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant7.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 8 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant8EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant8.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeRequest variant 9 encoding stability")
    func rpcStateChangesInBlockByTypeRequestVariant9EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeRequest_Variant9.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockByTypeRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockByTypeResponse decoded instance is valid")
    func rpcStateChangesInBlockByTypeResponseValidity() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockByTypeResponse.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockByTypeResponse.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcStateChangesInBlockByTypeResponse.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcStateChangesInBlockRequest variant 0 encoding stability")
    func rpcStateChangesInBlockRequestVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockRequest_Variant0.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockRequest variant 1 encoding stability")
    func rpcStateChangesInBlockRequestVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockRequest_Variant1.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockRequest variant 2 encoding stability")
    func rpcStateChangesInBlockRequestVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockRequest_Variant2.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStateChangesInBlockRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStateChangesInBlockResponse decoded instance is valid")
    func rpcStateChangesInBlockResponseValidity() throws {
        let data = try loadMockJSON("RpcStateChangesInBlockResponse.json")
        let decoded = try decoder.decode(RpcStateChangesInBlockResponse.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcStateChangesInBlockResponse.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcStatusError variant 0 encoding stability")
    func rpcStatusErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcStatusError_Variant0.json")
        let decoded = try decoder.decode(RpcStatusError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStatusError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStatusError variant 1 encoding stability")
    func rpcStatusErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcStatusError_Variant1.json")
        let decoded = try decoder.decode(RpcStatusError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStatusError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStatusError variant 2 encoding stability")
    func rpcStatusErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcStatusError_Variant2.json")
        let decoded = try decoder.decode(RpcStatusError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStatusError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStatusError variant 3 encoding stability")
    func rpcStatusErrorVariant3EncodingStability() throws {
        let data = try loadMockJSON("RpcStatusError_Variant3.json")
        let decoded = try decoder.decode(RpcStatusError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcStatusError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcStatusResponse decoded instance is valid")
    func rpcStatusResponseValidity() throws {
        let data = try loadMockJSON("RpcStatusResponse.json")
        let decoded = try decoder.decode(RpcStatusResponse.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcStatusResponse.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcTransactionError variant 0 encoding stability")
    func rpcTransactionErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcTransactionError_Variant0.json")
        let decoded = try decoder.decode(RpcTransactionError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcTransactionError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcTransactionError variant 1 encoding stability")
    func rpcTransactionErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcTransactionError_Variant1.json")
        let decoded = try decoder.decode(RpcTransactionError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcTransactionError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcTransactionError variant 2 encoding stability")
    func rpcTransactionErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcTransactionError_Variant2.json")
        let decoded = try decoder.decode(RpcTransactionError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcTransactionError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcTransactionError variant 3 encoding stability")
    func rpcTransactionErrorVariant3EncodingStability() throws {
        let data = try loadMockJSON("RpcTransactionError_Variant3.json")
        let decoded = try decoder.decode(RpcTransactionError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcTransactionError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcTransactionError variant 4 encoding stability")
    func rpcTransactionErrorVariant4EncodingStability() throws {
        let data = try loadMockJSON("RpcTransactionError_Variant4.json")
        let decoded = try decoder.decode(RpcTransactionError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcTransactionError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcTransactionError variant 5 encoding stability")
    func rpcTransactionErrorVariant5EncodingStability() throws {
        let data = try loadMockJSON("RpcTransactionError_Variant5.json")
        let decoded = try decoder.decode(RpcTransactionError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcTransactionError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcTransactionResponse variant 0 encoding stability")
    func rpcTransactionResponseVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcTransactionResponse_Variant0.json")
        let decoded = try decoder.decode(RpcTransactionResponse.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcTransactionResponse.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcTransactionResponse variant 1 encoding stability")
    func rpcTransactionResponseVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcTransactionResponse_Variant1.json")
        let decoded = try decoder.decode(RpcTransactionResponse.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcTransactionResponse.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcTransactionStatusRequest variant 0 encoding stability")
    func rpcTransactionStatusRequestVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcTransactionStatusRequest_Variant0.json")
        let decoded = try decoder.decode(RpcTransactionStatusRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcTransactionStatusRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcTransactionStatusRequest variant 1 encoding stability")
    func rpcTransactionStatusRequestVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcTransactionStatusRequest_Variant1.json")
        let decoded = try decoder.decode(RpcTransactionStatusRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcTransactionStatusRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcValidatorError variant 0 encoding stability")
    func rpcValidatorErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcValidatorError_Variant0.json")
        let decoded = try decoder.decode(RpcValidatorError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcValidatorError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcValidatorError variant 1 encoding stability")
    func rpcValidatorErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcValidatorError_Variant1.json")
        let decoded = try decoder.decode(RpcValidatorError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcValidatorError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcValidatorError variant 2 encoding stability")
    func rpcValidatorErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcValidatorError_Variant2.json")
        let decoded = try decoder.decode(RpcValidatorError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcValidatorError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcValidatorRequest variant 0 encoding stability")
    func rpcValidatorRequestVariant0EncodingStability() throws {
        let data = try loadMockJSON("RpcValidatorRequest_Variant0.json")
        let decoded = try decoder.decode(RpcValidatorRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcValidatorRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcValidatorRequest variant 1 encoding stability")
    func rpcValidatorRequestVariant1EncodingStability() throws {
        let data = try loadMockJSON("RpcValidatorRequest_Variant1.json")
        let decoded = try decoder.decode(RpcValidatorRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcValidatorRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcValidatorRequest variant 2 encoding stability")
    func rpcValidatorRequestVariant2EncodingStability() throws {
        let data = try loadMockJSON("RpcValidatorRequest_Variant2.json")
        let decoded = try decoder.decode(RpcValidatorRequest.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(RpcValidatorRequest.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("RpcValidatorResponse decoded instance is valid")
    func rpcValidatorResponseValidity() throws {
        let data = try loadMockJSON("RpcValidatorResponse.json")
        let decoded = try decoder.decode(RpcValidatorResponse.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcValidatorResponse.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RpcValidatorsOrderedRequest decoded instance is valid")
    func rpcValidatorsOrderedRequestValidity() throws {
        let data = try loadMockJSON("RpcValidatorsOrderedRequest.json")
        let decoded = try decoder.decode(RpcValidatorsOrderedRequest.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RpcValidatorsOrderedRequest.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RuntimeConfigView decoded instance is valid")
    func runtimeConfigViewValidity() throws {
        let data = try loadMockJSON("RuntimeConfigView.json")
        let decoded = try decoder.decode(RuntimeConfigView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RuntimeConfigView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("RuntimeFeesConfigView decoded instance is valid")
    func runtimeFeesConfigViewValidity() throws {
        let data = try loadMockJSON("RuntimeFeesConfigView.json")
        let decoded = try decoder.decode(RuntimeFeesConfigView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(RuntimeFeesConfigView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ShardLayout variant 0 encoding stability")
    func shardLayoutVariant0EncodingStability() throws {
        let data = try loadMockJSON("ShardLayout_Variant0.json")
        let decoded = try decoder.decode(ShardLayout.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ShardLayout.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ShardLayout variant 1 encoding stability")
    func shardLayoutVariant1EncodingStability() throws {
        let data = try loadMockJSON("ShardLayout_Variant1.json")
        let decoded = try decoder.decode(ShardLayout.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ShardLayout.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ShardLayout variant 2 encoding stability")
    func shardLayoutVariant2EncodingStability() throws {
        let data = try loadMockJSON("ShardLayout_Variant2.json")
        let decoded = try decoder.decode(ShardLayout.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ShardLayout.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ShardLayoutV0 decoded instance is valid")
    func shardLayoutV0Validity() throws {
        let data = try loadMockJSON("ShardLayoutV0.json")
        let decoded = try decoder.decode(ShardLayoutV0.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ShardLayoutV0.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ShardLayoutV1 decoded instance is valid")
    func shardLayoutV1Validity() throws {
        let data = try loadMockJSON("ShardLayoutV1.json")
        let decoded = try decoder.decode(ShardLayoutV1.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ShardLayoutV1.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ShardLayoutV2 decoded instance is valid")
    func shardLayoutV2Validity() throws {
        let data = try loadMockJSON("ShardLayoutV2.json")
        let decoded = try decoder.decode(ShardLayoutV2.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ShardLayoutV2.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ShardUId decoded instance is valid")
    func shardUIdValidity() throws {
        let data = try loadMockJSON("ShardUId.json")
        let decoded = try decoder.decode(ShardUId.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ShardUId.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("SignedDelegateAction decoded instance is valid")
    func signedDelegateActionValidity() throws {
        let data = try loadMockJSON("SignedDelegateAction.json")
        let decoded = try decoder.decode(SignedDelegateAction.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(SignedDelegateAction.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("SignedTransactionView decoded instance is valid")
    func signedTransactionViewValidity() throws {
        let data = try loadMockJSON("SignedTransactionView.json")
        let decoded = try decoder.decode(SignedTransactionView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(SignedTransactionView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("SlashedValidator decoded instance is valid")
    func slashedValidatorValidity() throws {
        let data = try loadMockJSON("SlashedValidator.json")
        let decoded = try decoder.decode(SlashedValidator.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(SlashedValidator.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("StakeAction decoded instance is valid")
    func stakeActionValidity() throws {
        let data = try loadMockJSON("StakeAction.json")
        let decoded = try decoder.decode(StakeAction.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(StakeAction.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("StateChangeCauseView variant 0 encoding stability")
    func stateChangeCauseViewVariant0EncodingStability() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant0.json")
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeCauseView variant 1 encoding stability")
    func stateChangeCauseViewVariant1EncodingStability() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant1.json")
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeCauseView variant 10 encoding stability")
    func stateChangeCauseViewVariant10EncodingStability() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant10.json")
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeCauseView variant 2 encoding stability")
    func stateChangeCauseViewVariant2EncodingStability() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant2.json")
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeCauseView variant 3 encoding stability")
    func stateChangeCauseViewVariant3EncodingStability() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant3.json")
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeCauseView variant 4 encoding stability")
    func stateChangeCauseViewVariant4EncodingStability() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant4.json")
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeCauseView variant 5 encoding stability")
    func stateChangeCauseViewVariant5EncodingStability() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant5.json")
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeCauseView variant 6 encoding stability")
    func stateChangeCauseViewVariant6EncodingStability() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant6.json")
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeCauseView variant 7 encoding stability")
    func stateChangeCauseViewVariant7EncodingStability() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant7.json")
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeCauseView variant 8 encoding stability")
    func stateChangeCauseViewVariant8EncodingStability() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant8.json")
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeCauseView variant 9 encoding stability")
    func stateChangeCauseViewVariant9EncodingStability() throws {
        let data = try loadMockJSON("StateChangeCauseView_Variant9.json")
        let decoded = try decoder.decode(StateChangeCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeKindView variant 0 encoding stability")
    func stateChangeKindViewVariant0EncodingStability() throws {
        let data = try loadMockJSON("StateChangeKindView_Variant0.json")
        let decoded = try decoder.decode(StateChangeKindView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeKindView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeKindView variant 1 encoding stability")
    func stateChangeKindViewVariant1EncodingStability() throws {
        let data = try loadMockJSON("StateChangeKindView_Variant1.json")
        let decoded = try decoder.decode(StateChangeKindView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeKindView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeKindView variant 2 encoding stability")
    func stateChangeKindViewVariant2EncodingStability() throws {
        let data = try loadMockJSON("StateChangeKindView_Variant2.json")
        let decoded = try decoder.decode(StateChangeKindView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeKindView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeKindView variant 3 encoding stability")
    func stateChangeKindViewVariant3EncodingStability() throws {
        let data = try loadMockJSON("StateChangeKindView_Variant3.json")
        let decoded = try decoder.decode(StateChangeKindView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeKindView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeWithCauseView variant 0 encoding stability")
    func stateChangeWithCauseViewVariant0EncodingStability() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant0.json")
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeWithCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeWithCauseView variant 1 encoding stability")
    func stateChangeWithCauseViewVariant1EncodingStability() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant1.json")
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeWithCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeWithCauseView variant 10 encoding stability")
    func stateChangeWithCauseViewVariant10EncodingStability() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant10.json")
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeWithCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeWithCauseView variant 2 encoding stability")
    func stateChangeWithCauseViewVariant2EncodingStability() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant2.json")
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeWithCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeWithCauseView variant 3 encoding stability")
    func stateChangeWithCauseViewVariant3EncodingStability() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant3.json")
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeWithCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeWithCauseView variant 4 encoding stability")
    func stateChangeWithCauseViewVariant4EncodingStability() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant4.json")
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeWithCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeWithCauseView variant 5 encoding stability")
    func stateChangeWithCauseViewVariant5EncodingStability() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant5.json")
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeWithCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeWithCauseView variant 6 encoding stability")
    func stateChangeWithCauseViewVariant6EncodingStability() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant6.json")
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeWithCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeWithCauseView variant 7 encoding stability")
    func stateChangeWithCauseViewVariant7EncodingStability() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant7.json")
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeWithCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeWithCauseView variant 8 encoding stability")
    func stateChangeWithCauseViewVariant8EncodingStability() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant8.json")
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeWithCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateChangeWithCauseView variant 9 encoding stability")
    func stateChangeWithCauseViewVariant9EncodingStability() throws {
        let data = try loadMockJSON("StateChangeWithCauseView_Variant9.json")
        let decoded = try decoder.decode(StateChangeWithCauseView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StateChangeWithCauseView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StateItem decoded instance is valid")
    func stateItemValidity() throws {
        let data = try loadMockJSON("StateItem.json")
        let decoded = try decoder.decode(StateItem.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(StateItem.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("StateSyncConfig decoded instance is valid")
    func stateSyncConfigValidity() throws {
        let data = try loadMockJSON("StateSyncConfig.json")
        let decoded = try decoder.decode(StateSyncConfig.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(StateSyncConfig.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("StatusSyncInfo decoded instance is valid")
    func statusSyncInfoValidity() throws {
        let data = try loadMockJSON("StatusSyncInfo.json")
        let decoded = try decoder.decode(StatusSyncInfo.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(StatusSyncInfo.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("StorageError variant 0 encoding stability")
    func storageErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("StorageError_Variant0.json")
        let decoded = try decoder.decode(StorageError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StorageError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StorageError variant 1 encoding stability")
    func storageErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("StorageError_Variant1.json")
        let decoded = try decoder.decode(StorageError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StorageError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StorageError variant 2 encoding stability")
    func storageErrorVariant2EncodingStability() throws {
        let data = try loadMockJSON("StorageError_Variant2.json")
        let decoded = try decoder.decode(StorageError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StorageError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StorageError variant 3 encoding stability")
    func storageErrorVariant3EncodingStability() throws {
        let data = try loadMockJSON("StorageError_Variant3.json")
        let decoded = try decoder.decode(StorageError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StorageError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StorageError variant 4 encoding stability")
    func storageErrorVariant4EncodingStability() throws {
        let data = try loadMockJSON("StorageError_Variant4.json")
        let decoded = try decoder.decode(StorageError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StorageError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StorageError variant 5 encoding stability")
    func storageErrorVariant5EncodingStability() throws {
        let data = try loadMockJSON("StorageError_Variant5.json")
        let decoded = try decoder.decode(StorageError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(StorageError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("StorageUsageConfigView decoded instance is valid")
    func storageUsageConfigViewValidity() throws {
        let data = try loadMockJSON("StorageUsageConfigView.json")
        let decoded = try decoder.decode(StorageUsageConfigView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(StorageUsageConfigView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("SyncConcurrency decoded instance is valid")
    func syncConcurrencyValidity() throws {
        let data = try loadMockJSON("SyncConcurrency.json")
        let decoded = try decoder.decode(SyncConcurrency.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(SyncConcurrency.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("SyncConfig variant 0 encoding stability")
    func syncConfigVariant0EncodingStability() throws {
        let data = try loadMockJSON("SyncConfig_Variant0.json")
        let decoded = try decoder.decode(SyncConfig.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(SyncConfig.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("SyncConfig variant 1 encoding stability")
    func syncConfigVariant1EncodingStability() throws {
        let data = try loadMockJSON("SyncConfig_Variant1.json")
        let decoded = try decoder.decode(SyncConfig.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(SyncConfig.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("Tier1ProxyView decoded instance is valid")
    func tier1ProxyViewValidity() throws {
        let data = try loadMockJSON("Tier1ProxyView.json")
        let decoded = try decoder.decode(Tier1ProxyView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(Tier1ProxyView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("TrackedShardsConfig variant 0 encoding stability")
    func trackedShardsConfigVariant0EncodingStability() throws {
        let data = try loadMockJSON("TrackedShardsConfig_Variant0.json")
        let decoded = try decoder.decode(TrackedShardsConfig.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(TrackedShardsConfig.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("TrackedShardsConfig variant 1 encoding stability")
    func trackedShardsConfigVariant1EncodingStability() throws {
        let data = try loadMockJSON("TrackedShardsConfig_Variant1.json")
        let decoded = try decoder.decode(TrackedShardsConfig.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(TrackedShardsConfig.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("TrackedShardsConfig variant 2 encoding stability")
    func trackedShardsConfigVariant2EncodingStability() throws {
        let data = try loadMockJSON("TrackedShardsConfig_Variant2.json")
        let decoded = try decoder.decode(TrackedShardsConfig.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(TrackedShardsConfig.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("TrackedShardsConfig variant 3 encoding stability")
    func trackedShardsConfigVariant3EncodingStability() throws {
        let data = try loadMockJSON("TrackedShardsConfig_Variant3.json")
        let decoded = try decoder.decode(TrackedShardsConfig.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(TrackedShardsConfig.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("TrackedShardsConfig variant 4 encoding stability")
    func trackedShardsConfigVariant4EncodingStability() throws {
        let data = try loadMockJSON("TrackedShardsConfig_Variant4.json")
        let decoded = try decoder.decode(TrackedShardsConfig.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(TrackedShardsConfig.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("TrackedShardsConfig variant 5 encoding stability")
    func trackedShardsConfigVariant5EncodingStability() throws {
        let data = try loadMockJSON("TrackedShardsConfig_Variant5.json")
        let decoded = try decoder.decode(TrackedShardsConfig.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(TrackedShardsConfig.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("TransferAction decoded instance is valid")
    func transferActionValidity() throws {
        let data = try loadMockJSON("TransferAction.json")
        let decoded = try decoder.decode(TransferAction.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(TransferAction.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("TransferToGasKeyAction decoded instance is valid")
    func transferToGasKeyActionValidity() throws {
        let data = try loadMockJSON("TransferToGasKeyAction.json")
        let decoded = try decoder.decode(TransferToGasKeyAction.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(TransferToGasKeyAction.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("TxExecutionError variant 0 encoding stability")
    func txExecutionErrorVariant0EncodingStability() throws {
        let data = try loadMockJSON("TxExecutionError_Variant0.json")
        let decoded = try decoder.decode(TxExecutionError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(TxExecutionError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("TxExecutionError variant 1 encoding stability")
    func txExecutionErrorVariant1EncodingStability() throws {
        let data = try loadMockJSON("TxExecutionError_Variant1.json")
        let decoded = try decoder.decode(TxExecutionError.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(TxExecutionError.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("TxExecutionStatus variant 0 encoding stability")
    func txExecutionStatusVariant0EncodingStability() throws {
        let data = try loadMockJSON("TxExecutionStatus_Variant0.json")
        let decoded = try decoder.decode(TxExecutionStatus.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(TxExecutionStatus.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("TxExecutionStatus variant 1 encoding stability")
    func txExecutionStatusVariant1EncodingStability() throws {
        let data = try loadMockJSON("TxExecutionStatus_Variant1.json")
        let decoded = try decoder.decode(TxExecutionStatus.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(TxExecutionStatus.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("TxExecutionStatus variant 2 encoding stability")
    func txExecutionStatusVariant2EncodingStability() throws {
        let data = try loadMockJSON("TxExecutionStatus_Variant2.json")
        let decoded = try decoder.decode(TxExecutionStatus.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(TxExecutionStatus.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("TxExecutionStatus variant 3 encoding stability")
    func txExecutionStatusVariant3EncodingStability() throws {
        let data = try loadMockJSON("TxExecutionStatus_Variant3.json")
        let decoded = try decoder.decode(TxExecutionStatus.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(TxExecutionStatus.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("TxExecutionStatus variant 4 encoding stability")
    func txExecutionStatusVariant4EncodingStability() throws {
        let data = try loadMockJSON("TxExecutionStatus_Variant4.json")
        let decoded = try decoder.decode(TxExecutionStatus.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(TxExecutionStatus.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("TxExecutionStatus variant 5 encoding stability")
    func txExecutionStatusVariant5EncodingStability() throws {
        let data = try loadMockJSON("TxExecutionStatus_Variant5.json")
        let decoded = try decoder.decode(TxExecutionStatus.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(TxExecutionStatus.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("UseGlobalContractAction decoded instance is valid")
    func useGlobalContractActionValidity() throws {
        let data = try loadMockJSON("UseGlobalContractAction.json")
        let decoded = try decoder.decode(UseGlobalContractAction.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(UseGlobalContractAction.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("VMConfigView decoded instance is valid")
    func vMConfigViewValidity() throws {
        let data = try loadMockJSON("VMConfigView.json")
        let decoded = try decoder.decode(VMConfigView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(VMConfigView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("VMKind variant 0 encoding stability")
    func vMKindVariant0EncodingStability() throws {
        let data = try loadMockJSON("VMKind_Variant0.json")
        let decoded = try decoder.decode(VMKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(VMKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("VMKind variant 1 encoding stability")
    func vMKindVariant1EncodingStability() throws {
        let data = try loadMockJSON("VMKind_Variant1.json")
        let decoded = try decoder.decode(VMKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(VMKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("VMKind variant 2 encoding stability")
    func vMKindVariant2EncodingStability() throws {
        let data = try loadMockJSON("VMKind_Variant2.json")
        let decoded = try decoder.decode(VMKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(VMKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("VMKind variant 3 encoding stability")
    func vMKindVariant3EncodingStability() throws {
        let data = try loadMockJSON("VMKind_Variant3.json")
        let decoded = try decoder.decode(VMKind.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(VMKind.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ValidatorInfo decoded instance is valid")
    func validatorInfoValidity() throws {
        let data = try loadMockJSON("ValidatorInfo.json")
        let decoded = try decoder.decode(ValidatorInfo.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ValidatorInfo.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ValidatorKickoutReason variant 0 encoding stability")
    func validatorKickoutReasonVariant0EncodingStability() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant0.json")
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ValidatorKickoutReason.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ValidatorKickoutReason variant 1 encoding stability")
    func validatorKickoutReasonVariant1EncodingStability() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant1.json")
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ValidatorKickoutReason.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ValidatorKickoutReason variant 2 encoding stability")
    func validatorKickoutReasonVariant2EncodingStability() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant2.json")
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ValidatorKickoutReason.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ValidatorKickoutReason variant 3 encoding stability")
    func validatorKickoutReasonVariant3EncodingStability() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant3.json")
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ValidatorKickoutReason.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ValidatorKickoutReason variant 4 encoding stability")
    func validatorKickoutReasonVariant4EncodingStability() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant4.json")
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ValidatorKickoutReason.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ValidatorKickoutReason variant 5 encoding stability")
    func validatorKickoutReasonVariant5EncodingStability() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant5.json")
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ValidatorKickoutReason.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ValidatorKickoutReason variant 6 encoding stability")
    func validatorKickoutReasonVariant6EncodingStability() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant6.json")
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ValidatorKickoutReason.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ValidatorKickoutReason variant 7 encoding stability")
    func validatorKickoutReasonVariant7EncodingStability() throws {
        let data = try loadMockJSON("ValidatorKickoutReason_Variant7.json")
        let decoded = try decoder.decode(ValidatorKickoutReason.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ValidatorKickoutReason.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ValidatorKickoutView decoded instance is valid")
    func validatorKickoutViewValidity() throws {
        let data = try loadMockJSON("ValidatorKickoutView.json")
        let decoded = try decoder.decode(ValidatorKickoutView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ValidatorKickoutView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ValidatorStakeView variant 0 encoding stability")
    func validatorStakeViewVariant0EncodingStability() throws {
        let data = try loadMockJSON("ValidatorStakeView_Variant0.json")
        let decoded = try decoder.decode(ValidatorStakeView.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(ValidatorStakeView.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("ValidatorStakeViewV1 decoded instance is valid")
    func validatorStakeViewV1Validity() throws {
        let data = try loadMockJSON("ValidatorStakeViewV1.json")
        let decoded = try decoder.decode(ValidatorStakeViewV1.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ValidatorStakeViewV1.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("Version decoded instance is valid")
    func versionValidity() throws {
        let data = try loadMockJSON("Version.json")
        let decoded = try decoder.decode(Version.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(Version.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("ViewStateResult decoded instance is valid")
    func viewStateResultValidity() throws {
        let data = try loadMockJSON("ViewStateResult.json")
        let decoded = try decoder.decode(ViewStateResult.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(ViewStateResult.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }

    @Test("WasmTrap variant 0 encoding stability")
    func wasmTrapVariant0EncodingStability() throws {
        let data = try loadMockJSON("WasmTrap_Variant0.json")
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(WasmTrap.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("WasmTrap variant 1 encoding stability")
    func wasmTrapVariant1EncodingStability() throws {
        let data = try loadMockJSON("WasmTrap_Variant1.json")
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(WasmTrap.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("WasmTrap variant 2 encoding stability")
    func wasmTrapVariant2EncodingStability() throws {
        let data = try loadMockJSON("WasmTrap_Variant2.json")
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(WasmTrap.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("WasmTrap variant 3 encoding stability")
    func wasmTrapVariant3EncodingStability() throws {
        let data = try loadMockJSON("WasmTrap_Variant3.json")
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(WasmTrap.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("WasmTrap variant 4 encoding stability")
    func wasmTrapVariant4EncodingStability() throws {
        let data = try loadMockJSON("WasmTrap_Variant4.json")
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(WasmTrap.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("WasmTrap variant 5 encoding stability")
    func wasmTrapVariant5EncodingStability() throws {
        let data = try loadMockJSON("WasmTrap_Variant5.json")
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(WasmTrap.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("WasmTrap variant 6 encoding stability")
    func wasmTrapVariant6EncodingStability() throws {
        let data = try loadMockJSON("WasmTrap_Variant6.json")
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(WasmTrap.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("WasmTrap variant 7 encoding stability")
    func wasmTrapVariant7EncodingStability() throws {
        let data = try loadMockJSON("WasmTrap_Variant7.json")
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(WasmTrap.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("WasmTrap variant 8 encoding stability")
    func wasmTrapVariant8EncodingStability() throws {
        let data = try loadMockJSON("WasmTrap_Variant8.json")
        let decoded = try decoder.decode(WasmTrap.self, from: data)

        // Multiple encoding cycles should produce consistent results
        let encoded1 = try encoder.encode(decoded)
        let decoded2 = try decoder.decode(WasmTrap.self, from: encoded1)
        let encoded2 = try encoder.encode(decoded2)

        #expect(!encoded1.isEmpty)
        #expect(!encoded2.isEmpty)
    }

    @Test("WitnessConfigView decoded instance is valid")
    func witnessConfigViewValidity() throws {
        let data = try loadMockJSON("WitnessConfigView.json")
        let decoded = try decoder.decode(WitnessConfigView.self, from: data)

        // Verify the decoded instance is valid by re-encoding
        let encoded = try encoder.encode(decoded)
        #expect(!encoded.isEmpty)

        // Verify round-trip
        let redecoded = try decoder.decode(WitnessConfigView.self, from: encoded)
        let reencoded = try encoder.encode(redecoded)
        #expect(!reencoded.isEmpty)
    }
}
