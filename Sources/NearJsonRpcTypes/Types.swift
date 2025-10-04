import Foundation

// MARK: - AnyCodable Helper

public struct AnyCodable: Codable {
    public let value: Any

    public init(_ value: Any) {
        self.value = value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            value = NSNull()
        } else if let bool = try? container.decode(Bool.self) {
            value = bool
        } else if let int = try? container.decode(Int.self) {
            value = int
        } else if let double = try? container.decode(Double.self) {
            value = double
        } else if let string = try? container.decode(String.self) {
            value = string
        } else if let array = try? container.decode([AnyCodable].self) {
            value = array.map(\.value)
        } else if let dictionary = try? container.decode([String: AnyCodable].self) {
            value = dictionary.mapValues { $0.value }
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode AnyCodable")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        if value is NSNull {
            try container.encodeNil()
        } else if let bool = value as? Bool {
            try container.encode(bool)
        } else if let int = value as? Int {
            try container.encode(int)
        } else if let double = value as? Double {
            try container.encode(double)
        } else if let string = value as? String {
            try container.encode(string)
        } else if let array = value as? [Any] {
            try container.encode(array.map(AnyCodable.init))
        } else if let dictionary = value as? [String: Any] {
            try container.encode(dictionary.mapValues(AnyCodable.init))
        } else {
            throw EncodingError.invalidValue(
                value,
                EncodingError.Context(codingPath: [], debugDescription: "Cannot encode AnyCodable")
            )
        }
    }
}

// MARK: - AnyCodingKey Helper

/// A dynamic CodingKey that can represent any string key
struct AnyCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init(stringValue: String) {
        self.stringValue = stringValue
        intValue = nil
    }

    init?(intValue: Int) {
        stringValue = String(intValue)
        self.intValue = intValue
    }
}

// MARK: - Decoding Diagnostics Helpers

private func describeCodingKey(_ key: CodingKey) -> String {
    if let intValue = key.intValue {
        return "[\(intValue)]"
    }
    let stringValue = key.stringValue
    return stringValue.isEmpty ? "\"\"" : stringValue
}

private func describeCodingPath(_ codingPath: [CodingKey]) -> String {
    guard !codingPath.isEmpty else { return "<root>" }
    var description = ""
    for key in codingPath {
        if let intValue = key.intValue {
            description += "[\(intValue)]"
        } else {
            if !description.isEmpty {
                description += "."
            }
            description += key.stringValue
        }
    }
    return description
}

private func describeDecodingError(_ error: Error) -> String {
    if let decodingError = error as? DecodingError {
        switch decodingError {
        case let .typeMismatch(_, context):
            return "typeMismatch at \(describeCodingPath(context.codingPath)): \(context.debugDescription)"
        case let .valueNotFound(_, context):
            return "valueNotFound at \(describeCodingPath(context.codingPath)): \(context.debugDescription)"
        case let .keyNotFound(key, context):
            return "keyNotFound for key '\(describeCodingKey(key))' at \(describeCodingPath(context.codingPath)): \(context.debugDescription)"
        case let .dataCorrupted(context):
            return "dataCorrupted at \(describeCodingPath(context.codingPath)): \(context.debugDescription)"
        @unknown default:
            return "Unknown DecodingError: \(decodingError)"
        }
    }
    return String(describing: error)
}

// MARK: - AccountId

public typealias AccountId = String

// MARK: - AccountIdValidityRulesVersion

public typealias AccountIdValidityRulesVersion = Int

// MARK: - CryptoHash

public typealias CryptoHash = String

// MARK: - Direction

public enum Direction: String, Codable, Sendable {
    case left = "Left"
    case right = "Right"
}

// MARK: - Finality

public enum Finality: String, Codable, Sendable {
    case optimistic
    case nearFinal = "near-final"
    case final
}

// MARK: - FunctionArgs

public typealias FunctionArgs = String

// MARK: - LogSummaryStyle

public enum LogSummaryStyle: String, Codable, Sendable {
    case plain
    case colored
}

// MARK: - MethodResolveError

public enum MethodResolveError: String, Codable, Sendable {
    case methodEmptyName = "MethodEmptyName"
    case methodNotFound = "MethodNotFound"
    case methodInvalidSignature = "MethodInvalidSignature"
}

// MARK: - MutableConfigValue

public typealias MutableConfigValue = String

// MARK: - NearGas

public typealias NearGas = UInt64

// MARK: - NearToken

public typealias NearToken = String

// MARK: - ProtocolVersionCheckConfig

public enum ProtocolVersionCheckConfig: String, Codable, Sendable {
    case next = "Next"
    case nextNext = "NextNext"
}

// MARK: - PublicKey

public typealias PublicKey = String

// MARK: - ShardId

public typealias ShardId = UInt64

// MARK: - Signature

public typealias Signature = String

// MARK: - SignedTransaction

public typealias SignedTransaction = Data

// MARK: - StorageGetMode

public enum StorageGetMode: String, Codable, Sendable {
    case flatStorage = "FlatStorage"
    case trie = "Trie"
}

// MARK: - StoreKey

public typealias StoreKey = String

// MARK: - StoreValue

public typealias StoreValue = String

// MARK: - SyncCheckpoint

public enum SyncCheckpoint: String, Codable, Sendable {
    case genesis
    case earliestAvailable = "earliest_available"
}

// MARK: - GenesisConfigRequest

public struct GenesisConfigRequest: Codable {
    public init() {}

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(
                GenesisConfigRequest.self,
                DecodingError.Context(codingPath: [], debugDescription: "Expected null")
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

// MARK: - RpcClientConfigRequest

public struct RpcClientConfigRequest: Codable {
    public init() {}

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(
                RpcClientConfigRequest.self,
                DecodingError.Context(codingPath: [], debugDescription: "Expected null")
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

// MARK: - RpcHealthRequest

public struct RpcHealthRequest: Codable {
    public init() {}

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(
                RpcHealthRequest.self,
                DecodingError.Context(codingPath: [], debugDescription: "Expected null")
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

// MARK: - RpcHealthResponse

public struct RpcHealthResponse: Codable {
    public init() {}

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(
                RpcHealthResponse.self,
                DecodingError.Context(codingPath: [], debugDescription: "Expected null")
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

// MARK: - RpcNetworkInfoRequest

public struct RpcNetworkInfoRequest: Codable {
    public init() {}

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(
                RpcNetworkInfoRequest.self,
                DecodingError.Context(codingPath: [], debugDescription: "Expected null")
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

// MARK: - RpcStatusRequest

public struct RpcStatusRequest: Codable {
    public init() {}

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(
                RpcStatusRequest.self,
                DecodingError.Context(codingPath: [], debugDescription: "Expected null")
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

// MARK: - AccessKeyPermission

public enum AccessKeyPermission: Codable {
    case functionCall(FunctionCallPermission)
    case fullAccess

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("FunctionCall") == .orderedSame }) {
                    let value = try container.decode(FunctionCallPermission.self, forKey: matchingKey)
                    self = .functionCall(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".functionCall: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "FullAccess" {
            self = .fullAccess
            return
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for AccessKeyPermission\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for AccessKeyPermission:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case functionCall = "FunctionCall"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .functionCall(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .functionCall)
        case .fullAccess:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("FullAccess")
        }
    }
}

// MARK: - AccessKeyPermissionView

public struct AccessKeyPermissionViewOneOfFunctionCallInline: Codable {
    public let allowance: NearToken?
    public let methodNames: [String]
    public let receiverId: String

    public init(
        allowance: NearToken?,
        methodNames: [String],
        receiverId: String
    ) {
        self.allowance = allowance
        self.methodNames = methodNames
        self.receiverId = receiverId
    }
}

public enum AccessKeyPermissionView: Codable {
    case fullAccess
    case functionCall(AccessKeyPermissionViewOneOfFunctionCallInline)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "FullAccess" {
            self = .fullAccess
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("FunctionCall") == .orderedSame }) {
                    let value = try container.decode(
                        AccessKeyPermissionViewOneOfFunctionCallInline.self,
                        forKey: matchingKey
                    )
                    self = .functionCall(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".functionCall: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for AccessKeyPermissionView\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for AccessKeyPermissionView:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case functionCall = "FunctionCall"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .functionCall(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .functionCall)
        case .fullAccess:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("FullAccess")
        }
    }
}

// MARK: - ActionErrorKind

public struct ActionErrorKindOneOfAccountAlreadyExistsInline: Codable {
    public let accountId: AccountId

    public init(
        accountId: AccountId
    ) {
        self.accountId = accountId
    }
}

public struct ActionErrorKindOneOfAccountDoesNotExistInline: Codable {
    public let accountId: AccountId

    public init(
        accountId: AccountId
    ) {
        self.accountId = accountId
    }
}

public struct ActionErrorKindOneOfCreateAccountOnlyByRegistrarInline: Codable {
    public let accountId: AccountId
    public let predecessorId: AccountId
    public let registrarAccountId: AccountId

    public init(
        accountId: AccountId,
        predecessorId: AccountId,
        registrarAccountId: AccountId
    ) {
        self.accountId = accountId
        self.predecessorId = predecessorId
        self.registrarAccountId = registrarAccountId
    }
}

public struct ActionErrorKindOneOfCreateAccountNotAllowedInline: Codable {
    public let accountId: AccountId
    public let predecessorId: AccountId

    public init(
        accountId: AccountId,
        predecessorId: AccountId
    ) {
        self.accountId = accountId
        self.predecessorId = predecessorId
    }
}

public struct ActionErrorKindOneOfActorNoPermissionInline: Codable {
    public let accountId: AccountId
    public let actorId: AccountId

    public init(
        accountId: AccountId,
        actorId: AccountId
    ) {
        self.accountId = accountId
        self.actorId = actorId
    }
}

public struct ActionErrorKindOneOfDeleteKeyDoesNotExistInline: Codable {
    public let accountId: AccountId
    public let publicKey: PublicKey

    public init(
        accountId: AccountId,
        publicKey: PublicKey
    ) {
        self.accountId = accountId
        self.publicKey = publicKey
    }
}

public struct ActionErrorKindOneOfAddKeyAlreadyExistsInline: Codable {
    public let accountId: AccountId
    public let publicKey: PublicKey

    public init(
        accountId: AccountId,
        publicKey: PublicKey
    ) {
        self.accountId = accountId
        self.publicKey = publicKey
    }
}

public struct ActionErrorKindOneOfDeleteAccountStakingInline: Codable {
    public let accountId: AccountId

    public init(
        accountId: AccountId
    ) {
        self.accountId = accountId
    }
}

public struct ActionErrorKindOneOfLackBalanceForStateInline: Codable {
    public let accountId: AccountId
    public let amount: NearToken

    public init(
        accountId: AccountId,
        amount: NearToken
    ) {
        self.accountId = accountId
        self.amount = amount
    }
}

public struct ActionErrorKindOneOfTriesToUnstakeInline: Codable {
    public let accountId: AccountId

    public init(
        accountId: AccountId
    ) {
        self.accountId = accountId
    }
}

public struct ActionErrorKindOneOfTriesToStakeInline: Codable {
    public let accountId: AccountId
    public let balance: NearToken
    public let locked: NearToken
    public let stake: NearToken

    public init(
        accountId: AccountId,
        balance: NearToken,
        locked: NearToken,
        stake: NearToken
    ) {
        self.accountId = accountId
        self.balance = balance
        self.locked = locked
        self.stake = stake
    }
}

public struct ActionErrorKindOneOfInsufficientStakeInline: Codable {
    public let accountId: AccountId
    public let minimumStake: NearToken
    public let stake: NearToken

    public init(
        accountId: AccountId,
        minimumStake: NearToken,
        stake: NearToken
    ) {
        self.accountId = accountId
        self.minimumStake = minimumStake
        self.stake = stake
    }
}

public struct ActionErrorKindOneOfOnlyImplicitAccountCreationAllowedInline: Codable {
    public let accountId: AccountId

    public init(
        accountId: AccountId
    ) {
        self.accountId = accountId
    }
}

public struct ActionErrorKindOneOfDeleteAccountWithLargeStateInline: Codable {
    public let accountId: AccountId

    public init(
        accountId: AccountId
    ) {
        self.accountId = accountId
    }
}

public struct ActionErrorKindOneOfDelegateActionSenderDoesNotMatchTxReceiverInline: Codable {
    public let receiverId: AccountId
    public let senderId: AccountId

    public init(
        receiverId: AccountId,
        senderId: AccountId
    ) {
        self.receiverId = receiverId
        self.senderId = senderId
    }
}

public struct ActionErrorKindOneOfDelegateActionInvalidNonceInline: Codable {
    public let akNonce: UInt64
    public let delegateNonce: UInt64

    public init(
        akNonce: UInt64,
        delegateNonce: UInt64
    ) {
        self.akNonce = akNonce
        self.delegateNonce = delegateNonce
    }
}

public struct ActionErrorKindOneOfDelegateActionNonceTooLargeInline: Codable {
    public let delegateNonce: UInt64
    public let upperBound: UInt64

    public init(
        delegateNonce: UInt64,
        upperBound: UInt64
    ) {
        self.delegateNonce = delegateNonce
        self.upperBound = upperBound
    }
}

public struct ActionErrorKindOneOfGlobalContractDoesNotExistInline: Codable {
    public let identifier: GlobalContractIdentifier

    public init(
        identifier: GlobalContractIdentifier
    ) {
        self.identifier = identifier
    }
}

public enum ActionErrorKind: Codable {
    case accountAlreadyExists(ActionErrorKindOneOfAccountAlreadyExistsInline)
    case accountDoesNotExist(ActionErrorKindOneOfAccountDoesNotExistInline)
    case createAccountOnlyByRegistrar(ActionErrorKindOneOfCreateAccountOnlyByRegistrarInline)
    case createAccountNotAllowed(ActionErrorKindOneOfCreateAccountNotAllowedInline)
    case actorNoPermission(ActionErrorKindOneOfActorNoPermissionInline)
    case deleteKeyDoesNotExist(ActionErrorKindOneOfDeleteKeyDoesNotExistInline)
    case addKeyAlreadyExists(ActionErrorKindOneOfAddKeyAlreadyExistsInline)
    case deleteAccountStaking(ActionErrorKindOneOfDeleteAccountStakingInline)
    case lackBalanceForState(ActionErrorKindOneOfLackBalanceForStateInline)
    case triesToUnstake(ActionErrorKindOneOfTriesToUnstakeInline)
    case triesToStake(ActionErrorKindOneOfTriesToStakeInline)
    case insufficientStake(ActionErrorKindOneOfInsufficientStakeInline)
    case functionCallError(FunctionCallError)
    case newReceiptValidationError(ReceiptValidationError)
    case onlyImplicitAccountCreationAllowed(ActionErrorKindOneOfOnlyImplicitAccountCreationAllowedInline)
    case deleteAccountWithLargeState(ActionErrorKindOneOfDeleteAccountWithLargeStateInline)
    case delegateActionInvalidSignature
    case delegateActionSenderDoesNotMatchTxReceiver(ActionErrorKindOneOfDelegateActionSenderDoesNotMatchTxReceiverInline
    )
    case delegateActionExpired
    case delegateActionAccessKeyError(InvalidAccessKeyError)
    case delegateActionInvalidNonce(ActionErrorKindOneOfDelegateActionInvalidNonceInline)
    case delegateActionNonceTooLarge(ActionErrorKindOneOfDelegateActionNonceTooLargeInline)
    case globalContractDoesNotExist(ActionErrorKindOneOfGlobalContractDoesNotExistInline)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("AccountAlreadyExists") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfAccountAlreadyExistsInline.self,
                        forKey: matchingKey
                    )
                    self = .accountAlreadyExists(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".accountAlreadyExists: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("AccountDoesNotExist") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfAccountDoesNotExistInline.self,
                        forKey: matchingKey
                    )
                    self = .accountDoesNotExist(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".accountDoesNotExist: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("CreateAccountOnlyByRegistrar") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfCreateAccountOnlyByRegistrarInline.self,
                        forKey: matchingKey
                    )
                    self = .createAccountOnlyByRegistrar(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".createAccountOnlyByRegistrar: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("CreateAccountNotAllowed") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfCreateAccountNotAllowedInline.self,
                        forKey: matchingKey
                    )
                    self = .createAccountNotAllowed(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".createAccountNotAllowed: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("ActorNoPermission") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfActorNoPermissionInline.self,
                        forKey: matchingKey
                    )
                    self = .actorNoPermission(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".actorNoPermission: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("DeleteKeyDoesNotExist") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfDeleteKeyDoesNotExistInline.self,
                        forKey: matchingKey
                    )
                    self = .deleteKeyDoesNotExist(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deleteKeyDoesNotExist: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("AddKeyAlreadyExists") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfAddKeyAlreadyExistsInline.self,
                        forKey: matchingKey
                    )
                    self = .addKeyAlreadyExists(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".addKeyAlreadyExists: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("DeleteAccountStaking") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfDeleteAccountStakingInline.self,
                        forKey: matchingKey
                    )
                    self = .deleteAccountStaking(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deleteAccountStaking: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("LackBalanceForState") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfLackBalanceForStateInline.self,
                        forKey: matchingKey
                    )
                    self = .lackBalanceForState(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".lackBalanceForState: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("TriesToUnstake") == .orderedSame }) {
                    let value = try container.decode(ActionErrorKindOneOfTriesToUnstakeInline.self, forKey: matchingKey)
                    self = .triesToUnstake(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".triesToUnstake: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("TriesToStake") == .orderedSame }) {
                    let value = try container.decode(ActionErrorKindOneOfTriesToStakeInline.self, forKey: matchingKey)
                    self = .triesToStake(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".triesToStake: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("InsufficientStake") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfInsufficientStakeInline.self,
                        forKey: matchingKey
                    )
                    self = .insufficientStake(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".insufficientStake: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("FunctionCallError") == .orderedSame
                    }) {
                    let value = try container.decode(FunctionCallError.self, forKey: matchingKey)
                    self = .functionCallError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".functionCallError: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("NewReceiptValidationError") == .orderedSame
                    }) {
                    let value = try container.decode(ReceiptValidationError.self, forKey: matchingKey)
                    self = .newReceiptValidationError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".newReceiptValidationError: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("OnlyImplicitAccountCreationAllowed") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfOnlyImplicitAccountCreationAllowedInline.self,
                        forKey: matchingKey
                    )
                    self = .onlyImplicitAccountCreationAllowed(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".onlyImplicitAccountCreationAllowed: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("DeleteAccountWithLargeState") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfDeleteAccountWithLargeStateInline.self,
                        forKey: matchingKey
                    )
                    self = .deleteAccountWithLargeState(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deleteAccountWithLargeState: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self),
           value == "DelegateActionInvalidSignature" {
            self = .delegateActionInvalidSignature
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue
                            .caseInsensitiveCompare("DelegateActionSenderDoesNotMatchTxReceiver") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfDelegateActionSenderDoesNotMatchTxReceiverInline.self,
                        forKey: matchingKey
                    )
                    self = .delegateActionSenderDoesNotMatchTxReceiver(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".delegateActionSenderDoesNotMatchTxReceiver: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "DelegateActionExpired" {
            self = .delegateActionExpired
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("DelegateActionAccessKeyError") == .orderedSame
                    }) {
                    let value = try container.decode(InvalidAccessKeyError.self, forKey: matchingKey)
                    self = .delegateActionAccessKeyError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".delegateActionAccessKeyError: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("DelegateActionInvalidNonce") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfDelegateActionInvalidNonceInline.self,
                        forKey: matchingKey
                    )
                    self = .delegateActionInvalidNonce(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".delegateActionInvalidNonce: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("DelegateActionNonceTooLarge") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfDelegateActionNonceTooLargeInline.self,
                        forKey: matchingKey
                    )
                    self = .delegateActionNonceTooLarge(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".delegateActionNonceTooLarge: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("GlobalContractDoesNotExist") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionErrorKindOneOfGlobalContractDoesNotExistInline.self,
                        forKey: matchingKey
                    )
                    self = .globalContractDoesNotExist(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".globalContractDoesNotExist: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ActionErrorKind\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ActionErrorKind:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case accountAlreadyExists = "AccountAlreadyExists"
        case accountDoesNotExist = "AccountDoesNotExist"
        case createAccountOnlyByRegistrar = "CreateAccountOnlyByRegistrar"
        case createAccountNotAllowed = "CreateAccountNotAllowed"
        case actorNoPermission = "ActorNoPermission"
        case deleteKeyDoesNotExist = "DeleteKeyDoesNotExist"
        case addKeyAlreadyExists = "AddKeyAlreadyExists"
        case deleteAccountStaking = "DeleteAccountStaking"
        case lackBalanceForState = "LackBalanceForState"
        case triesToUnstake = "TriesToUnstake"
        case triesToStake = "TriesToStake"
        case insufficientStake = "InsufficientStake"
        case functionCallError = "FunctionCallError"
        case newReceiptValidationError = "NewReceiptValidationError"
        case onlyImplicitAccountCreationAllowed = "OnlyImplicitAccountCreationAllowed"
        case deleteAccountWithLargeState = "DeleteAccountWithLargeState"
        case delegateActionSenderDoesNotMatchTxReceiver = "DelegateActionSenderDoesNotMatchTxReceiver"
        case delegateActionAccessKeyError = "DelegateActionAccessKeyError"
        case delegateActionInvalidNonce = "DelegateActionInvalidNonce"
        case delegateActionNonceTooLarge = "DelegateActionNonceTooLarge"
        case globalContractDoesNotExist = "GlobalContractDoesNotExist"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .accountAlreadyExists(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .accountAlreadyExists)
        case let .accountDoesNotExist(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .accountDoesNotExist)
        case let .createAccountOnlyByRegistrar(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .createAccountOnlyByRegistrar)
        case let .createAccountNotAllowed(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .createAccountNotAllowed)
        case let .actorNoPermission(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .actorNoPermission)
        case let .deleteKeyDoesNotExist(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deleteKeyDoesNotExist)
        case let .addKeyAlreadyExists(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .addKeyAlreadyExists)
        case let .deleteAccountStaking(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deleteAccountStaking)
        case let .lackBalanceForState(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .lackBalanceForState)
        case let .triesToUnstake(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .triesToUnstake)
        case let .triesToStake(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .triesToStake)
        case let .insufficientStake(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .insufficientStake)
        case let .functionCallError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .functionCallError)
        case let .newReceiptValidationError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .newReceiptValidationError)
        case let .onlyImplicitAccountCreationAllowed(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .onlyImplicitAccountCreationAllowed)
        case let .deleteAccountWithLargeState(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deleteAccountWithLargeState)
        case let .delegateActionSenderDoesNotMatchTxReceiver(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .delegateActionSenderDoesNotMatchTxReceiver)
        case let .delegateActionAccessKeyError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .delegateActionAccessKeyError)
        case let .delegateActionInvalidNonce(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .delegateActionInvalidNonce)
        case let .delegateActionNonceTooLarge(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .delegateActionNonceTooLarge)
        case let .globalContractDoesNotExist(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .globalContractDoesNotExist)
        case .delegateActionInvalidSignature:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("DelegateActionInvalidSignature")
        case .delegateActionExpired:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("DelegateActionExpired")
        }
    }
}

// MARK: - ActionView

public struct ActionViewOneOfDeployContractInline: Codable {
    public let code: String

    public init(
        code: String
    ) {
        self.code = code
    }
}

public struct ActionViewOneOfFunctionCallInline: Codable {
    public let args: FunctionArgs
    public let deposit: NearToken
    public let gas: NearGas
    public let methodName: String

    public init(
        args: FunctionArgs,
        deposit: NearToken,
        gas: NearGas,
        methodName: String
    ) {
        self.args = args
        self.deposit = deposit
        self.gas = gas
        self.methodName = methodName
    }
}

public struct ActionViewOneOfTransferInline: Codable {
    public let deposit: NearToken

    public init(
        deposit: NearToken
    ) {
        self.deposit = deposit
    }
}

public struct ActionViewOneOfStakeInline: Codable {
    public let publicKey: PublicKey
    public let stake: NearToken

    public init(
        publicKey: PublicKey,
        stake: NearToken
    ) {
        self.publicKey = publicKey
        self.stake = stake
    }
}

public struct ActionViewOneOfAddKeyInline: Codable {
    public let accessKey: AccessKeyView
    public let publicKey: PublicKey

    public init(
        accessKey: AccessKeyView,
        publicKey: PublicKey
    ) {
        self.accessKey = accessKey
        self.publicKey = publicKey
    }
}

public struct ActionViewOneOfDeleteKeyInline: Codable {
    public let publicKey: PublicKey

    public init(
        publicKey: PublicKey
    ) {
        self.publicKey = publicKey
    }
}

public struct ActionViewOneOfDeleteAccountInline: Codable {
    public let beneficiaryId: AccountId

    public init(
        beneficiaryId: AccountId
    ) {
        self.beneficiaryId = beneficiaryId
    }
}

public struct ActionViewOneOfDelegateInline: Codable {
    public let delegateAction: DelegateAction
    public let signature: Signature

    public init(
        delegateAction: DelegateAction,
        signature: Signature
    ) {
        self.delegateAction = delegateAction
        self.signature = signature
    }
}

public struct ActionViewOneOfDeployGlobalContractInline: Codable {
    public let code: String

    public init(
        code: String
    ) {
        self.code = code
    }
}

public struct ActionViewOneOfDeployGlobalContractByAccountIdInline: Codable {
    public let code: String

    public init(
        code: String
    ) {
        self.code = code
    }
}

public struct ActionViewOneOfUseGlobalContractInline: Codable {
    public let codeHash: CryptoHash

    public init(
        codeHash: CryptoHash
    ) {
        self.codeHash = codeHash
    }
}

public struct ActionViewOneOfUseGlobalContractByAccountIdInline: Codable {
    public let accountId: AccountId

    public init(
        accountId: AccountId
    ) {
        self.accountId = accountId
    }
}

public struct ActionViewOneOfDeterministicStateInitInline: Codable {
    public let code: GlobalContractIdentifierView
    public let data: [String: String]
    public let deposit: NearToken

    public init(
        code: GlobalContractIdentifierView,
        data: [String: String],
        deposit: NearToken
    ) {
        self.code = code
        self.data = data
        self.deposit = deposit
    }
}

public enum ActionView: Codable {
    case createAccount
    case deployContract(ActionViewOneOfDeployContractInline)
    case functionCall(ActionViewOneOfFunctionCallInline)
    case transfer(ActionViewOneOfTransferInline)
    case stake(ActionViewOneOfStakeInline)
    case addKey(ActionViewOneOfAddKeyInline)
    case deleteKey(ActionViewOneOfDeleteKeyInline)
    case deleteAccount(ActionViewOneOfDeleteAccountInline)
    case delegate(ActionViewOneOfDelegateInline)
    case deployGlobalContract(ActionViewOneOfDeployGlobalContractInline)
    case deployGlobalContractByAccountId(ActionViewOneOfDeployGlobalContractByAccountIdInline)
    case useGlobalContract(ActionViewOneOfUseGlobalContractInline)
    case useGlobalContractByAccountId(ActionViewOneOfUseGlobalContractByAccountIdInline)
    case deterministicStateInit(ActionViewOneOfDeterministicStateInitInline)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "CreateAccount" {
            self = .createAccount
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("DeployContract") == .orderedSame }) {
                    let value = try container.decode(ActionViewOneOfDeployContractInline.self, forKey: matchingKey)
                    self = .deployContract(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deployContract: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("FunctionCall") == .orderedSame }) {
                    let value = try container.decode(ActionViewOneOfFunctionCallInline.self, forKey: matchingKey)
                    self = .functionCall(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".functionCall: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("Transfer") == .orderedSame }) {
                    let value = try container.decode(ActionViewOneOfTransferInline.self, forKey: matchingKey)
                    self = .transfer(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".transfer: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("Stake") == .orderedSame }) {
                    let value = try container.decode(ActionViewOneOfStakeInline.self, forKey: matchingKey)
                    self = .stake(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".stake: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("AddKey") == .orderedSame }) {
                    let value = try container.decode(ActionViewOneOfAddKeyInline.self, forKey: matchingKey)
                    self = .addKey(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".addKey: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("DeleteKey") == .orderedSame }) {
                    let value = try container.decode(ActionViewOneOfDeleteKeyInline.self, forKey: matchingKey)
                    self = .deleteKey(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deleteKey: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("DeleteAccount") == .orderedSame }) {
                    let value = try container.decode(ActionViewOneOfDeleteAccountInline.self, forKey: matchingKey)
                    self = .deleteAccount(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deleteAccount: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("Delegate") == .orderedSame }) {
                    let value = try container.decode(ActionViewOneOfDelegateInline.self, forKey: matchingKey)
                    self = .delegate(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".delegate: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("DeployGlobalContract") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionViewOneOfDeployGlobalContractInline.self,
                        forKey: matchingKey
                    )
                    self = .deployGlobalContract(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deployGlobalContract: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("DeployGlobalContractByAccountId") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionViewOneOfDeployGlobalContractByAccountIdInline.self,
                        forKey: matchingKey
                    )
                    self = .deployGlobalContractByAccountId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deployGlobalContractByAccountId: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("UseGlobalContract") == .orderedSame
                    }) {
                    let value = try container.decode(ActionViewOneOfUseGlobalContractInline.self, forKey: matchingKey)
                    self = .useGlobalContract(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".useGlobalContract: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("UseGlobalContractByAccountId") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionViewOneOfUseGlobalContractByAccountIdInline.self,
                        forKey: matchingKey
                    )
                    self = .useGlobalContractByAccountId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".useGlobalContractByAccountId: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("DeterministicStateInit") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionViewOneOfDeterministicStateInitInline.self,
                        forKey: matchingKey
                    )
                    self = .deterministicStateInit(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deterministicStateInit: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ActionView\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ActionView:\n" + decodingErrors
                .joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case deployContract = "DeployContract"
        case functionCall = "FunctionCall"
        case transfer = "Transfer"
        case stake = "Stake"
        case addKey = "AddKey"
        case deleteKey = "DeleteKey"
        case deleteAccount = "DeleteAccount"
        case delegate = "Delegate"
        case deployGlobalContract = "DeployGlobalContract"
        case deployGlobalContractByAccountId = "DeployGlobalContractByAccountId"
        case useGlobalContract = "UseGlobalContract"
        case useGlobalContractByAccountId = "UseGlobalContractByAccountId"
        case deterministicStateInit = "DeterministicStateInit"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .deployContract(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deployContract)
        case let .functionCall(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .functionCall)
        case let .transfer(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .transfer)
        case let .stake(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .stake)
        case let .addKey(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .addKey)
        case let .deleteKey(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deleteKey)
        case let .deleteAccount(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deleteAccount)
        case let .delegate(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .delegate)
        case let .deployGlobalContract(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deployGlobalContract)
        case let .deployGlobalContractByAccountId(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deployGlobalContractByAccountId)
        case let .useGlobalContract(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .useGlobalContract)
        case let .useGlobalContractByAccountId(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .useGlobalContractByAccountId)
        case let .deterministicStateInit(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deterministicStateInit)
        case .createAccount:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("CreateAccount")
        }
    }
}

// MARK: - ActionsValidationError

public struct ActionsValidationErrorOneOfTotalPrepaidGasExceededInline: Codable {
    public let limit: NearGas
    public let totalPrepaidGas: NearGas

    public init(
        limit: NearGas,
        totalPrepaidGas: NearGas
    ) {
        self.limit = limit
        self.totalPrepaidGas = totalPrepaidGas
    }
}

public struct ActionsValidationErrorOneOfTotalNumberOfActionsExceededInline: Codable {
    public let limit: UInt64
    public let totalNumberOfActions: UInt64

    public init(
        limit: UInt64,
        totalNumberOfActions: UInt64
    ) {
        self.limit = limit
        self.totalNumberOfActions = totalNumberOfActions
    }
}

public struct ActionsValidationErrorOneOfAddKeyMethodNamesNumberOfBytesExceededInline: Codable {
    public let limit: UInt64
    public let totalNumberOfBytes: UInt64

    public init(
        limit: UInt64,
        totalNumberOfBytes: UInt64
    ) {
        self.limit = limit
        self.totalNumberOfBytes = totalNumberOfBytes
    }
}

public struct ActionsValidationErrorOneOfAddKeyMethodNameLengthExceededInline: Codable {
    public let length: UInt64
    public let limit: UInt64

    public init(
        length: UInt64,
        limit: UInt64
    ) {
        self.length = length
        self.limit = limit
    }
}

public struct ActionsValidationErrorOneOfInvalidAccountIdInline: Codable {
    public let accountId: String

    public init(
        accountId: String
    ) {
        self.accountId = accountId
    }
}

public struct ActionsValidationErrorOneOfContractSizeExceededInline: Codable {
    public let limit: UInt64
    public let size: UInt64

    public init(
        limit: UInt64,
        size: UInt64
    ) {
        self.limit = limit
        self.size = size
    }
}

public struct ActionsValidationErrorOneOfFunctionCallMethodNameLengthExceededInline: Codable {
    public let length: UInt64
    public let limit: UInt64

    public init(
        length: UInt64,
        limit: UInt64
    ) {
        self.length = length
        self.limit = limit
    }
}

public struct ActionsValidationErrorOneOfFunctionCallArgumentsLengthExceededInline: Codable {
    public let length: UInt64
    public let limit: UInt64

    public init(
        length: UInt64,
        limit: UInt64
    ) {
        self.length = length
        self.limit = limit
    }
}

public struct ActionsValidationErrorOneOfUnsuitableStakingKeyInline: Codable {
    public let publicKey: PublicKey

    public init(
        publicKey: PublicKey
    ) {
        self.publicKey = publicKey
    }
}

public struct ActionsValidationErrorOneOfUnsupportedProtocolFeatureInline: Codable {
    public let protocolFeature: String
    public let version: Int

    public init(
        protocolFeature: String,
        version: Int
    ) {
        self.protocolFeature = protocolFeature
        self.version = version
    }
}

public struct ActionsValidationErrorOneOfInvalidDeterministicStateInitReceiverInline: Codable {
    public let derivedId: AccountId
    public let receiverId: AccountId

    public init(
        derivedId: AccountId,
        receiverId: AccountId
    ) {
        self.derivedId = derivedId
        self.receiverId = receiverId
    }
}

public struct ActionsValidationErrorOneOfDeterministicStateInitKeyLengthExceededInline: Codable {
    public let length: UInt64
    public let limit: UInt64

    public init(
        length: UInt64,
        limit: UInt64
    ) {
        self.length = length
        self.limit = limit
    }
}

public struct ActionsValidationErrorOneOfDeterministicStateInitValueLengthExceededInline: Codable {
    public let length: UInt64
    public let limit: UInt64

    public init(
        length: UInt64,
        limit: UInt64
    ) {
        self.length = length
        self.limit = limit
    }
}

public enum ActionsValidationError: Codable {
    case deleteActionMustBeFinal
    case totalPrepaidGasExceeded(ActionsValidationErrorOneOfTotalPrepaidGasExceededInline)
    case totalNumberOfActionsExceeded(ActionsValidationErrorOneOfTotalNumberOfActionsExceededInline)
    case addKeyMethodNamesNumberOfBytesExceeded(ActionsValidationErrorOneOfAddKeyMethodNamesNumberOfBytesExceededInline)
    case addKeyMethodNameLengthExceeded(ActionsValidationErrorOneOfAddKeyMethodNameLengthExceededInline)
    case integerOverflow
    case invalidAccountId(ActionsValidationErrorOneOfInvalidAccountIdInline)
    case contractSizeExceeded(ActionsValidationErrorOneOfContractSizeExceededInline)
    case functionCallMethodNameLengthExceeded(ActionsValidationErrorOneOfFunctionCallMethodNameLengthExceededInline)
    case functionCallArgumentsLengthExceeded(ActionsValidationErrorOneOfFunctionCallArgumentsLengthExceededInline)
    case unsuitableStakingKey(ActionsValidationErrorOneOfUnsuitableStakingKeyInline)
    case functionCallZeroAttachedGas
    case delegateActionMustBeOnlyOne
    case unsupportedProtocolFeature(ActionsValidationErrorOneOfUnsupportedProtocolFeatureInline)
    case invalidDeterministicStateInitReceiver(ActionsValidationErrorOneOfInvalidDeterministicStateInitReceiverInline)
    case deterministicStateInitKeyLengthExceeded(
        ActionsValidationErrorOneOfDeterministicStateInitKeyLengthExceededInline
    )
    case deterministicStateInitValueLengthExceeded(
        ActionsValidationErrorOneOfDeterministicStateInitValueLengthExceededInline
    )

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "DeleteActionMustBeFinal" {
            self = .deleteActionMustBeFinal
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("TotalPrepaidGasExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionsValidationErrorOneOfTotalPrepaidGasExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .totalPrepaidGasExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".totalPrepaidGasExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("TotalNumberOfActionsExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionsValidationErrorOneOfTotalNumberOfActionsExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .totalNumberOfActionsExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".totalNumberOfActionsExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("AddKeyMethodNamesNumberOfBytesExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionsValidationErrorOneOfAddKeyMethodNamesNumberOfBytesExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .addKeyMethodNamesNumberOfBytesExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".addKeyMethodNamesNumberOfBytesExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("AddKeyMethodNameLengthExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionsValidationErrorOneOfAddKeyMethodNameLengthExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .addKeyMethodNameLengthExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".addKeyMethodNameLengthExceeded: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "IntegerOverflow" {
            self = .integerOverflow
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("InvalidAccountId") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionsValidationErrorOneOfInvalidAccountIdInline.self,
                        forKey: matchingKey
                    )
                    self = .invalidAccountId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidAccountId: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("ContractSizeExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionsValidationErrorOneOfContractSizeExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .contractSizeExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".contractSizeExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("FunctionCallMethodNameLengthExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionsValidationErrorOneOfFunctionCallMethodNameLengthExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .functionCallMethodNameLengthExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".functionCallMethodNameLengthExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("FunctionCallArgumentsLengthExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionsValidationErrorOneOfFunctionCallArgumentsLengthExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .functionCallArgumentsLengthExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".functionCallArgumentsLengthExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("UnsuitableStakingKey") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionsValidationErrorOneOfUnsuitableStakingKeyInline.self,
                        forKey: matchingKey
                    )
                    self = .unsuitableStakingKey(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".unsuitableStakingKey: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "FunctionCallZeroAttachedGas" {
            self = .functionCallZeroAttachedGas
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "DelegateActionMustBeOnlyOne" {
            self = .delegateActionMustBeOnlyOne
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("UnsupportedProtocolFeature") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionsValidationErrorOneOfUnsupportedProtocolFeatureInline.self,
                        forKey: matchingKey
                    )
                    self = .unsupportedProtocolFeature(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".unsupportedProtocolFeature: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("InvalidDeterministicStateInitReceiver") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionsValidationErrorOneOfInvalidDeterministicStateInitReceiverInline.self,
                        forKey: matchingKey
                    )
                    self = .invalidDeterministicStateInitReceiver(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidDeterministicStateInitReceiver: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue
                            .caseInsensitiveCompare("DeterministicStateInitKeyLengthExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionsValidationErrorOneOfDeterministicStateInitKeyLengthExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .deterministicStateInitKeyLengthExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deterministicStateInitKeyLengthExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue
                            .caseInsensitiveCompare("DeterministicStateInitValueLengthExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ActionsValidationErrorOneOfDeterministicStateInitValueLengthExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .deterministicStateInitValueLengthExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deterministicStateInitValueLengthExceeded: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ActionsValidationError\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ActionsValidationError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case totalPrepaidGasExceeded = "TotalPrepaidGasExceeded"
        case totalNumberOfActionsExceeded = "TotalNumberOfActionsExceeded"
        case addKeyMethodNamesNumberOfBytesExceeded = "AddKeyMethodNamesNumberOfBytesExceeded"
        case addKeyMethodNameLengthExceeded = "AddKeyMethodNameLengthExceeded"
        case invalidAccountId = "InvalidAccountId"
        case contractSizeExceeded = "ContractSizeExceeded"
        case functionCallMethodNameLengthExceeded = "FunctionCallMethodNameLengthExceeded"
        case functionCallArgumentsLengthExceeded = "FunctionCallArgumentsLengthExceeded"
        case unsuitableStakingKey = "UnsuitableStakingKey"
        case unsupportedProtocolFeature = "UnsupportedProtocolFeature"
        case invalidDeterministicStateInitReceiver = "InvalidDeterministicStateInitReceiver"
        case deterministicStateInitKeyLengthExceeded = "DeterministicStateInitKeyLengthExceeded"
        case deterministicStateInitValueLengthExceeded = "DeterministicStateInitValueLengthExceeded"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .totalPrepaidGasExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .totalPrepaidGasExceeded)
        case let .totalNumberOfActionsExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .totalNumberOfActionsExceeded)
        case let .addKeyMethodNamesNumberOfBytesExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .addKeyMethodNamesNumberOfBytesExceeded)
        case let .addKeyMethodNameLengthExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .addKeyMethodNameLengthExceeded)
        case let .invalidAccountId(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidAccountId)
        case let .contractSizeExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .contractSizeExceeded)
        case let .functionCallMethodNameLengthExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .functionCallMethodNameLengthExceeded)
        case let .functionCallArgumentsLengthExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .functionCallArgumentsLengthExceeded)
        case let .unsuitableStakingKey(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .unsuitableStakingKey)
        case let .unsupportedProtocolFeature(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .unsupportedProtocolFeature)
        case let .invalidDeterministicStateInitReceiver(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidDeterministicStateInitReceiver)
        case let .deterministicStateInitKeyLengthExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deterministicStateInitKeyLengthExceeded)
        case let .deterministicStateInitValueLengthExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deterministicStateInitValueLengthExceeded)
        case .deleteActionMustBeFinal:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("DeleteActionMustBeFinal")
        case .integerOverflow:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("IntegerOverflow")
        case .functionCallZeroAttachedGas:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("FunctionCallZeroAttachedGas")
        case .delegateActionMustBeOnlyOne:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("DelegateActionMustBeOnlyOne")
        }
    }
}

// MARK: - BandwidthRequests

public enum BandwidthRequests: Codable {
    case v1(BandwidthRequestsV1)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("V1") == .orderedSame }) {
                    let value = try container.decode(BandwidthRequestsV1.self, forKey: matchingKey)
                    self = .v1(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".v1: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for BandwidthRequests\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for BandwidthRequests:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case v1 = "V1"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .v1(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .v1)
        }
    }
}

// MARK: - BlockId

public enum BlockId: Codable {
    case integer(UInt64)
    case cryptoHash(CryptoHash)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            let value = try decoder.singleValueContainer().decode(UInt64.self)
            self = .integer(value)
            return
        } catch {
            decodingErrors.append(".integer: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(CryptoHash.self)
            self = .cryptoHash(value)
            return
        } catch {
            decodingErrors.append(".cryptoHash: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for BlockId\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for BlockId:\n" + decodingErrors
                .joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .integer(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .cryptoHash(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
}

// MARK: - CompilationError

public struct CompilationErrorOneOfCodeDoesNotExistInline: Codable {
    public let accountId: AccountId

    public init(
        accountId: AccountId
    ) {
        self.accountId = accountId
    }
}

public struct CompilationErrorOneOfWasmerCompileErrorInline: Codable {
    public let msg: String

    public init(
        msg: String
    ) {
        self.msg = msg
    }
}

public enum CompilationError: Codable {
    case codeDoesNotExist(CompilationErrorOneOfCodeDoesNotExistInline)
    case prepareError(PrepareError)
    case wasmerCompileError(CompilationErrorOneOfWasmerCompileErrorInline)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("CodeDoesNotExist") == .orderedSame
                    }) {
                    let value = try container.decode(
                        CompilationErrorOneOfCodeDoesNotExistInline.self,
                        forKey: matchingKey
                    )
                    self = .codeDoesNotExist(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".codeDoesNotExist: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("PrepareError") == .orderedSame }) {
                    let value = try container.decode(PrepareError.self, forKey: matchingKey)
                    self = .prepareError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".prepareError: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("WasmerCompileError") == .orderedSame
                    }) {
                    let value = try container.decode(
                        CompilationErrorOneOfWasmerCompileErrorInline.self,
                        forKey: matchingKey
                    )
                    self = .wasmerCompileError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".wasmerCompileError: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for CompilationError\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for CompilationError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case codeDoesNotExist = "CodeDoesNotExist"
        case prepareError = "PrepareError"
        case wasmerCompileError = "WasmerCompileError"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .codeDoesNotExist(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .codeDoesNotExist)
        case let .prepareError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .prepareError)
        case let .wasmerCompileError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .wasmerCompileError)
        }
    }
}

// MARK: - DeterministicAccountStateInit

public enum DeterministicAccountStateInit: Codable {
    case v1(DeterministicAccountStateInitV1)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("V1") == .orderedSame }) {
                    let value = try container.decode(DeterministicAccountStateInitV1.self, forKey: matchingKey)
                    self = .v1(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".v1: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for DeterministicAccountStateInit\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for DeterministicAccountStateInit:\n" + decodingErrors
                    .joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case v1 = "V1"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .v1(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .v1)
        }
    }
}

// MARK: - ExecutionStatusView

public enum ExecutionStatusView: Codable {
    case unknown
    case failure(TxExecutionError)
    case successValue(String)
    case successReceiptId(CryptoHash)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "Unknown" {
            self = .unknown
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("Failure") == .orderedSame }) {
                    let value = try container.decode(TxExecutionError.self, forKey: matchingKey)
                    self = .failure(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".failure: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("SuccessValue") == .orderedSame }) {
                    let value = try container.decode(String.self, forKey: matchingKey)
                    self = .successValue(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".successValue: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("SuccessReceiptId") == .orderedSame
                    }) {
                    let value = try container.decode(CryptoHash.self, forKey: matchingKey)
                    self = .successReceiptId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".successReceiptId: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ExecutionStatusView\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ExecutionStatusView:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case failure = "Failure"
        case successValue = "SuccessValue"
        case successReceiptId = "SuccessReceiptId"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .failure(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .failure)
        case let .successValue(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .successValue)
        case let .successReceiptId(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .successReceiptId)
        case .unknown:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("Unknown")
        }
    }
}

// MARK: - ExternalStorageLocation

public struct ExternalStorageLocationOneOfS3Inline: Codable {
    public let bucket: String
    public let region: String

    public init(
        bucket: String,
        region: String
    ) {
        self.bucket = bucket
        self.region = region
    }
}

public struct ExternalStorageLocationOneOfFilesystemInline: Codable {
    public let rootDir: String

    public init(
        rootDir: String
    ) {
        self.rootDir = rootDir
    }
}

public struct ExternalStorageLocationOneOfGCSInline: Codable {
    public let bucket: String

    public init(
        bucket: String
    ) {
        self.bucket = bucket
    }
}

public enum ExternalStorageLocation: Codable {
    case s3(ExternalStorageLocationOneOfS3Inline)
    case filesystem(ExternalStorageLocationOneOfFilesystemInline)
    case gcs(ExternalStorageLocationOneOfGCSInline)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("S3") == .orderedSame }) {
                    let value = try container.decode(ExternalStorageLocationOneOfS3Inline.self, forKey: matchingKey)
                    self = .s3(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".s3: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("Filesystem") == .orderedSame }) {
                    let value = try container.decode(
                        ExternalStorageLocationOneOfFilesystemInline.self,
                        forKey: matchingKey
                    )
                    self = .filesystem(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".filesystem: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("GCS") == .orderedSame }) {
                    let value = try container.decode(ExternalStorageLocationOneOfGCSInline.self, forKey: matchingKey)
                    self = .gcs(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".gcs: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ExternalStorageLocation\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ExternalStorageLocation:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case s3 = "S3"
        case filesystem = "Filesystem"
        case gcs = "GCS"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .s3(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .s3)
        case let .filesystem(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .filesystem)
        case let .gcs(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .gcs)
        }
    }
}

// MARK: - FinalExecutionStatus

public enum FinalExecutionStatus: Codable {
    case notStarted
    case started
    case failure(TxExecutionError)
    case successValue(String)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "NotStarted" {
            self = .notStarted
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "Started" {
            self = .started
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("Failure") == .orderedSame }) {
                    let value = try container.decode(TxExecutionError.self, forKey: matchingKey)
                    self = .failure(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".failure: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("SuccessValue") == .orderedSame }) {
                    let value = try container.decode(String.self, forKey: matchingKey)
                    self = .successValue(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".successValue: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for FinalExecutionStatus\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for FinalExecutionStatus:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case failure = "Failure"
        case successValue = "SuccessValue"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .failure(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .failure)
        case let .successValue(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .successValue)
        case .notStarted:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("NotStarted")
        case .started:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("Started")
        }
    }
}

// MARK: - FunctionCallError

public struct FunctionCallErrorOneOfLinkErrorInline: Codable {
    public let msg: String

    public init(
        msg: String
    ) {
        self.msg = msg
    }
}

public enum FunctionCallError: Codable {
    case string(String)
    case compilationError(CompilationError)
    case linkError(FunctionCallErrorOneOfLinkErrorInline)
    case methodResolveError(MethodResolveError)
    case wasmTrap(WasmTrap)
    case hostError(HostError)
    case executionError(String)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            let value = try decoder.singleValueContainer().decode(String.self)
            self = .string(value)
            return
        } catch {
            decodingErrors.append(".string: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("CompilationError") == .orderedSame
                    }) {
                    let value = try container.decode(CompilationError.self, forKey: matchingKey)
                    self = .compilationError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".compilationError: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("LinkError") == .orderedSame }) {
                    let value = try container.decode(FunctionCallErrorOneOfLinkErrorInline.self, forKey: matchingKey)
                    self = .linkError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".linkError: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("MethodResolveError") == .orderedSame
                    }) {
                    let value = try container.decode(MethodResolveError.self, forKey: matchingKey)
                    self = .methodResolveError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".methodResolveError: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("WasmTrap") == .orderedSame }) {
                    let value = try container.decode(WasmTrap.self, forKey: matchingKey)
                    self = .wasmTrap(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".wasmTrap: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("HostError") == .orderedSame }) {
                    let value = try container.decode(HostError.self, forKey: matchingKey)
                    self = .hostError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".hostError: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("ExecutionError") == .orderedSame }) {
                    let value = try container.decode(String.self, forKey: matchingKey)
                    self = .executionError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".executionError: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for FunctionCallError\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for FunctionCallError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case compilationError = "CompilationError"
        case linkError = "LinkError"
        case methodResolveError = "MethodResolveError"
        case wasmTrap = "WasmTrap"
        case hostError = "HostError"
        case executionError = "ExecutionError"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .compilationError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .compilationError)
        case let .linkError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .linkError)
        case let .methodResolveError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .methodResolveError)
        case let .wasmTrap(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .wasmTrap)
        case let .hostError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .hostError)
        case let .executionError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .executionError)
        case let .string(value):
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode(value)
        }
    }
}

// MARK: - GlobalContractDeployMode

public enum GlobalContractDeployMode: Codable {
    case codeHash
    case accountId

    public init(from decoder: Decoder) throws {
        let decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "CodeHash" {
            self = .codeHash
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "AccountId" {
            self = .accountId
            return
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for GlobalContractDeployMode\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for GlobalContractDeployMode:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .codeHash:
            var container = encoder.singleValueContainer()
            try container.encode("CodeHash")
        case .accountId:
            var container = encoder.singleValueContainer()
            try container.encode("AccountId")
        }
    }
}

// MARK: - GlobalContractIdentifier

public enum GlobalContractIdentifier: Codable {
    case codeHash(CryptoHash)
    case accountId(AccountId)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("CodeHash") == .orderedSame }) {
                    let value = try container.decode(CryptoHash.self, forKey: matchingKey)
                    self = .codeHash(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".codeHash: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("AccountId") == .orderedSame }) {
                    let value = try container.decode(AccountId.self, forKey: matchingKey)
                    self = .accountId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".accountId: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for GlobalContractIdentifier\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for GlobalContractIdentifier:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case codeHash = "CodeHash"
        case accountId = "AccountId"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .codeHash(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .codeHash)
        case let .accountId(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .accountId)
        }
    }
}

// MARK: - GlobalContractIdentifierView

public enum GlobalContractIdentifierView: Codable {
    case cryptoHash(CryptoHash)
    case accountId(AccountId)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            let value = try decoder.singleValueContainer().decode(CryptoHash.self)
            self = .cryptoHash(value)
            return
        } catch {
            decodingErrors.append(".cryptoHash: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(AccountId.self)
            self = .accountId(value)
            return
        } catch {
            decodingErrors.append(".accountId: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for GlobalContractIdentifierView\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for GlobalContractIdentifierView:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .cryptoHash(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .accountId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
}

// MARK: - HostError

public struct HostErrorOneOfGuestPanicInline: Codable {
    public let panicMsg: String

    public init(
        panicMsg: String
    ) {
        self.panicMsg = panicMsg
    }
}

public struct HostErrorOneOfInvalidPromiseIndexInline: Codable {
    public let promiseIdx: UInt64

    public init(
        promiseIdx: UInt64
    ) {
        self.promiseIdx = promiseIdx
    }
}

public struct HostErrorOneOfInvalidPromiseResultIndexInline: Codable {
    public let resultIdx: UInt64

    public init(
        resultIdx: UInt64
    ) {
        self.resultIdx = resultIdx
    }
}

public struct HostErrorOneOfInvalidRegisterIdInline: Codable {
    public let registerId: UInt64

    public init(
        registerId: UInt64
    ) {
        self.registerId = registerId
    }
}

public struct HostErrorOneOfIteratorWasInvalidatedInline: Codable {
    public let iteratorIndex: UInt64

    public init(
        iteratorIndex: UInt64
    ) {
        self.iteratorIndex = iteratorIndex
    }
}

public struct HostErrorOneOfInvalidReceiptIndexInline: Codable {
    public let receiptIndex: UInt64

    public init(
        receiptIndex: UInt64
    ) {
        self.receiptIndex = receiptIndex
    }
}

public struct HostErrorOneOfInvalidIteratorIndexInline: Codable {
    public let iteratorIndex: UInt64

    public init(
        iteratorIndex: UInt64
    ) {
        self.iteratorIndex = iteratorIndex
    }
}

public struct HostErrorOneOfProhibitedInViewInline: Codable {
    public let methodName: String

    public init(
        methodName: String
    ) {
        self.methodName = methodName
    }
}

public struct HostErrorOneOfNumberOfLogsExceededInline: Codable {
    public let limit: UInt64

    public init(
        limit: UInt64
    ) {
        self.limit = limit
    }
}

public struct HostErrorOneOfKeyLengthExceededInline: Codable {
    public let length: UInt64
    public let limit: UInt64

    public init(
        length: UInt64,
        limit: UInt64
    ) {
        self.length = length
        self.limit = limit
    }
}

public struct HostErrorOneOfValueLengthExceededInline: Codable {
    public let length: UInt64
    public let limit: UInt64

    public init(
        length: UInt64,
        limit: UInt64
    ) {
        self.length = length
        self.limit = limit
    }
}

public struct HostErrorOneOfTotalLogLengthExceededInline: Codable {
    public let length: UInt64
    public let limit: UInt64

    public init(
        length: UInt64,
        limit: UInt64
    ) {
        self.length = length
        self.limit = limit
    }
}

public struct HostErrorOneOfNumberPromisesExceededInline: Codable {
    public let limit: UInt64
    public let numberOfPromises: UInt64

    public init(
        limit: UInt64,
        numberOfPromises: UInt64
    ) {
        self.limit = limit
        self.numberOfPromises = numberOfPromises
    }
}

public struct HostErrorOneOfNumberInputDataDependenciesExceededInline: Codable {
    public let limit: UInt64
    public let numberOfInputDataDependencies: UInt64

    public init(
        limit: UInt64,
        numberOfInputDataDependencies: UInt64
    ) {
        self.limit = limit
        self.numberOfInputDataDependencies = numberOfInputDataDependencies
    }
}

public struct HostErrorOneOfReturnedValueLengthExceededInline: Codable {
    public let length: UInt64
    public let limit: UInt64

    public init(
        length: UInt64,
        limit: UInt64
    ) {
        self.length = length
        self.limit = limit
    }
}

public struct HostErrorOneOfContractSizeExceededInline: Codable {
    public let limit: UInt64
    public let size: UInt64

    public init(
        limit: UInt64,
        size: UInt64
    ) {
        self.limit = limit
        self.size = size
    }
}

public struct HostErrorOneOfDeprecatedInline: Codable {
    public let methodName: String

    public init(
        methodName: String
    ) {
        self.methodName = methodName
    }
}

public struct HostErrorOneOfECRecoverErrorInline: Codable {
    public let msg: String

    public init(
        msg: String
    ) {
        self.msg = msg
    }
}

public struct HostErrorOneOfAltBn128InvalidInputInline: Codable {
    public let msg: String

    public init(
        msg: String
    ) {
        self.msg = msg
    }
}

public struct HostErrorOneOfEd25519VerifyInvalidInputInline: Codable {
    public let msg: String

    public init(
        msg: String
    ) {
        self.msg = msg
    }
}

public enum HostError: Codable {
    case badUTF16
    case badUTF8
    case gasExceeded
    case gasLimitExceeded
    case balanceExceeded
    case emptyMethodName
    case guestPanic(HostErrorOneOfGuestPanicInline)
    case integerOverflow
    case invalidPromiseIndex(HostErrorOneOfInvalidPromiseIndexInline)
    case cannotAppendActionToJointPromise
    case cannotReturnJointPromise
    case invalidPromiseResultIndex(HostErrorOneOfInvalidPromiseResultIndexInline)
    case invalidRegisterId(HostErrorOneOfInvalidRegisterIdInline)
    case iteratorWasInvalidated(HostErrorOneOfIteratorWasInvalidatedInline)
    case memoryAccessViolation
    case invalidReceiptIndex(HostErrorOneOfInvalidReceiptIndexInline)
    case invalidIteratorIndex(HostErrorOneOfInvalidIteratorIndexInline)
    case invalidAccountId
    case invalidMethodName
    case invalidPublicKey
    case prohibitedInView(HostErrorOneOfProhibitedInViewInline)
    case numberOfLogsExceeded(HostErrorOneOfNumberOfLogsExceededInline)
    case keyLengthExceeded(HostErrorOneOfKeyLengthExceededInline)
    case valueLengthExceeded(HostErrorOneOfValueLengthExceededInline)
    case totalLogLengthExceeded(HostErrorOneOfTotalLogLengthExceededInline)
    case numberPromisesExceeded(HostErrorOneOfNumberPromisesExceededInline)
    case numberInputDataDependenciesExceeded(HostErrorOneOfNumberInputDataDependenciesExceededInline)
    case returnedValueLengthExceeded(HostErrorOneOfReturnedValueLengthExceededInline)
    case contractSizeExceeded(HostErrorOneOfContractSizeExceededInline)
    case deprecated(HostErrorOneOfDeprecatedInline)
    case eCRecoverError(HostErrorOneOfECRecoverErrorInline)
    case altBn128InvalidInput(HostErrorOneOfAltBn128InvalidInputInline)
    case ed25519VerifyInvalidInput(HostErrorOneOfEd25519VerifyInvalidInputInline)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "BadUTF16" {
            self = .badUTF16
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "BadUTF8" {
            self = .badUTF8
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "GasExceeded" {
            self = .gasExceeded
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "GasLimitExceeded" {
            self = .gasLimitExceeded
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "BalanceExceeded" {
            self = .balanceExceeded
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "EmptyMethodName" {
            self = .emptyMethodName
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("GuestPanic") == .orderedSame }) {
                    let value = try container.decode(HostErrorOneOfGuestPanicInline.self, forKey: matchingKey)
                    self = .guestPanic(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".guestPanic: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "IntegerOverflow" {
            self = .integerOverflow
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("InvalidPromiseIndex") == .orderedSame
                    }) {
                    let value = try container.decode(HostErrorOneOfInvalidPromiseIndexInline.self, forKey: matchingKey)
                    self = .invalidPromiseIndex(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidPromiseIndex: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self),
           value == "CannotAppendActionToJointPromise" {
            self = .cannotAppendActionToJointPromise
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "CannotReturnJointPromise" {
            self = .cannotReturnJointPromise
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("InvalidPromiseResultIndex") == .orderedSame
                    }) {
                    let value = try container.decode(
                        HostErrorOneOfInvalidPromiseResultIndexInline.self,
                        forKey: matchingKey
                    )
                    self = .invalidPromiseResultIndex(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidPromiseResultIndex: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("InvalidRegisterId") == .orderedSame
                    }) {
                    let value = try container.decode(HostErrorOneOfInvalidRegisterIdInline.self, forKey: matchingKey)
                    self = .invalidRegisterId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidRegisterId: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("IteratorWasInvalidated") == .orderedSame
                    }) {
                    let value = try container.decode(
                        HostErrorOneOfIteratorWasInvalidatedInline.self,
                        forKey: matchingKey
                    )
                    self = .iteratorWasInvalidated(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".iteratorWasInvalidated: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "MemoryAccessViolation" {
            self = .memoryAccessViolation
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("InvalidReceiptIndex") == .orderedSame
                    }) {
                    let value = try container.decode(HostErrorOneOfInvalidReceiptIndexInline.self, forKey: matchingKey)
                    self = .invalidReceiptIndex(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidReceiptIndex: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("InvalidIteratorIndex") == .orderedSame
                    }) {
                    let value = try container.decode(HostErrorOneOfInvalidIteratorIndexInline.self, forKey: matchingKey)
                    self = .invalidIteratorIndex(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidIteratorIndex: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "InvalidAccountId" {
            self = .invalidAccountId
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "InvalidMethodName" {
            self = .invalidMethodName
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "InvalidPublicKey" {
            self = .invalidPublicKey
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("ProhibitedInView") == .orderedSame
                    }) {
                    let value = try container.decode(HostErrorOneOfProhibitedInViewInline.self, forKey: matchingKey)
                    self = .prohibitedInView(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".prohibitedInView: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("NumberOfLogsExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(HostErrorOneOfNumberOfLogsExceededInline.self, forKey: matchingKey)
                    self = .numberOfLogsExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".numberOfLogsExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("KeyLengthExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(HostErrorOneOfKeyLengthExceededInline.self, forKey: matchingKey)
                    self = .keyLengthExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".keyLengthExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("ValueLengthExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(HostErrorOneOfValueLengthExceededInline.self, forKey: matchingKey)
                    self = .valueLengthExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".valueLengthExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("TotalLogLengthExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        HostErrorOneOfTotalLogLengthExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .totalLogLengthExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".totalLogLengthExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("NumberPromisesExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        HostErrorOneOfNumberPromisesExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .numberPromisesExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".numberPromisesExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("NumberInputDataDependenciesExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        HostErrorOneOfNumberInputDataDependenciesExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .numberInputDataDependenciesExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".numberInputDataDependenciesExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("ReturnedValueLengthExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        HostErrorOneOfReturnedValueLengthExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .returnedValueLengthExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".returnedValueLengthExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("ContractSizeExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(HostErrorOneOfContractSizeExceededInline.self, forKey: matchingKey)
                    self = .contractSizeExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".contractSizeExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("Deprecated") == .orderedSame }) {
                    let value = try container.decode(HostErrorOneOfDeprecatedInline.self, forKey: matchingKey)
                    self = .deprecated(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deprecated: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("ECRecoverError") == .orderedSame }) {
                    let value = try container.decode(HostErrorOneOfECRecoverErrorInline.self, forKey: matchingKey)
                    self = .eCRecoverError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".eCRecoverError: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("AltBn128InvalidInput") == .orderedSame
                    }) {
                    let value = try container.decode(HostErrorOneOfAltBn128InvalidInputInline.self, forKey: matchingKey)
                    self = .altBn128InvalidInput(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".altBn128InvalidInput: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("Ed25519VerifyInvalidInput") == .orderedSame
                    }) {
                    let value = try container.decode(
                        HostErrorOneOfEd25519VerifyInvalidInputInline.self,
                        forKey: matchingKey
                    )
                    self = .ed25519VerifyInvalidInput(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".ed25519VerifyInvalidInput: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for HostError\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for HostError:\n" + decodingErrors
                .joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case guestPanic = "GuestPanic"
        case invalidPromiseIndex = "InvalidPromiseIndex"
        case invalidPromiseResultIndex = "InvalidPromiseResultIndex"
        case invalidRegisterId = "InvalidRegisterId"
        case iteratorWasInvalidated = "IteratorWasInvalidated"
        case invalidReceiptIndex = "InvalidReceiptIndex"
        case invalidIteratorIndex = "InvalidIteratorIndex"
        case prohibitedInView = "ProhibitedInView"
        case numberOfLogsExceeded = "NumberOfLogsExceeded"
        case keyLengthExceeded = "KeyLengthExceeded"
        case valueLengthExceeded = "ValueLengthExceeded"
        case totalLogLengthExceeded = "TotalLogLengthExceeded"
        case numberPromisesExceeded = "NumberPromisesExceeded"
        case numberInputDataDependenciesExceeded = "NumberInputDataDependenciesExceeded"
        case returnedValueLengthExceeded = "ReturnedValueLengthExceeded"
        case contractSizeExceeded = "ContractSizeExceeded"
        case deprecated = "Deprecated"
        case eCRecoverError = "ECRecoverError"
        case altBn128InvalidInput = "AltBn128InvalidInput"
        case ed25519VerifyInvalidInput = "Ed25519VerifyInvalidInput"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .guestPanic(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .guestPanic)
        case let .invalidPromiseIndex(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidPromiseIndex)
        case let .invalidPromiseResultIndex(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidPromiseResultIndex)
        case let .invalidRegisterId(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidRegisterId)
        case let .iteratorWasInvalidated(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .iteratorWasInvalidated)
        case let .invalidReceiptIndex(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidReceiptIndex)
        case let .invalidIteratorIndex(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidIteratorIndex)
        case let .prohibitedInView(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .prohibitedInView)
        case let .numberOfLogsExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .numberOfLogsExceeded)
        case let .keyLengthExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .keyLengthExceeded)
        case let .valueLengthExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .valueLengthExceeded)
        case let .totalLogLengthExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .totalLogLengthExceeded)
        case let .numberPromisesExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .numberPromisesExceeded)
        case let .numberInputDataDependenciesExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .numberInputDataDependenciesExceeded)
        case let .returnedValueLengthExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .returnedValueLengthExceeded)
        case let .contractSizeExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .contractSizeExceeded)
        case let .deprecated(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deprecated)
        case let .eCRecoverError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .eCRecoverError)
        case let .altBn128InvalidInput(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .altBn128InvalidInput)
        case let .ed25519VerifyInvalidInput(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .ed25519VerifyInvalidInput)
        case .badUTF16:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("BadUTF16")
        case .badUTF8:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("BadUTF8")
        case .gasExceeded:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("GasExceeded")
        case .gasLimitExceeded:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("GasLimitExceeded")
        case .balanceExceeded:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("BalanceExceeded")
        case .emptyMethodName:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("EmptyMethodName")
        case .integerOverflow:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("IntegerOverflow")
        case .cannotAppendActionToJointPromise:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("CannotAppendActionToJointPromise")
        case .cannotReturnJointPromise:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("CannotReturnJointPromise")
        case .memoryAccessViolation:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("MemoryAccessViolation")
        case .invalidAccountId:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("InvalidAccountId")
        case .invalidMethodName:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("InvalidMethodName")
        case .invalidPublicKey:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("InvalidPublicKey")
        }
    }
}

// MARK: - InvalidAccessKeyError

public struct InvalidAccessKeyErrorOneOfAccessKeyNotFoundInline: Codable {
    public let accountId: AccountId
    public let publicKey: PublicKey

    public init(
        accountId: AccountId,
        publicKey: PublicKey
    ) {
        self.accountId = accountId
        self.publicKey = publicKey
    }
}

public struct InvalidAccessKeyErrorOneOfReceiverMismatchInline: Codable {
    public let akReceiver: String
    public let txReceiver: AccountId

    public init(
        akReceiver: String,
        txReceiver: AccountId
    ) {
        self.akReceiver = akReceiver
        self.txReceiver = txReceiver
    }
}

public struct InvalidAccessKeyErrorOneOfMethodNameMismatchInline: Codable {
    public let methodName: String

    public init(
        methodName: String
    ) {
        self.methodName = methodName
    }
}

public struct InvalidAccessKeyErrorOneOfNotEnoughAllowanceInline: Codable {
    public let accountId: AccountId
    public let allowance: NearToken
    public let cost: NearToken
    public let publicKey: PublicKey

    public init(
        accountId: AccountId,
        allowance: NearToken,
        cost: NearToken,
        publicKey: PublicKey
    ) {
        self.accountId = accountId
        self.allowance = allowance
        self.cost = cost
        self.publicKey = publicKey
    }
}

public enum InvalidAccessKeyError: Codable {
    case accessKeyNotFound(InvalidAccessKeyErrorOneOfAccessKeyNotFoundInline)
    case receiverMismatch(InvalidAccessKeyErrorOneOfReceiverMismatchInline)
    case methodNameMismatch(InvalidAccessKeyErrorOneOfMethodNameMismatchInline)
    case requiresFullAccess
    case notEnoughAllowance(InvalidAccessKeyErrorOneOfNotEnoughAllowanceInline)
    case depositWithFunctionCall

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("AccessKeyNotFound") == .orderedSame
                    }) {
                    let value = try container.decode(
                        InvalidAccessKeyErrorOneOfAccessKeyNotFoundInline.self,
                        forKey: matchingKey
                    )
                    self = .accessKeyNotFound(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".accessKeyNotFound: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("ReceiverMismatch") == .orderedSame
                    }) {
                    let value = try container.decode(
                        InvalidAccessKeyErrorOneOfReceiverMismatchInline.self,
                        forKey: matchingKey
                    )
                    self = .receiverMismatch(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".receiverMismatch: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("MethodNameMismatch") == .orderedSame
                    }) {
                    let value = try container.decode(
                        InvalidAccessKeyErrorOneOfMethodNameMismatchInline.self,
                        forKey: matchingKey
                    )
                    self = .methodNameMismatch(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".methodNameMismatch: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "RequiresFullAccess" {
            self = .requiresFullAccess
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("NotEnoughAllowance") == .orderedSame
                    }) {
                    let value = try container.decode(
                        InvalidAccessKeyErrorOneOfNotEnoughAllowanceInline.self,
                        forKey: matchingKey
                    )
                    self = .notEnoughAllowance(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".notEnoughAllowance: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "DepositWithFunctionCall" {
            self = .depositWithFunctionCall
            return
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for InvalidAccessKeyError\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for InvalidAccessKeyError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case accessKeyNotFound = "AccessKeyNotFound"
        case receiverMismatch = "ReceiverMismatch"
        case methodNameMismatch = "MethodNameMismatch"
        case notEnoughAllowance = "NotEnoughAllowance"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .accessKeyNotFound(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .accessKeyNotFound)
        case let .receiverMismatch(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .receiverMismatch)
        case let .methodNameMismatch(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .methodNameMismatch)
        case let .notEnoughAllowance(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .notEnoughAllowance)
        case .requiresFullAccess:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("RequiresFullAccess")
        case .depositWithFunctionCall:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("DepositWithFunctionCall")
        }
    }
}

// MARK: - InvalidTxError

public struct InvalidTxErrorOneOfInvalidSignerIdInline: Codable {
    public let signerId: String

    public init(
        signerId: String
    ) {
        self.signerId = signerId
    }
}

public struct InvalidTxErrorOneOfSignerDoesNotExistInline: Codable {
    public let signerId: AccountId

    public init(
        signerId: AccountId
    ) {
        self.signerId = signerId
    }
}

public struct InvalidTxErrorOneOfInvalidNonceInline: Codable {
    public let akNonce: UInt64
    public let txNonce: UInt64

    public init(
        akNonce: UInt64,
        txNonce: UInt64
    ) {
        self.akNonce = akNonce
        self.txNonce = txNonce
    }
}

public struct InvalidTxErrorOneOfNonceTooLargeInline: Codable {
    public let txNonce: UInt64
    public let upperBound: UInt64

    public init(
        txNonce: UInt64,
        upperBound: UInt64
    ) {
        self.txNonce = txNonce
        self.upperBound = upperBound
    }
}

public struct InvalidTxErrorOneOfInvalidReceiverIdInline: Codable {
    public let receiverId: String

    public init(
        receiverId: String
    ) {
        self.receiverId = receiverId
    }
}

public struct InvalidTxErrorOneOfNotEnoughBalanceInline: Codable {
    public let balance: NearToken
    public let cost: NearToken
    public let signerId: AccountId

    public init(
        balance: NearToken,
        cost: NearToken,
        signerId: AccountId
    ) {
        self.balance = balance
        self.cost = cost
        self.signerId = signerId
    }
}

public struct InvalidTxErrorOneOfLackBalanceForStateInline: Codable {
    public let amount: NearToken
    public let signerId: AccountId

    public init(
        amount: NearToken,
        signerId: AccountId
    ) {
        self.amount = amount
        self.signerId = signerId
    }
}

public struct InvalidTxErrorOneOfTransactionSizeExceededInline: Codable {
    public let limit: UInt64
    public let size: UInt64

    public init(
        limit: UInt64,
        size: UInt64
    ) {
        self.limit = limit
        self.size = size
    }
}

public struct InvalidTxErrorOneOfShardCongestedInline: Codable {
    public let congestionLevel: Double
    public let shardId: Int

    public init(
        congestionLevel: Double,
        shardId: Int
    ) {
        self.congestionLevel = congestionLevel
        self.shardId = shardId
    }
}

public struct InvalidTxErrorOneOfShardStuckInline: Codable {
    public let missedChunks: UInt64
    public let shardId: Int

    public init(
        missedChunks: UInt64,
        shardId: Int
    ) {
        self.missedChunks = missedChunks
        self.shardId = shardId
    }
}

public enum InvalidTxError: Codable {
    case invalidAccessKeyError(InvalidAccessKeyError)
    case invalidSignerId(InvalidTxErrorOneOfInvalidSignerIdInline)
    case signerDoesNotExist(InvalidTxErrorOneOfSignerDoesNotExistInline)
    case invalidNonce(InvalidTxErrorOneOfInvalidNonceInline)
    case nonceTooLarge(InvalidTxErrorOneOfNonceTooLargeInline)
    case invalidReceiverId(InvalidTxErrorOneOfInvalidReceiverIdInline)
    case invalidSignature
    case notEnoughBalance(InvalidTxErrorOneOfNotEnoughBalanceInline)
    case lackBalanceForState(InvalidTxErrorOneOfLackBalanceForStateInline)
    case costOverflow
    case invalidChain
    case expired
    case actionsValidation(ActionsValidationError)
    case transactionSizeExceeded(InvalidTxErrorOneOfTransactionSizeExceededInline)
    case invalidTransactionVersion
    case storageError(StorageError)
    case shardCongested(InvalidTxErrorOneOfShardCongestedInline)
    case shardStuck(InvalidTxErrorOneOfShardStuckInline)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("InvalidAccessKeyError") == .orderedSame
                    }) {
                    let value = try container.decode(InvalidAccessKeyError.self, forKey: matchingKey)
                    self = .invalidAccessKeyError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidAccessKeyError: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("InvalidSignerId") == .orderedSame
                    }) {
                    let value = try container.decode(InvalidTxErrorOneOfInvalidSignerIdInline.self, forKey: matchingKey)
                    self = .invalidSignerId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidSignerId: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("SignerDoesNotExist") == .orderedSame
                    }) {
                    let value = try container.decode(
                        InvalidTxErrorOneOfSignerDoesNotExistInline.self,
                        forKey: matchingKey
                    )
                    self = .signerDoesNotExist(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".signerDoesNotExist: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("InvalidNonce") == .orderedSame }) {
                    let value = try container.decode(InvalidTxErrorOneOfInvalidNonceInline.self, forKey: matchingKey)
                    self = .invalidNonce(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidNonce: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("NonceTooLarge") == .orderedSame }) {
                    let value = try container.decode(InvalidTxErrorOneOfNonceTooLargeInline.self, forKey: matchingKey)
                    self = .nonceTooLarge(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".nonceTooLarge: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("InvalidReceiverId") == .orderedSame
                    }) {
                    let value = try container.decode(
                        InvalidTxErrorOneOfInvalidReceiverIdInline.self,
                        forKey: matchingKey
                    )
                    self = .invalidReceiverId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidReceiverId: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "InvalidSignature" {
            self = .invalidSignature
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("NotEnoughBalance") == .orderedSame
                    }) {
                    let value = try container.decode(
                        InvalidTxErrorOneOfNotEnoughBalanceInline.self,
                        forKey: matchingKey
                    )
                    self = .notEnoughBalance(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".notEnoughBalance: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("LackBalanceForState") == .orderedSame
                    }) {
                    let value = try container.decode(
                        InvalidTxErrorOneOfLackBalanceForStateInline.self,
                        forKey: matchingKey
                    )
                    self = .lackBalanceForState(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".lackBalanceForState: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "CostOverflow" {
            self = .costOverflow
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "InvalidChain" {
            self = .invalidChain
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "Expired" {
            self = .expired
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("ActionsValidation") == .orderedSame
                    }) {
                    let value = try container.decode(ActionsValidationError.self, forKey: matchingKey)
                    self = .actionsValidation(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".actionsValidation: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("TransactionSizeExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        InvalidTxErrorOneOfTransactionSizeExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .transactionSizeExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".transactionSizeExceeded: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "InvalidTransactionVersion" {
            self = .invalidTransactionVersion
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("StorageError") == .orderedSame }) {
                    let value = try container.decode(StorageError.self, forKey: matchingKey)
                    self = .storageError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".storageError: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("ShardCongested") == .orderedSame }) {
                    let value = try container.decode(InvalidTxErrorOneOfShardCongestedInline.self, forKey: matchingKey)
                    self = .shardCongested(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".shardCongested: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("ShardStuck") == .orderedSame }) {
                    let value = try container.decode(InvalidTxErrorOneOfShardStuckInline.self, forKey: matchingKey)
                    self = .shardStuck(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".shardStuck: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for InvalidTxError\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for InvalidTxError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case invalidAccessKeyError = "InvalidAccessKeyError"
        case invalidSignerId = "InvalidSignerId"
        case signerDoesNotExist = "SignerDoesNotExist"
        case invalidNonce = "InvalidNonce"
        case nonceTooLarge = "NonceTooLarge"
        case invalidReceiverId = "InvalidReceiverId"
        case notEnoughBalance = "NotEnoughBalance"
        case lackBalanceForState = "LackBalanceForState"
        case actionsValidation = "ActionsValidation"
        case transactionSizeExceeded = "TransactionSizeExceeded"
        case storageError = "StorageError"
        case shardCongested = "ShardCongested"
        case shardStuck = "ShardStuck"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .invalidAccessKeyError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidAccessKeyError)
        case let .invalidSignerId(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidSignerId)
        case let .signerDoesNotExist(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .signerDoesNotExist)
        case let .invalidNonce(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidNonce)
        case let .nonceTooLarge(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .nonceTooLarge)
        case let .invalidReceiverId(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidReceiverId)
        case let .notEnoughBalance(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .notEnoughBalance)
        case let .lackBalanceForState(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .lackBalanceForState)
        case let .actionsValidation(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .actionsValidation)
        case let .transactionSizeExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .transactionSizeExceeded)
        case let .storageError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .storageError)
        case let .shardCongested(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .shardCongested)
        case let .shardStuck(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .shardStuck)
        case .invalidSignature:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("InvalidSignature")
        case .costOverflow:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("CostOverflow")
        case .invalidChain:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("InvalidChain")
        case .expired:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("Expired")
        case .invalidTransactionVersion:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("InvalidTransactionVersion")
        }
    }
}

// MARK: - JsonRpcResponseForArrayOfRangeOfUint64AndRpcError

public enum JsonRpcResponseForArrayOfRangeOfUint64AndRpcError: Codable {
    case result([RangeOfUint64])
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode([RangeOfUint64].self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForArrayOfRangeOfUint64AndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForArrayOfRangeOfUint64AndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError

public enum JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError: Codable {
    case result([ValidatorStakeView])
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode([ValidatorStakeView].self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForArrayOfValidatorStakeViewAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForCryptoHashAndRpcError

public enum JsonRpcResponseForCryptoHashAndRpcError: Codable {
    case result(CryptoHash)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(CryptoHash.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForCryptoHashAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForCryptoHashAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForGenesisConfigAndRpcError

public enum JsonRpcResponseForGenesisConfigAndRpcError: Codable {
    case result(GenesisConfig)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(GenesisConfig.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForGenesisConfigAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForGenesisConfigAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForNullableRpcHealthResponseAndRpcError

public enum JsonRpcResponseForNullableRpcHealthResponseAndRpcError: Codable {
    case result(RpcHealthResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcHealthResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForNullableRpcHealthResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForNullableRpcHealthResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcBlockResponseAndRpcError

public enum JsonRpcResponseForRpcBlockResponseAndRpcError: Codable {
    case result(RpcBlockResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcBlockResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcBlockResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcBlockResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcChunkResponseAndRpcError

public enum JsonRpcResponseForRpcChunkResponseAndRpcError: Codable {
    case result(RpcChunkResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcChunkResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcChunkResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcChunkResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcClientConfigResponseAndRpcError

public enum JsonRpcResponseForRpcClientConfigResponseAndRpcError: Codable {
    case result(RpcClientConfigResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcClientConfigResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcClientConfigResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcClientConfigResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcCongestionLevelResponseAndRpcError

public enum JsonRpcResponseForRpcCongestionLevelResponseAndRpcError: Codable {
    case result(RpcCongestionLevelResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcCongestionLevelResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcCongestionLevelResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcCongestionLevelResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcGasPriceResponseAndRpcError

public enum JsonRpcResponseForRpcGasPriceResponseAndRpcError: Codable {
    case result(RpcGasPriceResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcGasPriceResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcGasPriceResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcGasPriceResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError

public enum JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError: Codable {
    case result(RpcLightClientBlockProofResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcLightClientBlockProofResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError

public enum JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError: Codable {
    case result(RpcLightClientExecutionProofResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcLightClientExecutionProofResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError

public enum JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError: Codable {
    case result(RpcLightClientNextBlockResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcLightClientNextBlockResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcNetworkInfoResponseAndRpcError

public enum JsonRpcResponseForRpcNetworkInfoResponseAndRpcError: Codable {
    case result(RpcNetworkInfoResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcNetworkInfoResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcNetworkInfoResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcNetworkInfoResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcProtocolConfigResponseAndRpcError

public enum JsonRpcResponseForRpcProtocolConfigResponseAndRpcError: Codable {
    case result(RpcProtocolConfigResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcProtocolConfigResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcProtocolConfigResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcProtocolConfigResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcQueryResponseAndRpcError

public enum JsonRpcResponseForRpcQueryResponseAndRpcError: Codable {
    case result(RpcQueryResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcQueryResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcQueryResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcQueryResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcReceiptResponseAndRpcError

public enum JsonRpcResponseForRpcReceiptResponseAndRpcError: Codable {
    case result(RpcReceiptResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcReceiptResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcReceiptResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcReceiptResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError

public enum JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError: Codable {
    case result(RpcSplitStorageInfoResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcSplitStorageInfoResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError

public enum JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError: Codable {
    case result(RpcStateChangesInBlockByTypeResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcStateChangesInBlockByTypeResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError

public enum JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError: Codable {
    case result(RpcStateChangesInBlockResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcStateChangesInBlockResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcStatusResponseAndRpcError

public enum JsonRpcResponseForRpcStatusResponseAndRpcError: Codable {
    case result(RpcStatusResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcStatusResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcStatusResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcStatusResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcTransactionResponseAndRpcError

public enum JsonRpcResponseForRpcTransactionResponseAndRpcError: Codable {
    case result(RpcTransactionResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcTransactionResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcTransactionResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcTransactionResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - JsonRpcResponseForRpcValidatorResponseAndRpcError

public enum JsonRpcResponseForRpcValidatorResponseAndRpcError: Codable {
    case result(RpcValidatorResponse)
    case error(RpcError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("result") == .orderedSame }) {
                    let value = try container.decode(RpcValidatorResponse.self, forKey: matchingKey)
                    self = .result(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".result: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("error") == .orderedSame }) {
                    let value = try container.decode(RpcError.self, forKey: matchingKey)
                    self = .error(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".error: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcValidatorResponseAndRpcError\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for JsonRpcResponseForRpcValidatorResponseAndRpcError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case result
        case error
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .result(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .result)
        case let .error(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .error)
        }
    }
}

// MARK: - MissingTrieValueContext

public enum MissingTrieValueContext: Codable {
    case trieIterator
    case triePrefetchingStorage
    case trieMemoryPartialStorage
    case trieStorage

    public init(from decoder: Decoder) throws {
        let decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "TrieIterator" {
            self = .trieIterator
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "TriePrefetchingStorage" {
            self = .triePrefetchingStorage
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "TrieMemoryPartialStorage" {
            self = .trieMemoryPartialStorage
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "TrieStorage" {
            self = .trieStorage
            return
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for MissingTrieValueContext\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for MissingTrieValueContext:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .trieIterator:
            var container = encoder.singleValueContainer()
            try container.encode("TrieIterator")
        case .triePrefetchingStorage:
            var container = encoder.singleValueContainer()
            try container.encode("TriePrefetchingStorage")
        case .trieMemoryPartialStorage:
            var container = encoder.singleValueContainer()
            try container.encode("TrieMemoryPartialStorage")
        case .trieStorage:
            var container = encoder.singleValueContainer()
            try container.encode("TrieStorage")
        }
    }
}

// MARK: - NonDelegateAction

public enum NonDelegateAction: Codable {
    case createAccount(CreateAccountAction)
    case deployContract(DeployContractAction)
    case functionCall(FunctionCallAction)
    case transfer(TransferAction)
    case stake(StakeAction)
    case addKey(AddKeyAction)
    case deleteKey(DeleteKeyAction)
    case deleteAccount(DeleteAccountAction)
    case deployGlobalContract(DeployGlobalContractAction)
    case useGlobalContract(UseGlobalContractAction)
    case deterministicStateInit(DeterministicStateInitAction)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("CreateAccount") == .orderedSame }) {
                    let value = try container.decode(CreateAccountAction.self, forKey: matchingKey)
                    self = .createAccount(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".createAccount: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("DeployContract") == .orderedSame }) {
                    let value = try container.decode(DeployContractAction.self, forKey: matchingKey)
                    self = .deployContract(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deployContract: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("FunctionCall") == .orderedSame }) {
                    let value = try container.decode(FunctionCallAction.self, forKey: matchingKey)
                    self = .functionCall(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".functionCall: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("Transfer") == .orderedSame }) {
                    let value = try container.decode(TransferAction.self, forKey: matchingKey)
                    self = .transfer(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".transfer: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("Stake") == .orderedSame }) {
                    let value = try container.decode(StakeAction.self, forKey: matchingKey)
                    self = .stake(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".stake: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("AddKey") == .orderedSame }) {
                    let value = try container.decode(AddKeyAction.self, forKey: matchingKey)
                    self = .addKey(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".addKey: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("DeleteKey") == .orderedSame }) {
                    let value = try container.decode(DeleteKeyAction.self, forKey: matchingKey)
                    self = .deleteKey(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deleteKey: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("DeleteAccount") == .orderedSame }) {
                    let value = try container.decode(DeleteAccountAction.self, forKey: matchingKey)
                    self = .deleteAccount(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deleteAccount: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("DeployGlobalContract") == .orderedSame
                    }) {
                    let value = try container.decode(DeployGlobalContractAction.self, forKey: matchingKey)
                    self = .deployGlobalContract(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deployGlobalContract: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("UseGlobalContract") == .orderedSame
                    }) {
                    let value = try container.decode(UseGlobalContractAction.self, forKey: matchingKey)
                    self = .useGlobalContract(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".useGlobalContract: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("DeterministicStateInit") == .orderedSame
                    }) {
                    let value = try container.decode(DeterministicStateInitAction.self, forKey: matchingKey)
                    self = .deterministicStateInit(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".deterministicStateInit: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for NonDelegateAction\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for NonDelegateAction:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case createAccount = "CreateAccount"
        case deployContract = "DeployContract"
        case functionCall = "FunctionCall"
        case transfer = "Transfer"
        case stake = "Stake"
        case addKey = "AddKey"
        case deleteKey = "DeleteKey"
        case deleteAccount = "DeleteAccount"
        case deployGlobalContract = "DeployGlobalContract"
        case useGlobalContract = "UseGlobalContract"
        case deterministicStateInit = "DeterministicStateInit"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .createAccount(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .createAccount)
        case let .deployContract(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deployContract)
        case let .functionCall(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .functionCall)
        case let .transfer(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .transfer)
        case let .stake(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .stake)
        case let .addKey(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .addKey)
        case let .deleteKey(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deleteKey)
        case let .deleteAccount(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deleteAccount)
        case let .deployGlobalContract(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deployGlobalContract)
        case let .useGlobalContract(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .useGlobalContract)
        case let .deterministicStateInit(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .deterministicStateInit)
        }
    }
}

// MARK: - PrepareError

public enum PrepareError: Codable {
    case serialization
    case deserialization
    case internalMemoryDeclared
    case gasInstrumentation
    case stackHeightInstrumentation
    case instantiate
    case memory
    case tooManyFunctions
    case tooManyLocals
    case tooManyTables
    case tooManyTableElements

    public init(from decoder: Decoder) throws {
        let decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "Serialization" {
            self = .serialization
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "Deserialization" {
            self = .deserialization
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "InternalMemoryDeclared" {
            self = .internalMemoryDeclared
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "GasInstrumentation" {
            self = .gasInstrumentation
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "StackHeightInstrumentation" {
            self = .stackHeightInstrumentation
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "Instantiate" {
            self = .instantiate
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "Memory" {
            self = .memory
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "TooManyFunctions" {
            self = .tooManyFunctions
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "TooManyLocals" {
            self = .tooManyLocals
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "TooManyTables" {
            self = .tooManyTables
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "TooManyTableElements" {
            self = .tooManyTableElements
            return
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for PrepareError\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for PrepareError:\n" + decodingErrors
                .joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .serialization:
            var container = encoder.singleValueContainer()
            try container.encode("Serialization")
        case .deserialization:
            var container = encoder.singleValueContainer()
            try container.encode("Deserialization")
        case .internalMemoryDeclared:
            var container = encoder.singleValueContainer()
            try container.encode("InternalMemoryDeclared")
        case .gasInstrumentation:
            var container = encoder.singleValueContainer()
            try container.encode("GasInstrumentation")
        case .stackHeightInstrumentation:
            var container = encoder.singleValueContainer()
            try container.encode("StackHeightInstrumentation")
        case .instantiate:
            var container = encoder.singleValueContainer()
            try container.encode("Instantiate")
        case .memory:
            var container = encoder.singleValueContainer()
            try container.encode("Memory")
        case .tooManyFunctions:
            var container = encoder.singleValueContainer()
            try container.encode("TooManyFunctions")
        case .tooManyLocals:
            var container = encoder.singleValueContainer()
            try container.encode("TooManyLocals")
        case .tooManyTables:
            var container = encoder.singleValueContainer()
            try container.encode("TooManyTables")
        case .tooManyTableElements:
            var container = encoder.singleValueContainer()
            try container.encode("TooManyTableElements")
        }
    }
}

// MARK: - ReceiptEnumView

public struct ReceiptEnumViewOneOfActionInline: Codable {
    public let actions: [ActionView]
    public let gasPrice: NearToken
    public let inputDataIds: [CryptoHash]
    public let isPromiseYield: Bool?
    public let outputDataReceivers: [DataReceiverView]
    public let signerId: AccountId
    public let signerPublicKey: PublicKey

    public init(
        actions: [ActionView],
        gasPrice: NearToken,
        inputDataIds: [CryptoHash],
        isPromiseYield: Bool?,
        outputDataReceivers: [DataReceiverView],
        signerId: AccountId,
        signerPublicKey: PublicKey
    ) {
        self.actions = actions
        self.gasPrice = gasPrice
        self.inputDataIds = inputDataIds
        self.isPromiseYield = isPromiseYield
        self.outputDataReceivers = outputDataReceivers
        self.signerId = signerId
        self.signerPublicKey = signerPublicKey
    }
}

public struct ReceiptEnumViewOneOfDataInline: Codable {
    public let data: String?
    public let dataId: CryptoHash
    public let isPromiseResume: Bool?

    public init(
        data: String?,
        dataId: CryptoHash,
        isPromiseResume: Bool?
    ) {
        self.data = data
        self.dataId = dataId
        self.isPromiseResume = isPromiseResume
    }
}

public struct ReceiptEnumViewOneOfGlobalContractDistributionInline: Codable {
    public let alreadyDeliveredShards: [ShardId]
    public let code: String
    public let id: GlobalContractIdentifier
    public let targetShard: ShardId

    public init(
        alreadyDeliveredShards: [ShardId],
        code: String,
        id: GlobalContractIdentifier,
        targetShard: ShardId
    ) {
        self.alreadyDeliveredShards = alreadyDeliveredShards
        self.code = code
        self.id = id
        self.targetShard = targetShard
    }
}

public enum ReceiptEnumView: Codable {
    case action(ReceiptEnumViewOneOfActionInline)
    case data(ReceiptEnumViewOneOfDataInline)
    case globalContractDistribution(ReceiptEnumViewOneOfGlobalContractDistributionInline)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("Action") == .orderedSame }) {
                    let value = try container.decode(ReceiptEnumViewOneOfActionInline.self, forKey: matchingKey)
                    self = .action(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".action: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("Data") == .orderedSame }) {
                    let value = try container.decode(ReceiptEnumViewOneOfDataInline.self, forKey: matchingKey)
                    self = .data(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".data: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("GlobalContractDistribution") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ReceiptEnumViewOneOfGlobalContractDistributionInline.self,
                        forKey: matchingKey
                    )
                    self = .globalContractDistribution(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".globalContractDistribution: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ReceiptEnumView\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ReceiptEnumView:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case action = "Action"
        case data = "Data"
        case globalContractDistribution = "GlobalContractDistribution"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .action(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .action)
        case let .data(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .data)
        case let .globalContractDistribution(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .globalContractDistribution)
        }
    }
}

// MARK: - ReceiptValidationError

public struct ReceiptValidationErrorOneOfInvalidPredecessorIdInline: Codable {
    public let accountId: String

    public init(
        accountId: String
    ) {
        self.accountId = accountId
    }
}

public struct ReceiptValidationErrorOneOfInvalidReceiverIdInline: Codable {
    public let accountId: String

    public init(
        accountId: String
    ) {
        self.accountId = accountId
    }
}

public struct ReceiptValidationErrorOneOfInvalidSignerIdInline: Codable {
    public let accountId: String

    public init(
        accountId: String
    ) {
        self.accountId = accountId
    }
}

public struct ReceiptValidationErrorOneOfInvalidDataReceiverIdInline: Codable {
    public let accountId: String

    public init(
        accountId: String
    ) {
        self.accountId = accountId
    }
}

public struct ReceiptValidationErrorOneOfReturnedValueLengthExceededInline: Codable {
    public let length: UInt64
    public let limit: UInt64

    public init(
        length: UInt64,
        limit: UInt64
    ) {
        self.length = length
        self.limit = limit
    }
}

public struct ReceiptValidationErrorOneOfNumberInputDataDependenciesExceededInline: Codable {
    public let limit: UInt64
    public let numberOfInputDataDependencies: UInt64

    public init(
        limit: UInt64,
        numberOfInputDataDependencies: UInt64
    ) {
        self.limit = limit
        self.numberOfInputDataDependencies = numberOfInputDataDependencies
    }
}

public struct ReceiptValidationErrorOneOfReceiptSizeExceededInline: Codable {
    public let limit: UInt64
    public let size: UInt64

    public init(
        limit: UInt64,
        size: UInt64
    ) {
        self.limit = limit
        self.size = size
    }
}

public enum ReceiptValidationError: Codable {
    case invalidPredecessorId(ReceiptValidationErrorOneOfInvalidPredecessorIdInline)
    case invalidReceiverId(ReceiptValidationErrorOneOfInvalidReceiverIdInline)
    case invalidSignerId(ReceiptValidationErrorOneOfInvalidSignerIdInline)
    case invalidDataReceiverId(ReceiptValidationErrorOneOfInvalidDataReceiverIdInline)
    case returnedValueLengthExceeded(ReceiptValidationErrorOneOfReturnedValueLengthExceededInline)
    case numberInputDataDependenciesExceeded(ReceiptValidationErrorOneOfNumberInputDataDependenciesExceededInline)
    case actionsValidation(ActionsValidationError)
    case receiptSizeExceeded(ReceiptValidationErrorOneOfReceiptSizeExceededInline)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("InvalidPredecessorId") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ReceiptValidationErrorOneOfInvalidPredecessorIdInline.self,
                        forKey: matchingKey
                    )
                    self = .invalidPredecessorId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidPredecessorId: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("InvalidReceiverId") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ReceiptValidationErrorOneOfInvalidReceiverIdInline.self,
                        forKey: matchingKey
                    )
                    self = .invalidReceiverId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidReceiverId: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("InvalidSignerId") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ReceiptValidationErrorOneOfInvalidSignerIdInline.self,
                        forKey: matchingKey
                    )
                    self = .invalidSignerId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidSignerId: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("InvalidDataReceiverId") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ReceiptValidationErrorOneOfInvalidDataReceiverIdInline.self,
                        forKey: matchingKey
                    )
                    self = .invalidDataReceiverId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidDataReceiverId: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("ReturnedValueLengthExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ReceiptValidationErrorOneOfReturnedValueLengthExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .returnedValueLengthExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".returnedValueLengthExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("NumberInputDataDependenciesExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ReceiptValidationErrorOneOfNumberInputDataDependenciesExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .numberInputDataDependenciesExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".numberInputDataDependenciesExceeded: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("ActionsValidation") == .orderedSame
                    }) {
                    let value = try container.decode(ActionsValidationError.self, forKey: matchingKey)
                    self = .actionsValidation(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".actionsValidation: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("ReceiptSizeExceeded") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ReceiptValidationErrorOneOfReceiptSizeExceededInline.self,
                        forKey: matchingKey
                    )
                    self = .receiptSizeExceeded(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".receiptSizeExceeded: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ReceiptValidationError\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ReceiptValidationError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case invalidPredecessorId = "InvalidPredecessorId"
        case invalidReceiverId = "InvalidReceiverId"
        case invalidSignerId = "InvalidSignerId"
        case invalidDataReceiverId = "InvalidDataReceiverId"
        case returnedValueLengthExceeded = "ReturnedValueLengthExceeded"
        case numberInputDataDependenciesExceeded = "NumberInputDataDependenciesExceeded"
        case actionsValidation = "ActionsValidation"
        case receiptSizeExceeded = "ReceiptSizeExceeded"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .invalidPredecessorId(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidPredecessorId)
        case let .invalidReceiverId(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidReceiverId)
        case let .invalidSignerId(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidSignerId)
        case let .invalidDataReceiverId(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidDataReceiverId)
        case let .returnedValueLengthExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .returnedValueLengthExceeded)
        case let .numberInputDataDependenciesExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .numberInputDataDependenciesExceeded)
        case let .actionsValidation(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .actionsValidation)
        case let .receiptSizeExceeded(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .receiptSizeExceeded)
        }
    }
}

// MARK: - RpcBlockRequest

public enum RpcBlockRequest: Codable {
    case blockId(BlockId)
    case finality(Finality)
    case syncCheckpoint(SyncCheckpoint)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("block_id") == .orderedSame || key.stringValue
                            .caseInsensitiveCompare("blockId") == .orderedSame
                    }) {
                    let value = try container.decode(BlockId.self, forKey: matchingKey)
                    self = .blockId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".blockId: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("finality") == .orderedSame }) {
                    let value = try container.decode(Finality.self, forKey: matchingKey)
                    self = .finality(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".finality: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("sync_checkpoint") == .orderedSame || key.stringValue
                            .caseInsensitiveCompare("syncCheckpoint") == .orderedSame
                    }) {
                    let value = try container.decode(SyncCheckpoint.self, forKey: matchingKey)
                    self = .syncCheckpoint(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".syncCheckpoint: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcBlockRequest\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcBlockRequest:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case finality
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .blockId(value):
            var container = encoder.container(keyedBy: AnyCodingKey.self)
            try container.encode(value, forKey: AnyCodingKey(stringValue: "block_id"))
        case let .finality(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .finality)
        case let .syncCheckpoint(value):
            var container = encoder.container(keyedBy: AnyCodingKey.self)
            try container.encode(value, forKey: AnyCodingKey(stringValue: "sync_checkpoint"))
        }
    }
}

// MARK: - RpcChunkRequest

public struct BlockShardId: Codable {
    public let blockId: BlockId
    public let shardId: ShardId

    public init(
        blockId: BlockId,
        shardId: ShardId
    ) {
        self.blockId = blockId
        self.shardId = shardId
    }
}

public enum RpcChunkRequest: Codable {
    case blockShardId(BlockShardId)
    case chunkId(CryptoHash)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            let value = try decoder.singleValueContainer().decode(BlockShardId.self)
            self = .blockShardId(value)
            return
        } catch {
            decodingErrors.append(".blockShardId: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("chunk_id") == .orderedSame || key.stringValue
                            .caseInsensitiveCompare("chunkId") == .orderedSame
                    }) {
                    let value = try container.decode(CryptoHash.self, forKey: matchingKey)
                    self = .chunkId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".chunkId: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcChunkRequest\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcChunkRequest:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .chunkId(value):
            var container = encoder.container(keyedBy: AnyCodingKey.self)
            try container.encode(value, forKey: AnyCodingKey(stringValue: "chunk_id"))
        case let .blockShardId(value):
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode(value)
        }
    }
}

// MARK: - RpcCongestionLevelRequest

public enum RpcCongestionLevelRequest: Codable {
    case blockShardId(BlockShardId)
    case chunkId(CryptoHash)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            let value = try decoder.singleValueContainer().decode(BlockShardId.self)
            self = .blockShardId(value)
            return
        } catch {
            decodingErrors.append(".blockShardId: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("chunk_id") == .orderedSame || key.stringValue
                            .caseInsensitiveCompare("chunkId") == .orderedSame
                    }) {
                    let value = try container.decode(CryptoHash.self, forKey: matchingKey)
                    self = .chunkId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".chunkId: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcCongestionLevelRequest\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcCongestionLevelRequest:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .chunkId(value):
            var container = encoder.container(keyedBy: AnyCodingKey.self)
            try container.encode(value, forKey: AnyCodingKey(stringValue: "chunk_id"))
        case let .blockShardId(value):
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode(value)
        }
    }
}

// MARK: - RpcError

public struct RpcErrorOneOfCauseName: Codable {
    public let cause: RpcRequestValidationErrorKind
    public let name: String

    public init(
        cause: RpcRequestValidationErrorKind,
        name: String
    ) {
        self.cause = cause
        self.name = name
    }
}

public struct RpcErrorOneOfCauseName1: Codable {
    public let cause: AnyCodable
    public let name: String

    public init(
        cause: AnyCodable,
        name: String
    ) {
        self.cause = cause
        self.name = name
    }
}

public struct RpcErrorOneOfCauseName2: Codable {
    public let cause: AnyCodable
    public let name: String

    public init(
        cause: AnyCodable,
        name: String
    ) {
        self.cause = cause
        self.name = name
    }
}

public enum RpcError: Codable {
    case rpcErrorCauseName(RpcErrorOneOfCauseName)
    case rpcErrorCauseName1(RpcErrorOneOfCauseName1)
    case rpcErrorCauseName2(RpcErrorOneOfCauseName2)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            let value = try decoder.singleValueContainer().decode(RpcErrorOneOfCauseName.self)
            self = .rpcErrorCauseName(value)
            return
        } catch {
            decodingErrors.append(".rpcErrorCauseName: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(RpcErrorOneOfCauseName1.self)
            self = .rpcErrorCauseName1(value)
            return
        } catch {
            decodingErrors.append(".rpcErrorCauseName1: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(RpcErrorOneOfCauseName2.self)
            self = .rpcErrorCauseName2(value)
            return
        } catch {
            decodingErrors.append(".rpcErrorCauseName2: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcError\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcError:\n" + decodingErrors
                .joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .rpcErrorCauseName(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .rpcErrorCauseName1(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .rpcErrorCauseName2(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
}

// MARK: - RpcLightClientExecutionProofRequest

public struct RpcLightClientExecutionProofRequestOneOfSenderIdTransactionHashType: Codable {
    public let senderId: AccountId
    public let transactionHash: CryptoHash
    public let type: String

    public init(
        senderId: AccountId,
        transactionHash: CryptoHash,
        type: String
    ) {
        self.senderId = senderId
        self.transactionHash = transactionHash
        self.type = type
    }
}

public struct RpcLightClientExecutionProofRequestOneOfReceiptIdReceiverIdType: Codable {
    public let receiptId: CryptoHash
    public let receiverId: AccountId
    public let type: String

    public init(
        receiptId: CryptoHash,
        receiverId: AccountId,
        type: String
    ) {
        self.receiptId = receiptId
        self.receiverId = receiverId
        self.type = type
    }
}

public enum RpcLightClientExecutionProofRequest: Codable {
    case rpcLightClientExecutionProofRequestSenderIdTransactionHashType(
        RpcLightClientExecutionProofRequestOneOfSenderIdTransactionHashType
    )
    case rpcLightClientExecutionProofRequestReceiptIdReceiverIdType(
        RpcLightClientExecutionProofRequestOneOfReceiptIdReceiverIdType
    )

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            let value = try decoder.singleValueContainer()
                .decode(RpcLightClientExecutionProofRequestOneOfSenderIdTransactionHashType.self)
            self = .rpcLightClientExecutionProofRequestSenderIdTransactionHashType(value)
            return
        } catch {
            decodingErrors
                .append(
                    ".rpcLightClientExecutionProofRequestSenderIdTransactionHashType: \(describeDecodingError(error))"
                )
        }
        do {
            let value = try decoder.singleValueContainer()
                .decode(RpcLightClientExecutionProofRequestOneOfReceiptIdReceiverIdType.self)
            self = .rpcLightClientExecutionProofRequestReceiptIdReceiverIdType(value)
            return
        } catch {
            decodingErrors
                .append(".rpcLightClientExecutionProofRequestReceiptIdReceiverIdType: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcLightClientExecutionProofRequest\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for RpcLightClientExecutionProofRequest:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .rpcLightClientExecutionProofRequestSenderIdTransactionHashType(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .rpcLightClientExecutionProofRequestReceiptIdReceiverIdType(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
}

// MARK: - RpcProtocolConfigRequest

public enum RpcProtocolConfigRequest: Codable {
    case blockId(BlockId)
    case finality(Finality)
    case syncCheckpoint(SyncCheckpoint)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("block_id") == .orderedSame || key.stringValue
                            .caseInsensitiveCompare("blockId") == .orderedSame
                    }) {
                    let value = try container.decode(BlockId.self, forKey: matchingKey)
                    self = .blockId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".blockId: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("finality") == .orderedSame }) {
                    let value = try container.decode(Finality.self, forKey: matchingKey)
                    self = .finality(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".finality: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("sync_checkpoint") == .orderedSame || key.stringValue
                            .caseInsensitiveCompare("syncCheckpoint") == .orderedSame
                    }) {
                    let value = try container.decode(SyncCheckpoint.self, forKey: matchingKey)
                    self = .syncCheckpoint(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".syncCheckpoint: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcProtocolConfigRequest\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcProtocolConfigRequest:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case finality
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .blockId(value):
            var container = encoder.container(keyedBy: AnyCodingKey.self)
            try container.encode(value, forKey: AnyCodingKey(stringValue: "block_id"))
        case let .finality(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .finality)
        case let .syncCheckpoint(value):
            var container = encoder.container(keyedBy: AnyCodingKey.self)
            try container.encode(value, forKey: AnyCodingKey(stringValue: "sync_checkpoint"))
        }
    }
}

// MARK: - RpcQueryRequest

public struct ViewAccountByBlockId: Codable {
    public let blockId: BlockId
    public let accountId: AccountId
    public let requestType: String

    public init(
        blockId: BlockId,
        accountId: AccountId,
        requestType: String
    ) {
        self.blockId = blockId
        self.accountId = accountId
        self.requestType = requestType
    }
}

public struct ViewCodeByBlockId: Codable {
    public let blockId: BlockId
    public let accountId: AccountId
    public let requestType: String

    public init(
        blockId: BlockId,
        accountId: AccountId,
        requestType: String
    ) {
        self.blockId = blockId
        self.accountId = accountId
        self.requestType = requestType
    }
}

public struct ViewStateByBlockId: Codable {
    public let blockId: BlockId
    public let accountId: AccountId
    public let includeProof: Bool?
    public let prefixBase64: StoreKey
    public let requestType: String

    public init(
        blockId: BlockId,
        accountId: AccountId,
        includeProof: Bool?,
        prefixBase64: StoreKey,
        requestType: String
    ) {
        self.blockId = blockId
        self.accountId = accountId
        self.includeProof = includeProof
        self.prefixBase64 = prefixBase64
        self.requestType = requestType
    }
}

public struct ViewAccessKeyByBlockId: Codable {
    public let blockId: BlockId
    public let accountId: AccountId
    public let publicKey: PublicKey
    public let requestType: String

    public init(
        blockId: BlockId,
        accountId: AccountId,
        publicKey: PublicKey,
        requestType: String
    ) {
        self.blockId = blockId
        self.accountId = accountId
        self.publicKey = publicKey
        self.requestType = requestType
    }
}

public struct ViewAccessKeyListByBlockId: Codable {
    public let blockId: BlockId
    public let accountId: AccountId
    public let requestType: String

    public init(
        blockId: BlockId,
        accountId: AccountId,
        requestType: String
    ) {
        self.blockId = blockId
        self.accountId = accountId
        self.requestType = requestType
    }
}

public struct CallFunctionByBlockId: Codable {
    public let blockId: BlockId
    public let accountId: AccountId
    public let argsBase64: FunctionArgs
    public let methodName: String
    public let requestType: String

    public init(
        blockId: BlockId,
        accountId: AccountId,
        argsBase64: FunctionArgs,
        methodName: String,
        requestType: String
    ) {
        self.blockId = blockId
        self.accountId = accountId
        self.argsBase64 = argsBase64
        self.methodName = methodName
        self.requestType = requestType
    }
}

public struct ViewGlobalContractCodeByBlockId: Codable {
    public let blockId: BlockId
    public let codeHash: CryptoHash
    public let requestType: String

    public init(
        blockId: BlockId,
        codeHash: CryptoHash,
        requestType: String
    ) {
        self.blockId = blockId
        self.codeHash = codeHash
        self.requestType = requestType
    }
}

public struct ViewGlobalContractCodeByAccountIdByBlockId: Codable {
    public let blockId: BlockId
    public let accountId: AccountId
    public let requestType: String

    public init(
        blockId: BlockId,
        accountId: AccountId,
        requestType: String
    ) {
        self.blockId = blockId
        self.accountId = accountId
        self.requestType = requestType
    }
}

public struct ViewAccountByFinality: Codable {
    public let finality: Finality
    public let accountId: AccountId
    public let requestType: String

    public init(
        finality: Finality,
        accountId: AccountId,
        requestType: String
    ) {
        self.finality = finality
        self.accountId = accountId
        self.requestType = requestType
    }
}

public struct ViewCodeByFinality: Codable {
    public let finality: Finality
    public let accountId: AccountId
    public let requestType: String

    public init(
        finality: Finality,
        accountId: AccountId,
        requestType: String
    ) {
        self.finality = finality
        self.accountId = accountId
        self.requestType = requestType
    }
}

public struct ViewStateByFinality: Codable {
    public let finality: Finality
    public let accountId: AccountId
    public let includeProof: Bool?
    public let prefixBase64: StoreKey
    public let requestType: String

    public init(
        finality: Finality,
        accountId: AccountId,
        includeProof: Bool?,
        prefixBase64: StoreKey,
        requestType: String
    ) {
        self.finality = finality
        self.accountId = accountId
        self.includeProof = includeProof
        self.prefixBase64 = prefixBase64
        self.requestType = requestType
    }
}

public struct ViewAccessKeyByFinality: Codable {
    public let finality: Finality
    public let accountId: AccountId
    public let publicKey: PublicKey
    public let requestType: String

    public init(
        finality: Finality,
        accountId: AccountId,
        publicKey: PublicKey,
        requestType: String
    ) {
        self.finality = finality
        self.accountId = accountId
        self.publicKey = publicKey
        self.requestType = requestType
    }
}

public struct ViewAccessKeyListByFinality: Codable {
    public let finality: Finality
    public let accountId: AccountId
    public let requestType: String

    public init(
        finality: Finality,
        accountId: AccountId,
        requestType: String
    ) {
        self.finality = finality
        self.accountId = accountId
        self.requestType = requestType
    }
}

public struct CallFunctionByFinality: Codable {
    public let finality: Finality
    public let accountId: AccountId
    public let argsBase64: FunctionArgs
    public let methodName: String
    public let requestType: String

    public init(
        finality: Finality,
        accountId: AccountId,
        argsBase64: FunctionArgs,
        methodName: String,
        requestType: String
    ) {
        self.finality = finality
        self.accountId = accountId
        self.argsBase64 = argsBase64
        self.methodName = methodName
        self.requestType = requestType
    }
}

public struct ViewGlobalContractCodeByFinality: Codable {
    public let finality: Finality
    public let codeHash: CryptoHash
    public let requestType: String

    public init(
        finality: Finality,
        codeHash: CryptoHash,
        requestType: String
    ) {
        self.finality = finality
        self.codeHash = codeHash
        self.requestType = requestType
    }
}

public struct ViewGlobalContractCodeByAccountIdByFinality: Codable {
    public let finality: Finality
    public let accountId: AccountId
    public let requestType: String

    public init(
        finality: Finality,
        accountId: AccountId,
        requestType: String
    ) {
        self.finality = finality
        self.accountId = accountId
        self.requestType = requestType
    }
}

public struct ViewAccountBySyncCheckpoint: Codable {
    public let syncCheckpoint: SyncCheckpoint
    public let accountId: AccountId
    public let requestType: String

    public init(
        syncCheckpoint: SyncCheckpoint,
        accountId: AccountId,
        requestType: String
    ) {
        self.syncCheckpoint = syncCheckpoint
        self.accountId = accountId
        self.requestType = requestType
    }
}

public struct ViewCodeBySyncCheckpoint: Codable {
    public let syncCheckpoint: SyncCheckpoint
    public let accountId: AccountId
    public let requestType: String

    public init(
        syncCheckpoint: SyncCheckpoint,
        accountId: AccountId,
        requestType: String
    ) {
        self.syncCheckpoint = syncCheckpoint
        self.accountId = accountId
        self.requestType = requestType
    }
}

public struct ViewStateBySyncCheckpoint: Codable {
    public let syncCheckpoint: SyncCheckpoint
    public let accountId: AccountId
    public let includeProof: Bool?
    public let prefixBase64: StoreKey
    public let requestType: String

    public init(
        syncCheckpoint: SyncCheckpoint,
        accountId: AccountId,
        includeProof: Bool?,
        prefixBase64: StoreKey,
        requestType: String
    ) {
        self.syncCheckpoint = syncCheckpoint
        self.accountId = accountId
        self.includeProof = includeProof
        self.prefixBase64 = prefixBase64
        self.requestType = requestType
    }
}

public struct ViewAccessKeyBySyncCheckpoint: Codable {
    public let syncCheckpoint: SyncCheckpoint
    public let accountId: AccountId
    public let publicKey: PublicKey
    public let requestType: String

    public init(
        syncCheckpoint: SyncCheckpoint,
        accountId: AccountId,
        publicKey: PublicKey,
        requestType: String
    ) {
        self.syncCheckpoint = syncCheckpoint
        self.accountId = accountId
        self.publicKey = publicKey
        self.requestType = requestType
    }
}

public struct ViewAccessKeyListBySyncCheckpoint: Codable {
    public let syncCheckpoint: SyncCheckpoint
    public let accountId: AccountId
    public let requestType: String

    public init(
        syncCheckpoint: SyncCheckpoint,
        accountId: AccountId,
        requestType: String
    ) {
        self.syncCheckpoint = syncCheckpoint
        self.accountId = accountId
        self.requestType = requestType
    }
}

public struct CallFunctionBySyncCheckpoint: Codable {
    public let syncCheckpoint: SyncCheckpoint
    public let accountId: AccountId
    public let argsBase64: FunctionArgs
    public let methodName: String
    public let requestType: String

    public init(
        syncCheckpoint: SyncCheckpoint,
        accountId: AccountId,
        argsBase64: FunctionArgs,
        methodName: String,
        requestType: String
    ) {
        self.syncCheckpoint = syncCheckpoint
        self.accountId = accountId
        self.argsBase64 = argsBase64
        self.methodName = methodName
        self.requestType = requestType
    }
}

public struct ViewGlobalContractCodeBySyncCheckpoint: Codable {
    public let syncCheckpoint: SyncCheckpoint
    public let codeHash: CryptoHash
    public let requestType: String

    public init(
        syncCheckpoint: SyncCheckpoint,
        codeHash: CryptoHash,
        requestType: String
    ) {
        self.syncCheckpoint = syncCheckpoint
        self.codeHash = codeHash
        self.requestType = requestType
    }
}

public struct ViewGlobalContractCodeByAccountIdBySyncCheckpoint: Codable {
    public let syncCheckpoint: SyncCheckpoint
    public let accountId: AccountId
    public let requestType: String

    public init(
        syncCheckpoint: SyncCheckpoint,
        accountId: AccountId,
        requestType: String
    ) {
        self.syncCheckpoint = syncCheckpoint
        self.accountId = accountId
        self.requestType = requestType
    }
}

public enum RpcQueryRequest: Codable {
    case viewAccountByBlockId(ViewAccountByBlockId)
    case viewCodeByBlockId(ViewCodeByBlockId)
    case viewStateByBlockId(ViewStateByBlockId)
    case viewAccessKeyByBlockId(ViewAccessKeyByBlockId)
    case viewAccessKeyListByBlockId(ViewAccessKeyListByBlockId)
    case callFunctionByBlockId(CallFunctionByBlockId)
    case viewGlobalContractCodeByBlockId(ViewGlobalContractCodeByBlockId)
    case viewGlobalContractCodeByAccountIdByBlockId(ViewGlobalContractCodeByAccountIdByBlockId)
    case viewAccountByFinality(ViewAccountByFinality)
    case viewCodeByFinality(ViewCodeByFinality)
    case viewStateByFinality(ViewStateByFinality)
    case viewAccessKeyByFinality(ViewAccessKeyByFinality)
    case viewAccessKeyListByFinality(ViewAccessKeyListByFinality)
    case callFunctionByFinality(CallFunctionByFinality)
    case viewGlobalContractCodeByFinality(ViewGlobalContractCodeByFinality)
    case viewGlobalContractCodeByAccountIdByFinality(ViewGlobalContractCodeByAccountIdByFinality)
    case viewAccountBySyncCheckpoint(ViewAccountBySyncCheckpoint)
    case viewCodeBySyncCheckpoint(ViewCodeBySyncCheckpoint)
    case viewStateBySyncCheckpoint(ViewStateBySyncCheckpoint)
    case viewAccessKeyBySyncCheckpoint(ViewAccessKeyBySyncCheckpoint)
    case viewAccessKeyListBySyncCheckpoint(ViewAccessKeyListBySyncCheckpoint)
    case callFunctionBySyncCheckpoint(CallFunctionBySyncCheckpoint)
    case viewGlobalContractCodeBySyncCheckpoint(ViewGlobalContractCodeBySyncCheckpoint)
    case viewGlobalContractCodeByAccountIdBySyncCheckpoint(ViewGlobalContractCodeByAccountIdBySyncCheckpoint)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            let value = try decoder.singleValueContainer().decode(ViewAccountByBlockId.self)
            self = .viewAccountByBlockId(value)
            return
        } catch {
            decodingErrors.append(".viewAccountByBlockId: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewCodeByBlockId.self)
            self = .viewCodeByBlockId(value)
            return
        } catch {
            decodingErrors.append(".viewCodeByBlockId: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewStateByBlockId.self)
            self = .viewStateByBlockId(value)
            return
        } catch {
            decodingErrors.append(".viewStateByBlockId: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewAccessKeyByBlockId.self)
            self = .viewAccessKeyByBlockId(value)
            return
        } catch {
            decodingErrors.append(".viewAccessKeyByBlockId: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewAccessKeyListByBlockId.self)
            self = .viewAccessKeyListByBlockId(value)
            return
        } catch {
            decodingErrors.append(".viewAccessKeyListByBlockId: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(CallFunctionByBlockId.self)
            self = .callFunctionByBlockId(value)
            return
        } catch {
            decodingErrors.append(".callFunctionByBlockId: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewGlobalContractCodeByBlockId.self)
            self = .viewGlobalContractCodeByBlockId(value)
            return
        } catch {
            decodingErrors.append(".viewGlobalContractCodeByBlockId: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewGlobalContractCodeByAccountIdByBlockId.self)
            self = .viewGlobalContractCodeByAccountIdByBlockId(value)
            return
        } catch {
            decodingErrors.append(".viewGlobalContractCodeByAccountIdByBlockId: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewAccountByFinality.self)
            self = .viewAccountByFinality(value)
            return
        } catch {
            decodingErrors.append(".viewAccountByFinality: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewCodeByFinality.self)
            self = .viewCodeByFinality(value)
            return
        } catch {
            decodingErrors.append(".viewCodeByFinality: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewStateByFinality.self)
            self = .viewStateByFinality(value)
            return
        } catch {
            decodingErrors.append(".viewStateByFinality: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewAccessKeyByFinality.self)
            self = .viewAccessKeyByFinality(value)
            return
        } catch {
            decodingErrors.append(".viewAccessKeyByFinality: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewAccessKeyListByFinality.self)
            self = .viewAccessKeyListByFinality(value)
            return
        } catch {
            decodingErrors.append(".viewAccessKeyListByFinality: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(CallFunctionByFinality.self)
            self = .callFunctionByFinality(value)
            return
        } catch {
            decodingErrors.append(".callFunctionByFinality: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewGlobalContractCodeByFinality.self)
            self = .viewGlobalContractCodeByFinality(value)
            return
        } catch {
            decodingErrors.append(".viewGlobalContractCodeByFinality: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewGlobalContractCodeByAccountIdByFinality.self)
            self = .viewGlobalContractCodeByAccountIdByFinality(value)
            return
        } catch {
            decodingErrors.append(".viewGlobalContractCodeByAccountIdByFinality: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewAccountBySyncCheckpoint.self)
            self = .viewAccountBySyncCheckpoint(value)
            return
        } catch {
            decodingErrors.append(".viewAccountBySyncCheckpoint: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewCodeBySyncCheckpoint.self)
            self = .viewCodeBySyncCheckpoint(value)
            return
        } catch {
            decodingErrors.append(".viewCodeBySyncCheckpoint: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewStateBySyncCheckpoint.self)
            self = .viewStateBySyncCheckpoint(value)
            return
        } catch {
            decodingErrors.append(".viewStateBySyncCheckpoint: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewAccessKeyBySyncCheckpoint.self)
            self = .viewAccessKeyBySyncCheckpoint(value)
            return
        } catch {
            decodingErrors.append(".viewAccessKeyBySyncCheckpoint: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewAccessKeyListBySyncCheckpoint.self)
            self = .viewAccessKeyListBySyncCheckpoint(value)
            return
        } catch {
            decodingErrors.append(".viewAccessKeyListBySyncCheckpoint: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(CallFunctionBySyncCheckpoint.self)
            self = .callFunctionBySyncCheckpoint(value)
            return
        } catch {
            decodingErrors.append(".callFunctionBySyncCheckpoint: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewGlobalContractCodeBySyncCheckpoint.self)
            self = .viewGlobalContractCodeBySyncCheckpoint(value)
            return
        } catch {
            decodingErrors.append(".viewGlobalContractCodeBySyncCheckpoint: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer()
                .decode(ViewGlobalContractCodeByAccountIdBySyncCheckpoint.self)
            self = .viewGlobalContractCodeByAccountIdBySyncCheckpoint(value)
            return
        } catch {
            decodingErrors.append(".viewGlobalContractCodeByAccountIdBySyncCheckpoint: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcQueryRequest\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcQueryRequest:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .viewAccountByBlockId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewCodeByBlockId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewStateByBlockId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewAccessKeyByBlockId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewAccessKeyListByBlockId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .callFunctionByBlockId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewGlobalContractCodeByBlockId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewGlobalContractCodeByAccountIdByBlockId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewAccountByFinality(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewCodeByFinality(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewStateByFinality(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewAccessKeyByFinality(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewAccessKeyListByFinality(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .callFunctionByFinality(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewGlobalContractCodeByFinality(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewGlobalContractCodeByAccountIdByFinality(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewAccountBySyncCheckpoint(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewCodeBySyncCheckpoint(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewStateBySyncCheckpoint(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewAccessKeyBySyncCheckpoint(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewAccessKeyListBySyncCheckpoint(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .callFunctionBySyncCheckpoint(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewGlobalContractCodeBySyncCheckpoint(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewGlobalContractCodeByAccountIdBySyncCheckpoint(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
}

// MARK: - RpcQueryResponse

public enum RpcQueryResponse: Codable {
    case accountView(AccountView)
    case contractCodeView(ContractCodeView)
    case viewStateResult(ViewStateResult)
    case callResult(CallResult)
    case accessKeyView(AccessKeyView)
    case accessKeyList(AccessKeyList)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            let value = try decoder.singleValueContainer().decode(AccountView.self)
            self = .accountView(value)
            return
        } catch {
            decodingErrors.append(".accountView: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ContractCodeView.self)
            self = .contractCodeView(value)
            return
        } catch {
            decodingErrors.append(".contractCodeView: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ViewStateResult.self)
            self = .viewStateResult(value)
            return
        } catch {
            decodingErrors.append(".viewStateResult: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(CallResult.self)
            self = .callResult(value)
            return
        } catch {
            decodingErrors.append(".callResult: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(AccessKeyView.self)
            self = .accessKeyView(value)
            return
        } catch {
            decodingErrors.append(".accessKeyView: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(AccessKeyList.self)
            self = .accessKeyList(value)
            return
        } catch {
            decodingErrors.append(".accessKeyList: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcQueryResponse\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcQueryResponse:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .accountView(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .contractCodeView(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .viewStateResult(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .callResult(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .accessKeyView(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .accessKeyList(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
}

// MARK: - RpcRequestValidationErrorKind

public struct RpcRequestValidationErrorKindOneOfInfoName: Codable {
    public let info: AnyCodable
    public let name: String

    public init(
        info: AnyCodable,
        name: String
    ) {
        self.info = info
        self.name = name
    }
}

public struct RpcRequestValidationErrorKindOneOfInfoName1: Codable {
    public let info: AnyCodable
    public let name: String

    public init(
        info: AnyCodable,
        name: String
    ) {
        self.info = info
        self.name = name
    }
}

public enum RpcRequestValidationErrorKind: Codable {
    case rpcRequestValidationErrorKindInfoName(RpcRequestValidationErrorKindOneOfInfoName)
    case rpcRequestValidationErrorKindInfoName1(RpcRequestValidationErrorKindOneOfInfoName1)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            let value = try decoder.singleValueContainer().decode(RpcRequestValidationErrorKindOneOfInfoName.self)
            self = .rpcRequestValidationErrorKindInfoName(value)
            return
        } catch {
            decodingErrors.append(".rpcRequestValidationErrorKindInfoName: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(RpcRequestValidationErrorKindOneOfInfoName1.self)
            self = .rpcRequestValidationErrorKindInfoName1(value)
            return
        } catch {
            decodingErrors.append(".rpcRequestValidationErrorKindInfoName1: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcRequestValidationErrorKind\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for RpcRequestValidationErrorKind:\n" + decodingErrors
                    .joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .rpcRequestValidationErrorKindInfoName(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .rpcRequestValidationErrorKindInfoName1(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
}

// MARK: - RpcStateChangesInBlockByTypeRequest

public struct AccountChangesByBlockId: Codable {
    public let blockId: BlockId
    public let accountIds: [AccountId]
    public let changesType: String

    public init(
        blockId: BlockId,
        accountIds: [AccountId],
        changesType: String
    ) {
        self.blockId = blockId
        self.accountIds = accountIds
        self.changesType = changesType
    }
}

public struct SingleAccessKeyChangesByBlockId: Codable {
    public let blockId: BlockId
    public let changesType: String
    public let keys: [AccountWithPublicKey]

    public init(
        blockId: BlockId,
        changesType: String,
        keys: [AccountWithPublicKey]
    ) {
        self.blockId = blockId
        self.changesType = changesType
        self.keys = keys
    }
}

public struct SingleGasKeyChangesByBlockId: Codable {
    public let blockId: BlockId
    public let changesType: String
    public let keys: [AccountWithPublicKey]

    public init(
        blockId: BlockId,
        changesType: String,
        keys: [AccountWithPublicKey]
    ) {
        self.blockId = blockId
        self.changesType = changesType
        self.keys = keys
    }
}

public struct AllAccessKeyChangesByBlockId: Codable {
    public let blockId: BlockId
    public let accountIds: [AccountId]
    public let changesType: String

    public init(
        blockId: BlockId,
        accountIds: [AccountId],
        changesType: String
    ) {
        self.blockId = blockId
        self.accountIds = accountIds
        self.changesType = changesType
    }
}

public struct AllGasKeyChangesByBlockId: Codable {
    public let blockId: BlockId
    public let accountIds: [AccountId]
    public let changesType: String

    public init(
        blockId: BlockId,
        accountIds: [AccountId],
        changesType: String
    ) {
        self.blockId = blockId
        self.accountIds = accountIds
        self.changesType = changesType
    }
}

public struct ContractCodeChangesByBlockId: Codable {
    public let blockId: BlockId
    public let accountIds: [AccountId]
    public let changesType: String

    public init(
        blockId: BlockId,
        accountIds: [AccountId],
        changesType: String
    ) {
        self.blockId = blockId
        self.accountIds = accountIds
        self.changesType = changesType
    }
}

public struct DataChangesByBlockId: Codable {
    public let blockId: BlockId
    public let accountIds: [AccountId]
    public let changesType: String
    public let keyPrefixBase64: StoreKey

    public init(
        blockId: BlockId,
        accountIds: [AccountId],
        changesType: String,
        keyPrefixBase64: StoreKey
    ) {
        self.blockId = blockId
        self.accountIds = accountIds
        self.changesType = changesType
        self.keyPrefixBase64 = keyPrefixBase64
    }
}

public struct AccountChangesByFinality: Codable {
    public let finality: Finality
    public let accountIds: [AccountId]
    public let changesType: String

    public init(
        finality: Finality,
        accountIds: [AccountId],
        changesType: String
    ) {
        self.finality = finality
        self.accountIds = accountIds
        self.changesType = changesType
    }
}

public struct SingleAccessKeyChangesByFinality: Codable {
    public let finality: Finality
    public let changesType: String
    public let keys: [AccountWithPublicKey]

    public init(
        finality: Finality,
        changesType: String,
        keys: [AccountWithPublicKey]
    ) {
        self.finality = finality
        self.changesType = changesType
        self.keys = keys
    }
}

public struct SingleGasKeyChangesByFinality: Codable {
    public let finality: Finality
    public let changesType: String
    public let keys: [AccountWithPublicKey]

    public init(
        finality: Finality,
        changesType: String,
        keys: [AccountWithPublicKey]
    ) {
        self.finality = finality
        self.changesType = changesType
        self.keys = keys
    }
}

public struct AllAccessKeyChangesByFinality: Codable {
    public let finality: Finality
    public let accountIds: [AccountId]
    public let changesType: String

    public init(
        finality: Finality,
        accountIds: [AccountId],
        changesType: String
    ) {
        self.finality = finality
        self.accountIds = accountIds
        self.changesType = changesType
    }
}

public struct AllGasKeyChangesByFinality: Codable {
    public let finality: Finality
    public let accountIds: [AccountId]
    public let changesType: String

    public init(
        finality: Finality,
        accountIds: [AccountId],
        changesType: String
    ) {
        self.finality = finality
        self.accountIds = accountIds
        self.changesType = changesType
    }
}

public struct ContractCodeChangesByFinality: Codable {
    public let finality: Finality
    public let accountIds: [AccountId]
    public let changesType: String

    public init(
        finality: Finality,
        accountIds: [AccountId],
        changesType: String
    ) {
        self.finality = finality
        self.accountIds = accountIds
        self.changesType = changesType
    }
}

public struct DataChangesByFinality: Codable {
    public let finality: Finality
    public let accountIds: [AccountId]
    public let changesType: String
    public let keyPrefixBase64: StoreKey

    public init(
        finality: Finality,
        accountIds: [AccountId],
        changesType: String,
        keyPrefixBase64: StoreKey
    ) {
        self.finality = finality
        self.accountIds = accountIds
        self.changesType = changesType
        self.keyPrefixBase64 = keyPrefixBase64
    }
}

public struct AccountChangesBySyncCheckpoint: Codable {
    public let syncCheckpoint: SyncCheckpoint
    public let accountIds: [AccountId]
    public let changesType: String

    public init(
        syncCheckpoint: SyncCheckpoint,
        accountIds: [AccountId],
        changesType: String
    ) {
        self.syncCheckpoint = syncCheckpoint
        self.accountIds = accountIds
        self.changesType = changesType
    }
}

public struct SingleAccessKeyChangesBySyncCheckpoint: Codable {
    public let syncCheckpoint: SyncCheckpoint
    public let changesType: String
    public let keys: [AccountWithPublicKey]

    public init(
        syncCheckpoint: SyncCheckpoint,
        changesType: String,
        keys: [AccountWithPublicKey]
    ) {
        self.syncCheckpoint = syncCheckpoint
        self.changesType = changesType
        self.keys = keys
    }
}

public struct SingleGasKeyChangesBySyncCheckpoint: Codable {
    public let syncCheckpoint: SyncCheckpoint
    public let changesType: String
    public let keys: [AccountWithPublicKey]

    public init(
        syncCheckpoint: SyncCheckpoint,
        changesType: String,
        keys: [AccountWithPublicKey]
    ) {
        self.syncCheckpoint = syncCheckpoint
        self.changesType = changesType
        self.keys = keys
    }
}

public struct AllAccessKeyChangesBySyncCheckpoint: Codable {
    public let syncCheckpoint: SyncCheckpoint
    public let accountIds: [AccountId]
    public let changesType: String

    public init(
        syncCheckpoint: SyncCheckpoint,
        accountIds: [AccountId],
        changesType: String
    ) {
        self.syncCheckpoint = syncCheckpoint
        self.accountIds = accountIds
        self.changesType = changesType
    }
}

public struct AllGasKeyChangesBySyncCheckpoint: Codable {
    public let syncCheckpoint: SyncCheckpoint
    public let accountIds: [AccountId]
    public let changesType: String

    public init(
        syncCheckpoint: SyncCheckpoint,
        accountIds: [AccountId],
        changesType: String
    ) {
        self.syncCheckpoint = syncCheckpoint
        self.accountIds = accountIds
        self.changesType = changesType
    }
}

public struct ContractCodeChangesBySyncCheckpoint: Codable {
    public let syncCheckpoint: SyncCheckpoint
    public let accountIds: [AccountId]
    public let changesType: String

    public init(
        syncCheckpoint: SyncCheckpoint,
        accountIds: [AccountId],
        changesType: String
    ) {
        self.syncCheckpoint = syncCheckpoint
        self.accountIds = accountIds
        self.changesType = changesType
    }
}

public struct DataChangesBySyncCheckpoint: Codable {
    public let syncCheckpoint: SyncCheckpoint
    public let accountIds: [AccountId]
    public let changesType: String
    public let keyPrefixBase64: StoreKey

    public init(
        syncCheckpoint: SyncCheckpoint,
        accountIds: [AccountId],
        changesType: String,
        keyPrefixBase64: StoreKey
    ) {
        self.syncCheckpoint = syncCheckpoint
        self.accountIds = accountIds
        self.changesType = changesType
        self.keyPrefixBase64 = keyPrefixBase64
    }
}

public enum RpcStateChangesInBlockByTypeRequest: Codable {
    case accountChangesByBlockId(AccountChangesByBlockId)
    case singleAccessKeyChangesByBlockId(SingleAccessKeyChangesByBlockId)
    case singleGasKeyChangesByBlockId(SingleGasKeyChangesByBlockId)
    case allAccessKeyChangesByBlockId(AllAccessKeyChangesByBlockId)
    case allGasKeyChangesByBlockId(AllGasKeyChangesByBlockId)
    case contractCodeChangesByBlockId(ContractCodeChangesByBlockId)
    case dataChangesByBlockId(DataChangesByBlockId)
    case accountChangesByFinality(AccountChangesByFinality)
    case singleAccessKeyChangesByFinality(SingleAccessKeyChangesByFinality)
    case singleGasKeyChangesByFinality(SingleGasKeyChangesByFinality)
    case allAccessKeyChangesByFinality(AllAccessKeyChangesByFinality)
    case allGasKeyChangesByFinality(AllGasKeyChangesByFinality)
    case contractCodeChangesByFinality(ContractCodeChangesByFinality)
    case dataChangesByFinality(DataChangesByFinality)
    case accountChangesBySyncCheckpoint(AccountChangesBySyncCheckpoint)
    case singleAccessKeyChangesBySyncCheckpoint(SingleAccessKeyChangesBySyncCheckpoint)
    case singleGasKeyChangesBySyncCheckpoint(SingleGasKeyChangesBySyncCheckpoint)
    case allAccessKeyChangesBySyncCheckpoint(AllAccessKeyChangesBySyncCheckpoint)
    case allGasKeyChangesBySyncCheckpoint(AllGasKeyChangesBySyncCheckpoint)
    case contractCodeChangesBySyncCheckpoint(ContractCodeChangesBySyncCheckpoint)
    case dataChangesBySyncCheckpoint(DataChangesBySyncCheckpoint)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            let value = try decoder.singleValueContainer().decode(AccountChangesByBlockId.self)
            self = .accountChangesByBlockId(value)
            return
        } catch {
            decodingErrors.append(".accountChangesByBlockId: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(SingleAccessKeyChangesByBlockId.self)
            self = .singleAccessKeyChangesByBlockId(value)
            return
        } catch {
            decodingErrors.append(".singleAccessKeyChangesByBlockId: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(SingleGasKeyChangesByBlockId.self)
            self = .singleGasKeyChangesByBlockId(value)
            return
        } catch {
            decodingErrors.append(".singleGasKeyChangesByBlockId: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(AllAccessKeyChangesByBlockId.self)
            self = .allAccessKeyChangesByBlockId(value)
            return
        } catch {
            decodingErrors.append(".allAccessKeyChangesByBlockId: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(AllGasKeyChangesByBlockId.self)
            self = .allGasKeyChangesByBlockId(value)
            return
        } catch {
            decodingErrors.append(".allGasKeyChangesByBlockId: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ContractCodeChangesByBlockId.self)
            self = .contractCodeChangesByBlockId(value)
            return
        } catch {
            decodingErrors.append(".contractCodeChangesByBlockId: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(DataChangesByBlockId.self)
            self = .dataChangesByBlockId(value)
            return
        } catch {
            decodingErrors.append(".dataChangesByBlockId: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(AccountChangesByFinality.self)
            self = .accountChangesByFinality(value)
            return
        } catch {
            decodingErrors.append(".accountChangesByFinality: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(SingleAccessKeyChangesByFinality.self)
            self = .singleAccessKeyChangesByFinality(value)
            return
        } catch {
            decodingErrors.append(".singleAccessKeyChangesByFinality: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(SingleGasKeyChangesByFinality.self)
            self = .singleGasKeyChangesByFinality(value)
            return
        } catch {
            decodingErrors.append(".singleGasKeyChangesByFinality: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(AllAccessKeyChangesByFinality.self)
            self = .allAccessKeyChangesByFinality(value)
            return
        } catch {
            decodingErrors.append(".allAccessKeyChangesByFinality: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(AllGasKeyChangesByFinality.self)
            self = .allGasKeyChangesByFinality(value)
            return
        } catch {
            decodingErrors.append(".allGasKeyChangesByFinality: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ContractCodeChangesByFinality.self)
            self = .contractCodeChangesByFinality(value)
            return
        } catch {
            decodingErrors.append(".contractCodeChangesByFinality: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(DataChangesByFinality.self)
            self = .dataChangesByFinality(value)
            return
        } catch {
            decodingErrors.append(".dataChangesByFinality: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(AccountChangesBySyncCheckpoint.self)
            self = .accountChangesBySyncCheckpoint(value)
            return
        } catch {
            decodingErrors.append(".accountChangesBySyncCheckpoint: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(SingleAccessKeyChangesBySyncCheckpoint.self)
            self = .singleAccessKeyChangesBySyncCheckpoint(value)
            return
        } catch {
            decodingErrors.append(".singleAccessKeyChangesBySyncCheckpoint: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(SingleGasKeyChangesBySyncCheckpoint.self)
            self = .singleGasKeyChangesBySyncCheckpoint(value)
            return
        } catch {
            decodingErrors.append(".singleGasKeyChangesBySyncCheckpoint: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(AllAccessKeyChangesBySyncCheckpoint.self)
            self = .allAccessKeyChangesBySyncCheckpoint(value)
            return
        } catch {
            decodingErrors.append(".allAccessKeyChangesBySyncCheckpoint: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(AllGasKeyChangesBySyncCheckpoint.self)
            self = .allGasKeyChangesBySyncCheckpoint(value)
            return
        } catch {
            decodingErrors.append(".allGasKeyChangesBySyncCheckpoint: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(ContractCodeChangesBySyncCheckpoint.self)
            self = .contractCodeChangesBySyncCheckpoint(value)
            return
        } catch {
            decodingErrors.append(".contractCodeChangesBySyncCheckpoint: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(DataChangesBySyncCheckpoint.self)
            self = .dataChangesBySyncCheckpoint(value)
            return
        } catch {
            decodingErrors.append(".dataChangesBySyncCheckpoint: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcStateChangesInBlockByTypeRequest\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for RpcStateChangesInBlockByTypeRequest:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .accountChangesByBlockId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .singleAccessKeyChangesByBlockId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .singleGasKeyChangesByBlockId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .allAccessKeyChangesByBlockId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .allGasKeyChangesByBlockId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .contractCodeChangesByBlockId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .dataChangesByBlockId(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .accountChangesByFinality(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .singleAccessKeyChangesByFinality(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .singleGasKeyChangesByFinality(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .allAccessKeyChangesByFinality(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .allGasKeyChangesByFinality(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .contractCodeChangesByFinality(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .dataChangesByFinality(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .accountChangesBySyncCheckpoint(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .singleAccessKeyChangesBySyncCheckpoint(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .singleGasKeyChangesBySyncCheckpoint(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .allAccessKeyChangesBySyncCheckpoint(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .allGasKeyChangesBySyncCheckpoint(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .contractCodeChangesBySyncCheckpoint(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .dataChangesBySyncCheckpoint(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
}

// MARK: - RpcStateChangesInBlockRequest

public enum RpcStateChangesInBlockRequest: Codable {
    case blockId(BlockId)
    case finality(Finality)
    case syncCheckpoint(SyncCheckpoint)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("block_id") == .orderedSame || key.stringValue
                            .caseInsensitiveCompare("blockId") == .orderedSame
                    }) {
                    let value = try container.decode(BlockId.self, forKey: matchingKey)
                    self = .blockId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".blockId: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("finality") == .orderedSame }) {
                    let value = try container.decode(Finality.self, forKey: matchingKey)
                    self = .finality(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".finality: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("sync_checkpoint") == .orderedSame || key.stringValue
                            .caseInsensitiveCompare("syncCheckpoint") == .orderedSame
                    }) {
                    let value = try container.decode(SyncCheckpoint.self, forKey: matchingKey)
                    self = .syncCheckpoint(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".syncCheckpoint: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcStateChangesInBlockRequest\(availableKeys)"
        } else {
            contextDescription =
                "Could not decode any of the oneOf/anyOf variants for RpcStateChangesInBlockRequest:\n" + decodingErrors
                    .joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case finality
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .blockId(value):
            var container = encoder.container(keyedBy: AnyCodingKey.self)
            try container.encode(value, forKey: AnyCodingKey(stringValue: "block_id"))
        case let .finality(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .finality)
        case let .syncCheckpoint(value):
            var container = encoder.container(keyedBy: AnyCodingKey.self)
            try container.encode(value, forKey: AnyCodingKey(stringValue: "sync_checkpoint"))
        }
    }
}

// MARK: - RpcTransactionResponse

public enum RpcTransactionResponse: Codable {
    case finalExecutionOutcomeWithReceiptView(FinalExecutionOutcomeWithReceiptView)
    case finalExecutionOutcomeView(FinalExecutionOutcomeView)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            let value = try decoder.singleValueContainer().decode(FinalExecutionOutcomeWithReceiptView.self)
            self = .finalExecutionOutcomeWithReceiptView(value)
            return
        } catch {
            decodingErrors.append(".finalExecutionOutcomeWithReceiptView: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(FinalExecutionOutcomeView.self)
            self = .finalExecutionOutcomeView(value)
            return
        } catch {
            decodingErrors.append(".finalExecutionOutcomeView: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcTransactionResponse\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcTransactionResponse:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .finalExecutionOutcomeWithReceiptView(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .finalExecutionOutcomeView(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
}

// MARK: - RpcTransactionStatusRequest

public struct RpcTransactionStatusRequestOneOfSenderAccountIdTxHash: Codable {
    public let senderAccountId: AccountId
    public let txHash: CryptoHash

    public init(
        senderAccountId: AccountId,
        txHash: CryptoHash
    ) {
        self.senderAccountId = senderAccountId
        self.txHash = txHash
    }
}

public enum RpcTransactionStatusRequest: Codable {
    case signedTxBase64(SignedTransaction)
    case rpcTransactionStatusRequestSenderAccountIdTxHash(RpcTransactionStatusRequestOneOfSenderAccountIdTxHash)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("signed_tx_base64") == .orderedSame || key.stringValue
                            .caseInsensitiveCompare("signedTxBase64") == .orderedSame
                    }) {
                    let value = try container.decode(SignedTransaction.self, forKey: matchingKey)
                    self = .signedTxBase64(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".signedTxBase64: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer()
                .decode(RpcTransactionStatusRequestOneOfSenderAccountIdTxHash.self)
            self = .rpcTransactionStatusRequestSenderAccountIdTxHash(value)
            return
        } catch {
            decodingErrors.append(".rpcTransactionStatusRequestSenderAccountIdTxHash: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcTransactionStatusRequest\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcTransactionStatusRequest:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .signedTxBase64(value):
            var container = encoder.container(keyedBy: AnyCodingKey.self)
            try container.encode(value, forKey: AnyCodingKey(stringValue: "signed_tx_base64"))
        case let .rpcTransactionStatusRequestSenderAccountIdTxHash(value):
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode(value)
        }
    }
}

// MARK: - RpcValidatorRequest

public enum RpcValidatorRequest: Codable {
    case latest
    case epochId(EpochId)
    case blockId(BlockId)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "latest" {
            self = .latest
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("epoch_id") == .orderedSame || key.stringValue
                            .caseInsensitiveCompare("epochId") == .orderedSame
                    }) {
                    let value = try container.decode(EpochId.self, forKey: matchingKey)
                    self = .epochId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".epochId: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("block_id") == .orderedSame || key.stringValue
                            .caseInsensitiveCompare("blockId") == .orderedSame
                    }) {
                    let value = try container.decode(BlockId.self, forKey: matchingKey)
                    self = .blockId(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".blockId: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcValidatorRequest\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for RpcValidatorRequest:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .epochId(value):
            var container = encoder.container(keyedBy: AnyCodingKey.self)
            try container.encode(value, forKey: AnyCodingKey(stringValue: "epoch_id"))
        case let .blockId(value):
            var container = encoder.container(keyedBy: AnyCodingKey.self)
            try container.encode(value, forKey: AnyCodingKey(stringValue: "block_id"))
        case .latest:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("latest")
        }
    }
}

// MARK: - ShardLayout

public enum ShardLayout: Codable {
    case v0(ShardLayoutV0)
    case v1(ShardLayoutV1)
    case v2(ShardLayoutV2)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("V0") == .orderedSame }) {
                    let value = try container.decode(ShardLayoutV0.self, forKey: matchingKey)
                    self = .v0(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".v0: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("V1") == .orderedSame }) {
                    let value = try container.decode(ShardLayoutV1.self, forKey: matchingKey)
                    self = .v1(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".v1: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("V2") == .orderedSame }) {
                    let value = try container.decode(ShardLayoutV2.self, forKey: matchingKey)
                    self = .v2(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".v2: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ShardLayout\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ShardLayout:\n" + decodingErrors
                .joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case v0 = "V0"
        case v1 = "V1"
        case v2 = "V2"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .v0(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .v0)
        case let .v1(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .v1)
        case let .v2(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .v2)
        }
    }
}

// MARK: - StateChangeCauseView

public struct StateChangeCauseViewOneOfTxHashType: Codable {
    public let txHash: CryptoHash
    public let type: String

    public init(
        txHash: CryptoHash,
        type: String
    ) {
        self.txHash = txHash
        self.type = type
    }
}

public struct StateChangeCauseViewOneOfReceiptHashType: Codable {
    public let receiptHash: CryptoHash
    public let type: String

    public init(
        receiptHash: CryptoHash,
        type: String
    ) {
        self.receiptHash = receiptHash
        self.type = type
    }
}

public struct StateChangeCauseViewOneOfReceiptHashType1: Codable {
    public let receiptHash: CryptoHash
    public let type: String

    public init(
        receiptHash: CryptoHash,
        type: String
    ) {
        self.receiptHash = receiptHash
        self.type = type
    }
}

public struct StateChangeCauseViewOneOfReceiptHashType2: Codable {
    public let receiptHash: CryptoHash
    public let type: String

    public init(
        receiptHash: CryptoHash,
        type: String
    ) {
        self.receiptHash = receiptHash
        self.type = type
    }
}

public struct StateChangeCauseViewOneOfReceiptHashType3: Codable {
    public let receiptHash: CryptoHash
    public let type: String

    public init(
        receiptHash: CryptoHash,
        type: String
    ) {
        self.receiptHash = receiptHash
        self.type = type
    }
}

public enum StateChangeCauseView: Codable {
    case type(String)
    case type1(String)
    case stateChangeCauseViewTxHashType(StateChangeCauseViewOneOfTxHashType)
    case stateChangeCauseViewReceiptHashType(StateChangeCauseViewOneOfReceiptHashType)
    case stateChangeCauseViewReceiptHashType1(StateChangeCauseViewOneOfReceiptHashType1)
    case stateChangeCauseViewReceiptHashType2(StateChangeCauseViewOneOfReceiptHashType2)
    case stateChangeCauseViewReceiptHashType3(StateChangeCauseViewOneOfReceiptHashType3)
    case type2(String)
    case type3(String)
    case type4(String)
    case type5(String)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("type") == .orderedSame }) {
                    let value = try container.decode(String.self, forKey: matchingKey)
                    self = .type(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".type: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("type") == .orderedSame }) {
                    let value = try container.decode(String.self, forKey: matchingKey)
                    self = .type1(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".type1: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeCauseViewOneOfTxHashType.self)
            self = .stateChangeCauseViewTxHashType(value)
            return
        } catch {
            decodingErrors.append(".stateChangeCauseViewTxHashType: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeCauseViewOneOfReceiptHashType.self)
            self = .stateChangeCauseViewReceiptHashType(value)
            return
        } catch {
            decodingErrors.append(".stateChangeCauseViewReceiptHashType: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeCauseViewOneOfReceiptHashType1.self)
            self = .stateChangeCauseViewReceiptHashType1(value)
            return
        } catch {
            decodingErrors.append(".stateChangeCauseViewReceiptHashType1: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeCauseViewOneOfReceiptHashType2.self)
            self = .stateChangeCauseViewReceiptHashType2(value)
            return
        } catch {
            decodingErrors.append(".stateChangeCauseViewReceiptHashType2: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeCauseViewOneOfReceiptHashType3.self)
            self = .stateChangeCauseViewReceiptHashType3(value)
            return
        } catch {
            decodingErrors.append(".stateChangeCauseViewReceiptHashType3: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("type") == .orderedSame }) {
                    let value = try container.decode(String.self, forKey: matchingKey)
                    self = .type2(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".type2: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("type") == .orderedSame }) {
                    let value = try container.decode(String.self, forKey: matchingKey)
                    self = .type3(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".type3: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("type") == .orderedSame }) {
                    let value = try container.decode(String.self, forKey: matchingKey)
                    self = .type4(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".type4: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("type") == .orderedSame }) {
                    let value = try container.decode(String.self, forKey: matchingKey)
                    self = .type5(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".type5: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for StateChangeCauseView\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for StateChangeCauseView:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case type
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .type(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .type)
        case let .type1(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .type)
        case let .type2(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .type)
        case let .type3(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .type)
        case let .type4(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .type)
        case let .type5(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .type)
        case let .stateChangeCauseViewTxHashType(value):
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode(value)
        case let .stateChangeCauseViewReceiptHashType(value):
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode(value)
        case let .stateChangeCauseViewReceiptHashType1(value):
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode(value)
        case let .stateChangeCauseViewReceiptHashType2(value):
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode(value)
        case let .stateChangeCauseViewReceiptHashType3(value):
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode(value)
        }
    }
}

// MARK: - StateChangeKindView

public struct StateChangeKindViewOneOfAccountIdType: Codable {
    public let accountId: AccountId
    public let type: String

    public init(
        accountId: AccountId,
        type: String
    ) {
        self.accountId = accountId
        self.type = type
    }
}

public struct StateChangeKindViewOneOfAccountIdType1: Codable {
    public let accountId: AccountId
    public let type: String

    public init(
        accountId: AccountId,
        type: String
    ) {
        self.accountId = accountId
        self.type = type
    }
}

public struct StateChangeKindViewOneOfAccountIdType2: Codable {
    public let accountId: AccountId
    public let type: String

    public init(
        accountId: AccountId,
        type: String
    ) {
        self.accountId = accountId
        self.type = type
    }
}

public struct StateChangeKindViewOneOfAccountIdType3: Codable {
    public let accountId: AccountId
    public let type: String

    public init(
        accountId: AccountId,
        type: String
    ) {
        self.accountId = accountId
        self.type = type
    }
}

public enum StateChangeKindView: Codable {
    case stateChangeKindViewAccountIdType(StateChangeKindViewOneOfAccountIdType)
    case stateChangeKindViewAccountIdType1(StateChangeKindViewOneOfAccountIdType1)
    case stateChangeKindViewAccountIdType2(StateChangeKindViewOneOfAccountIdType2)
    case stateChangeKindViewAccountIdType3(StateChangeKindViewOneOfAccountIdType3)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeKindViewOneOfAccountIdType.self)
            self = .stateChangeKindViewAccountIdType(value)
            return
        } catch {
            decodingErrors.append(".stateChangeKindViewAccountIdType: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeKindViewOneOfAccountIdType1.self)
            self = .stateChangeKindViewAccountIdType1(value)
            return
        } catch {
            decodingErrors.append(".stateChangeKindViewAccountIdType1: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeKindViewOneOfAccountIdType2.self)
            self = .stateChangeKindViewAccountIdType2(value)
            return
        } catch {
            decodingErrors.append(".stateChangeKindViewAccountIdType2: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeKindViewOneOfAccountIdType3.self)
            self = .stateChangeKindViewAccountIdType3(value)
            return
        } catch {
            decodingErrors.append(".stateChangeKindViewAccountIdType3: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for StateChangeKindView\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for StateChangeKindView:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .stateChangeKindViewAccountIdType(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .stateChangeKindViewAccountIdType1(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .stateChangeKindViewAccountIdType2(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .stateChangeKindViewAccountIdType3(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
}

// MARK: - StateChangeWithCauseView

public struct StateChangeWithCauseViewOneOfChangeType: Codable {
    public let change: InlineObject
    public let type: String

    public init(
        change: InlineObject,
        type: String
    ) {
        self.change = change
        self.type = type
    }
}

public struct StateChangeWithCauseViewOneOfChangeType1: Codable {
    public let change: InlineObject
    public let type: String

    public init(
        change: InlineObject,
        type: String
    ) {
        self.change = change
        self.type = type
    }
}

public struct StateChangeWithCauseViewOneOfChangeType2: Codable {
    public let change: InlineObject
    public let type: String

    public init(
        change: InlineObject,
        type: String
    ) {
        self.change = change
        self.type = type
    }
}

public struct StateChangeWithCauseViewOneOfChangeType3: Codable {
    public let change: InlineObject
    public let type: String

    public init(
        change: InlineObject,
        type: String
    ) {
        self.change = change
        self.type = type
    }
}

public struct StateChangeWithCauseViewOneOfChangeType4: Codable {
    public let change: InlineObject
    public let type: String

    public init(
        change: InlineObject,
        type: String
    ) {
        self.change = change
        self.type = type
    }
}

public struct StateChangeWithCauseViewOneOfChangeType5: Codable {
    public let change: InlineObject
    public let type: String

    public init(
        change: InlineObject,
        type: String
    ) {
        self.change = change
        self.type = type
    }
}

public struct StateChangeWithCauseViewOneOfChangeType6: Codable {
    public let change: InlineObject
    public let type: String

    public init(
        change: InlineObject,
        type: String
    ) {
        self.change = change
        self.type = type
    }
}

public struct StateChangeWithCauseViewOneOfChangeType7: Codable {
    public let change: InlineObject
    public let type: String

    public init(
        change: InlineObject,
        type: String
    ) {
        self.change = change
        self.type = type
    }
}

public struct StateChangeWithCauseViewOneOfChangeType8: Codable {
    public let change: InlineObject
    public let type: String

    public init(
        change: InlineObject,
        type: String
    ) {
        self.change = change
        self.type = type
    }
}

public struct StateChangeWithCauseViewOneOfChangeType9: Codable {
    public let change: InlineObject
    public let type: String

    public init(
        change: InlineObject,
        type: String
    ) {
        self.change = change
        self.type = type
    }
}

public struct StateChangeWithCauseViewOneOfChangeType10: Codable {
    public let change: InlineObject
    public let type: String

    public init(
        change: InlineObject,
        type: String
    ) {
        self.change = change
        self.type = type
    }
}

public enum StateChangeWithCauseView: Codable {
    case stateChangeWithCauseViewChangeType(StateChangeWithCauseViewOneOfChangeType)
    case stateChangeWithCauseViewChangeType1(StateChangeWithCauseViewOneOfChangeType1)
    case stateChangeWithCauseViewChangeType2(StateChangeWithCauseViewOneOfChangeType2)
    case stateChangeWithCauseViewChangeType3(StateChangeWithCauseViewOneOfChangeType3)
    case stateChangeWithCauseViewChangeType4(StateChangeWithCauseViewOneOfChangeType4)
    case stateChangeWithCauseViewChangeType5(StateChangeWithCauseViewOneOfChangeType5)
    case stateChangeWithCauseViewChangeType6(StateChangeWithCauseViewOneOfChangeType6)
    case stateChangeWithCauseViewChangeType7(StateChangeWithCauseViewOneOfChangeType7)
    case stateChangeWithCauseViewChangeType8(StateChangeWithCauseViewOneOfChangeType8)
    case stateChangeWithCauseViewChangeType9(StateChangeWithCauseViewOneOfChangeType9)
    case stateChangeWithCauseViewChangeType10(StateChangeWithCauseViewOneOfChangeType10)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeWithCauseViewOneOfChangeType.self)
            self = .stateChangeWithCauseViewChangeType(value)
            return
        } catch {
            decodingErrors.append(".stateChangeWithCauseViewChangeType: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeWithCauseViewOneOfChangeType1.self)
            self = .stateChangeWithCauseViewChangeType1(value)
            return
        } catch {
            decodingErrors.append(".stateChangeWithCauseViewChangeType1: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeWithCauseViewOneOfChangeType2.self)
            self = .stateChangeWithCauseViewChangeType2(value)
            return
        } catch {
            decodingErrors.append(".stateChangeWithCauseViewChangeType2: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeWithCauseViewOneOfChangeType3.self)
            self = .stateChangeWithCauseViewChangeType3(value)
            return
        } catch {
            decodingErrors.append(".stateChangeWithCauseViewChangeType3: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeWithCauseViewOneOfChangeType4.self)
            self = .stateChangeWithCauseViewChangeType4(value)
            return
        } catch {
            decodingErrors.append(".stateChangeWithCauseViewChangeType4: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeWithCauseViewOneOfChangeType5.self)
            self = .stateChangeWithCauseViewChangeType5(value)
            return
        } catch {
            decodingErrors.append(".stateChangeWithCauseViewChangeType5: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeWithCauseViewOneOfChangeType6.self)
            self = .stateChangeWithCauseViewChangeType6(value)
            return
        } catch {
            decodingErrors.append(".stateChangeWithCauseViewChangeType6: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeWithCauseViewOneOfChangeType7.self)
            self = .stateChangeWithCauseViewChangeType7(value)
            return
        } catch {
            decodingErrors.append(".stateChangeWithCauseViewChangeType7: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeWithCauseViewOneOfChangeType8.self)
            self = .stateChangeWithCauseViewChangeType8(value)
            return
        } catch {
            decodingErrors.append(".stateChangeWithCauseViewChangeType8: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeWithCauseViewOneOfChangeType9.self)
            self = .stateChangeWithCauseViewChangeType9(value)
            return
        } catch {
            decodingErrors.append(".stateChangeWithCauseViewChangeType9: \(describeDecodingError(error))")
        }
        do {
            let value = try decoder.singleValueContainer().decode(StateChangeWithCauseViewOneOfChangeType10.self)
            self = .stateChangeWithCauseViewChangeType10(value)
            return
        } catch {
            decodingErrors.append(".stateChangeWithCauseViewChangeType10: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for StateChangeWithCauseView\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for StateChangeWithCauseView:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .stateChangeWithCauseViewChangeType(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .stateChangeWithCauseViewChangeType1(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .stateChangeWithCauseViewChangeType2(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .stateChangeWithCauseViewChangeType3(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .stateChangeWithCauseViewChangeType4(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .stateChangeWithCauseViewChangeType5(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .stateChangeWithCauseViewChangeType6(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .stateChangeWithCauseViewChangeType7(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .stateChangeWithCauseViewChangeType8(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .stateChangeWithCauseViewChangeType9(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        case let .stateChangeWithCauseViewChangeType10(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
}

// MARK: - StorageError

public enum StorageError: Codable {
    case storageInternalError
    case missingTrieValue(MissingTrieValue)
    case unexpectedTrieValue
    case storageInconsistentState(String)
    case flatStorageBlockNotSupported(String)
    case memTrieLoadingError(String)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "StorageInternalError" {
            self = .storageInternalError
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("MissingTrieValue") == .orderedSame
                    }) {
                    let value = try container.decode(MissingTrieValue.self, forKey: matchingKey)
                    self = .missingTrieValue(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".missingTrieValue: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "UnexpectedTrieValue" {
            self = .unexpectedTrieValue
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("StorageInconsistentState") == .orderedSame
                    }) {
                    let value = try container.decode(String.self, forKey: matchingKey)
                    self = .storageInconsistentState(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".storageInconsistentState: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("FlatStorageBlockNotSupported") == .orderedSame
                    }) {
                    let value = try container.decode(String.self, forKey: matchingKey)
                    self = .flatStorageBlockNotSupported(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".flatStorageBlockNotSupported: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("MemTrieLoadingError") == .orderedSame
                    }) {
                    let value = try container.decode(String.self, forKey: matchingKey)
                    self = .memTrieLoadingError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".memTrieLoadingError: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for StorageError\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for StorageError:\n" + decodingErrors
                .joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case missingTrieValue = "MissingTrieValue"
        case storageInconsistentState = "StorageInconsistentState"
        case flatStorageBlockNotSupported = "FlatStorageBlockNotSupported"
        case memTrieLoadingError = "MemTrieLoadingError"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .missingTrieValue(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .missingTrieValue)
        case let .storageInconsistentState(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .storageInconsistentState)
        case let .flatStorageBlockNotSupported(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .flatStorageBlockNotSupported)
        case let .memTrieLoadingError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .memTrieLoadingError)
        case .storageInternalError:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("StorageInternalError")
        case .unexpectedTrieValue:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("UnexpectedTrieValue")
        }
    }
}

// MARK: - SyncConfig

public enum SyncConfig: Codable {
    case peers
    case externalStorage(ExternalStorageConfig)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "Peers" {
            self = .peers
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("ExternalStorage") == .orderedSame
                    }) {
                    let value = try container.decode(ExternalStorageConfig.self, forKey: matchingKey)
                    self = .externalStorage(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".externalStorage: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for SyncConfig\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for SyncConfig:\n" + decodingErrors
                .joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case externalStorage = "ExternalStorage"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .externalStorage(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .externalStorage)
        case .peers:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("Peers")
        }
    }
}

// MARK: - TrackedShardsConfig

public enum TrackedShardsConfig: Codable {
    case noShards
    case shards([ShardUId])
    case allShards
    case shadowValidator(AccountId)
    case schedule([[ShardId]])
    case accounts([AccountId])

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "NoShards" {
            self = .noShards
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("Shards") == .orderedSame }) {
                    let value = try container.decode([ShardUId].self, forKey: matchingKey)
                    self = .shards(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".shards: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "AllShards" {
            self = .allShards
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("ShadowValidator") == .orderedSame
                    }) {
                    let value = try container.decode(AccountId.self, forKey: matchingKey)
                    self = .shadowValidator(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".shadowValidator: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("Schedule") == .orderedSame }) {
                    let value = try container.decode([[ShardId]].self, forKey: matchingKey)
                    self = .schedule(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".schedule: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("Accounts") == .orderedSame }) {
                    let value = try container.decode([AccountId].self, forKey: matchingKey)
                    self = .accounts(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".accounts: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for TrackedShardsConfig\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for TrackedShardsConfig:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case shards = "Shards"
        case shadowValidator = "ShadowValidator"
        case schedule = "Schedule"
        case accounts = "Accounts"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .shards(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .shards)
        case let .shadowValidator(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .shadowValidator)
        case let .schedule(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .schedule)
        case let .accounts(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .accounts)
        case .noShards:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("NoShards")
        case .allShards:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("AllShards")
        }
    }
}

// MARK: - TxExecutionError

public enum TxExecutionError: Codable {
    case actionError(ActionError)
    case invalidTxError(InvalidTxError)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("ActionError") == .orderedSame }) {
                    let value = try container.decode(ActionError.self, forKey: matchingKey)
                    self = .actionError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".actionError: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("InvalidTxError") == .orderedSame }) {
                    let value = try container.decode(InvalidTxError.self, forKey: matchingKey)
                    self = .invalidTxError(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".invalidTxError: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for TxExecutionError\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for TxExecutionError:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case actionError = "ActionError"
        case invalidTxError = "InvalidTxError"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .actionError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .actionError)
        case let .invalidTxError(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .invalidTxError)
        }
    }
}

// MARK: - TxExecutionStatus

public enum TxExecutionStatus: Codable {
    case none
    case included
    case executedOPTIMISTIC
    case includedFINAL
    case executed
    case final

    public init(from decoder: Decoder) throws {
        let decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "NONE" {
            self = .none
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "INCLUDED" {
            self = .included
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "EXECUTED_OPTIMISTIC" {
            self = .executedOPTIMISTIC
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "INCLUDED_FINAL" {
            self = .includedFINAL
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "EXECUTED" {
            self = .executed
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "FINAL" {
            self = .final
            return
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for TxExecutionStatus\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for TxExecutionStatus:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .none:
            var container = encoder.singleValueContainer()
            try container.encode("NONE")
        case .included:
            var container = encoder.singleValueContainer()
            try container.encode("INCLUDED")
        case .executedOPTIMISTIC:
            var container = encoder.singleValueContainer()
            try container.encode("EXECUTED_OPTIMISTIC")
        case .includedFINAL:
            var container = encoder.singleValueContainer()
            try container.encode("INCLUDED_FINAL")
        case .executed:
            var container = encoder.singleValueContainer()
            try container.encode("EXECUTED")
        case .final:
            var container = encoder.singleValueContainer()
            try container.encode("FINAL")
        }
    }
}

// MARK: - VMKind

public enum VMKind: Codable {
    case wasmer0
    case wasmtime
    case wasmer2
    case nearVm

    public init(from decoder: Decoder) throws {
        let decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "Wasmer0" {
            self = .wasmer0
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "Wasmtime" {
            self = .wasmtime
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "Wasmer2" {
            self = .wasmer2
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "NearVm" {
            self = .nearVm
            return
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for VMKind\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for VMKind:\n" + decodingErrors
                .joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .wasmer0:
            var container = encoder.singleValueContainer()
            try container.encode("Wasmer0")
        case .wasmtime:
            var container = encoder.singleValueContainer()
            try container.encode("Wasmtime")
        case .wasmer2:
            var container = encoder.singleValueContainer()
            try container.encode("Wasmer2")
        case .nearVm:
            var container = encoder.singleValueContainer()
            try container.encode("NearVm")
        }
    }
}

// MARK: - ValidatorKickoutReason

public struct ValidatorKickoutReasonOneOfNotEnoughBlocksInline: Codable {
    public let expected: UInt64
    public let produced: UInt64

    public init(
        expected: UInt64,
        produced: UInt64
    ) {
        self.expected = expected
        self.produced = produced
    }
}

public struct ValidatorKickoutReasonOneOfNotEnoughChunksInline: Codable {
    public let expected: UInt64
    public let produced: UInt64

    public init(
        expected: UInt64,
        produced: UInt64
    ) {
        self.expected = expected
        self.produced = produced
    }
}

public struct ValidatorKickoutReasonOneOfNotEnoughStakeInline: Codable {
    public let stakeU128: NearToken
    public let thresholdU128: NearToken

    public init(
        stakeU128: NearToken,
        thresholdU128: NearToken
    ) {
        self.stakeU128 = stakeU128
        self.thresholdU128 = thresholdU128
    }
}

public struct ValidatorKickoutReasonOneOfNotEnoughChunkEndorsementsInline: Codable {
    public let expected: UInt64
    public let produced: UInt64

    public init(
        expected: UInt64,
        produced: UInt64
    ) {
        self.expected = expected
        self.produced = produced
    }
}

public struct ValidatorKickoutReasonOneOfProtocolVersionTooOldInline: Codable {
    public let networkVersion: Int
    public let version: Int

    public init(
        networkVersion: Int,
        version: Int
    ) {
        self.networkVersion = networkVersion
        self.version = version
    }
}

public enum ValidatorKickoutReason: Codable {
    case UnusedSlashed
    case notEnoughBlocks(ValidatorKickoutReasonOneOfNotEnoughBlocksInline)
    case notEnoughChunks(ValidatorKickoutReasonOneOfNotEnoughChunksInline)
    case unstaked
    case notEnoughStake(ValidatorKickoutReasonOneOfNotEnoughStakeInline)
    case didNotGetASeat
    case notEnoughChunkEndorsements(ValidatorKickoutReasonOneOfNotEnoughChunkEndorsementsInline)
    case protocolVersionTooOld(ValidatorKickoutReasonOneOfProtocolVersionTooOldInline)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "_UnusedSlashed" {
            self = .UnusedSlashed
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("NotEnoughBlocks") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ValidatorKickoutReasonOneOfNotEnoughBlocksInline.self,
                        forKey: matchingKey
                    )
                    self = .notEnoughBlocks(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".notEnoughBlocks: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("NotEnoughChunks") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ValidatorKickoutReasonOneOfNotEnoughChunksInline.self,
                        forKey: matchingKey
                    )
                    self = .notEnoughChunks(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".notEnoughChunks: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "Unstaked" {
            self = .unstaked
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in key.stringValue.caseInsensitiveCompare("NotEnoughStake") == .orderedSame }) {
                    let value = try container.decode(
                        ValidatorKickoutReasonOneOfNotEnoughStakeInline.self,
                        forKey: matchingKey
                    )
                    self = .notEnoughStake(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".notEnoughStake: \(describeDecodingError(error))")
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "DidNotGetASeat" {
            self = .didNotGetASeat
            return
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("NotEnoughChunkEndorsements") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ValidatorKickoutReasonOneOfNotEnoughChunkEndorsementsInline.self,
                        forKey: matchingKey
                    )
                    self = .notEnoughChunkEndorsements(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".notEnoughChunkEndorsements: \(describeDecodingError(error))")
        }
        do {
            if let container = anyKeyContainer {
                if let matchingKey = container.allKeys
                    .first(where: { key in
                        key.stringValue.caseInsensitiveCompare("ProtocolVersionTooOld") == .orderedSame
                    }) {
                    let value = try container.decode(
                        ValidatorKickoutReasonOneOfProtocolVersionTooOldInline.self,
                        forKey: matchingKey
                    )
                    self = .protocolVersionTooOld(value)
                    return
                }
            }
        } catch {
            decodingErrors.append(".protocolVersionTooOld: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ValidatorKickoutReason\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ValidatorKickoutReason:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    enum CodingKeys: String, CodingKey {
        case notEnoughBlocks = "NotEnoughBlocks"
        case notEnoughChunks = "NotEnoughChunks"
        case notEnoughStake = "NotEnoughStake"
        case notEnoughChunkEndorsements = "NotEnoughChunkEndorsements"
        case protocolVersionTooOld = "ProtocolVersionTooOld"
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .notEnoughBlocks(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .notEnoughBlocks)
        case let .notEnoughChunks(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .notEnoughChunks)
        case let .notEnoughStake(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .notEnoughStake)
        case let .notEnoughChunkEndorsements(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .notEnoughChunkEndorsements)
        case let .protocolVersionTooOld(value):
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .protocolVersionTooOld)
        case .UnusedSlashed:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("_UnusedSlashed")
        case .unstaked:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("Unstaked")
        case .didNotGetASeat:
            var singleContainer = encoder.singleValueContainer()
            try singleContainer.encode("DidNotGetASeat")
        }
    }
}

// MARK: - ValidatorStakeView

public struct ValidatorStakeViewOneOfAccountIdPublicKeyStake: Codable {
    public let accountId: AccountId
    public let publicKey: PublicKey
    public let stake: NearToken

    public init(
        accountId: AccountId,
        publicKey: PublicKey,
        stake: NearToken
    ) {
        self.accountId = accountId
        self.publicKey = publicKey
        self.stake = stake
    }
}

public enum ValidatorStakeView: Codable {
    case validatorStakeViewAccountIdPublicKeyStake(ValidatorStakeViewOneOfAccountIdPublicKeyStake)

    public init(from decoder: Decoder) throws {
        var decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        do {
            let value = try decoder.singleValueContainer().decode(ValidatorStakeViewOneOfAccountIdPublicKeyStake.self)
            self = .validatorStakeViewAccountIdPublicKeyStake(value)
            return
        } catch {
            decodingErrors.append(".validatorStakeViewAccountIdPublicKeyStake: \(describeDecodingError(error))")
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ValidatorStakeView\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for ValidatorStakeView:\n" +
                decodingErrors.joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .validatorStakeViewAccountIdPublicKeyStake(value):
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
}

// MARK: - WasmTrap

public enum WasmTrap: Codable {
    case unreachable
    case incorrectCallIndirectSignature
    case memoryOutOfBounds
    case callIndirectOOB
    case illegalArithmetic
    case misalignedAtomicAccess
    case indirectCallToNull
    case stackOverflow
    case genericTrap

    public init(from decoder: Decoder) throws {
        let decodingErrors: [String] = []
        let anyKeyContainer = try? decoder.container(keyedBy: AnyCodingKey.self)
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "Unreachable" {
            self = .unreachable
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self),
           value == "IncorrectCallIndirectSignature" {
            self = .incorrectCallIndirectSignature
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "MemoryOutOfBounds" {
            self = .memoryOutOfBounds
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "CallIndirectOOB" {
            self = .callIndirectOOB
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "IllegalArithmetic" {
            self = .illegalArithmetic
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "MisalignedAtomicAccess" {
            self = .misalignedAtomicAccess
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "IndirectCallToNull" {
            self = .indirectCallToNull
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "StackOverflow" {
            self = .stackOverflow
            return
        }
        if let value = try? decoder.singleValueContainer().decode(String.self), value == "GenericTrap" {
            self = .genericTrap
            return
        }
        let contextDescription: String
        if decodingErrors.isEmpty {
            let availableKeys: String
            if let keys = anyKeyContainer?.allKeys, !keys.isEmpty {
                let joined = keys.map { "\($0.stringValue)" }.joined(separator: ", ")
                availableKeys = " Available keys: [\(joined)]"
            } else {
                availableKeys = ""
            }
            contextDescription = "Could not decode any of the oneOf/anyOf variants for WasmTrap\(availableKeys)"
        } else {
            contextDescription = "Could not decode any of the oneOf/anyOf variants for WasmTrap:\n" + decodingErrors
                .joined(separator: "\n")
        }
        throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: contextDescription))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .unreachable:
            var container = encoder.singleValueContainer()
            try container.encode("Unreachable")
        case .incorrectCallIndirectSignature:
            var container = encoder.singleValueContainer()
            try container.encode("IncorrectCallIndirectSignature")
        case .memoryOutOfBounds:
            var container = encoder.singleValueContainer()
            try container.encode("MemoryOutOfBounds")
        case .callIndirectOOB:
            var container = encoder.singleValueContainer()
            try container.encode("CallIndirectOOB")
        case .illegalArithmetic:
            var container = encoder.singleValueContainer()
            try container.encode("IllegalArithmetic")
        case .misalignedAtomicAccess:
            var container = encoder.singleValueContainer()
            try container.encode("MisalignedAtomicAccess")
        case .indirectCallToNull:
            var container = encoder.singleValueContainer()
            try container.encode("IndirectCallToNull")
        case .stackOverflow:
            var container = encoder.singleValueContainer()
            try container.encode("StackOverflow")
        case .genericTrap:
            var container = encoder.singleValueContainer()
            try container.encode("GenericTrap")
        }
    }
}

// MARK: - EpochId

public typealias EpochId = CryptoHash

// MARK: - PeerId

public typealias PeerId = PublicKey

// MARK: - AccessKey

public struct AccessKey: Codable {
    public let nonce: UInt64
    public let permission: AccessKeyPermission

    public init(
        nonce: UInt64,
        permission: AccessKeyPermission
    ) {
        self.nonce = nonce
        self.permission = permission
    }
}

// MARK: - AccessKeyCreationConfigView

public struct AccessKeyCreationConfigView: Codable {
    public let fullAccessCost: Fee
    public let functionCallCost: Fee
    public let functionCallCostPerByte: Fee

    public init(
        fullAccessCost: Fee,
        functionCallCost: Fee,
        functionCallCostPerByte: Fee
    ) {
        self.fullAccessCost = fullAccessCost
        self.functionCallCost = functionCallCost
        self.functionCallCostPerByte = functionCallCostPerByte
    }
}

// MARK: - AccessKeyInfoView

public struct AccessKeyInfoView: Codable {
    public let accessKey: AccessKeyView
    public let publicKey: PublicKey

    public init(
        accessKey: AccessKeyView,
        publicKey: PublicKey
    ) {
        self.accessKey = accessKey
        self.publicKey = publicKey
    }
}

// MARK: - AccessKeyList

public struct AccessKeyList: Codable {
    public let keys: [AccessKeyInfoView]

    public init(
        keys: [AccessKeyInfoView]
    ) {
        self.keys = keys
    }
}

// MARK: - AccessKeyView

public struct AccessKeyView: Codable {
    public let nonce: UInt64
    public let permission: AccessKeyPermissionView

    public init(
        nonce: UInt64,
        permission: AccessKeyPermissionView
    ) {
        self.nonce = nonce
        self.permission = permission
    }
}

// MARK: - AccountCreationConfigView

public struct AccountCreationConfigView: Codable {
    public let minAllowedTopLevelAccountLength: Int
    public let registrarAccountId: AccountId

    public init(
        minAllowedTopLevelAccountLength: Int,
        registrarAccountId: AccountId
    ) {
        self.minAllowedTopLevelAccountLength = minAllowedTopLevelAccountLength
        self.registrarAccountId = registrarAccountId
    }
}

// MARK: - AccountDataView

public struct AccountDataView: Codable {
    public let accountKey: PublicKey
    public let peerId: PublicKey
    public let proxies: [Tier1ProxyView]
    public let timestamp: String

    public init(
        accountKey: PublicKey,
        peerId: PublicKey,
        proxies: [Tier1ProxyView],
        timestamp: String
    ) {
        self.accountKey = accountKey
        self.peerId = peerId
        self.proxies = proxies
        self.timestamp = timestamp
    }
}

// MARK: - AccountInfo

public struct AccountInfo: Codable {
    public let accountId: AccountId
    public let amount: NearToken
    public let publicKey: PublicKey

    public init(
        accountId: AccountId,
        amount: NearToken,
        publicKey: PublicKey
    ) {
        self.accountId = accountId
        self.amount = amount
        self.publicKey = publicKey
    }
}

// MARK: - AccountView

public struct AccountView: Codable {
    public let amount: NearToken
    public let codeHash: CryptoHash
    public let globalContractAccountId: AccountId?
    public let globalContractHash: CryptoHash?
    public let locked: NearToken
    public let storagePaidAt: UInt64?
    public let storageUsage: UInt64

    public init(
        amount: NearToken,
        codeHash: CryptoHash,
        globalContractAccountId: AccountId?,
        globalContractHash: CryptoHash?,
        locked: NearToken,
        storagePaidAt: UInt64?,
        storageUsage: UInt64
    ) {
        self.amount = amount
        self.codeHash = codeHash
        self.globalContractAccountId = globalContractAccountId
        self.globalContractHash = globalContractHash
        self.locked = locked
        self.storagePaidAt = storagePaidAt
        self.storageUsage = storageUsage
    }
}

// MARK: - AccountWithPublicKey

public struct AccountWithPublicKey: Codable {
    public let accountId: AccountId
    public let publicKey: PublicKey

    public init(
        accountId: AccountId,
        publicKey: PublicKey
    ) {
        self.accountId = accountId
        self.publicKey = publicKey
    }
}

// MARK: - ActionCreationConfigView

public struct ActionCreationConfigView: Codable {
    public let addKeyCost: AccessKeyCreationConfigView
    public let createAccountCost: Fee
    public let delegateCost: Fee
    public let deleteAccountCost: Fee
    public let deleteKeyCost: Fee
    public let deployContractCost: Fee
    public let deployContractCostPerByte: Fee
    public let functionCallCost: Fee
    public let functionCallCostPerByte: Fee
    public let stakeCost: Fee
    public let transferCost: Fee

    public init(
        addKeyCost: AccessKeyCreationConfigView,
        createAccountCost: Fee,
        delegateCost: Fee,
        deleteAccountCost: Fee,
        deleteKeyCost: Fee,
        deployContractCost: Fee,
        deployContractCostPerByte: Fee,
        functionCallCost: Fee,
        functionCallCostPerByte: Fee,
        stakeCost: Fee,
        transferCost: Fee
    ) {
        self.addKeyCost = addKeyCost
        self.createAccountCost = createAccountCost
        self.delegateCost = delegateCost
        self.deleteAccountCost = deleteAccountCost
        self.deleteKeyCost = deleteKeyCost
        self.deployContractCost = deployContractCost
        self.deployContractCostPerByte = deployContractCostPerByte
        self.functionCallCost = functionCallCost
        self.functionCallCostPerByte = functionCallCostPerByte
        self.stakeCost = stakeCost
        self.transferCost = transferCost
    }
}

// MARK: - ActionError

public struct ActionError: Codable {
    public let index: UInt64?
    public let kind: ActionErrorKind

    public init(
        index: UInt64?,
        kind: ActionErrorKind
    ) {
        self.index = index
        self.kind = kind
    }
}

// MARK: - AddKeyAction

public struct AddKeyAction: Codable {
    public let accessKey: AccessKey
    public let publicKey: PublicKey

    public init(
        accessKey: AccessKey,
        publicKey: PublicKey
    ) {
        self.accessKey = accessKey
        self.publicKey = publicKey
    }
}

// MARK: - BandwidthRequest

public struct BandwidthRequest: Codable {
    public let requestedValuesBitmap: BandwidthRequestBitmap
    public let toShard: Int

    public init(
        requestedValuesBitmap: BandwidthRequestBitmap,
        toShard: Int
    ) {
        self.requestedValuesBitmap = requestedValuesBitmap
        self.toShard = toShard
    }
}

// MARK: - BandwidthRequestBitmap

public struct BandwidthRequestBitmap: Codable {
    public let data: [Int]

    public init(
        data: [Int]
    ) {
        self.data = data
    }
}

// MARK: - BandwidthRequestsV1

public struct BandwidthRequestsV1: Codable {
    public let requests: [BandwidthRequest]

    public init(
        requests: [BandwidthRequest]
    ) {
        self.requests = requests
    }
}

// MARK: - BlockHeaderInnerLiteView

public struct BlockHeaderInnerLiteView: Codable {
    public let blockMerkleRoot: CryptoHash
    public let epochId: CryptoHash
    public let height: UInt64
    public let nextBpHash: CryptoHash
    public let nextEpochId: CryptoHash
    public let outcomeRoot: CryptoHash
    public let prevStateRoot: CryptoHash
    public let timestamp: UInt64
    public let timestampNanosec: String

    public init(
        blockMerkleRoot: CryptoHash,
        epochId: CryptoHash,
        height: UInt64,
        nextBpHash: CryptoHash,
        nextEpochId: CryptoHash,
        outcomeRoot: CryptoHash,
        prevStateRoot: CryptoHash,
        timestamp: UInt64,
        timestampNanosec: String
    ) {
        self.blockMerkleRoot = blockMerkleRoot
        self.epochId = epochId
        self.height = height
        self.nextBpHash = nextBpHash
        self.nextEpochId = nextEpochId
        self.outcomeRoot = outcomeRoot
        self.prevStateRoot = prevStateRoot
        self.timestamp = timestamp
        self.timestampNanosec = timestampNanosec
    }
}

// MARK: - BlockHeaderView

public struct BlockHeaderView: Codable {
    public let approvals: [Signature?]
    public let blockBodyHash: CryptoHash?
    public let blockMerkleRoot: CryptoHash
    public let blockOrdinal: UInt64?
    public let challengesResult: [SlashedValidator]
    public let challengesRoot: CryptoHash
    public let chunkEndorsements: [[Int]]?
    public let chunkHeadersRoot: CryptoHash
    public let chunkMask: [Bool]
    public let chunkReceiptsRoot: CryptoHash
    public let chunkTxRoot: CryptoHash
    public let chunksIncluded: UInt64
    public let epochId: CryptoHash
    public let epochSyncDataHash: CryptoHash?
    public let gasPrice: NearToken
    public let hash: CryptoHash
    public let height: UInt64
    public let lastDsFinalBlock: CryptoHash
    public let lastFinalBlock: CryptoHash
    public let latestProtocolVersion: Int
    public let nextBpHash: CryptoHash
    public let nextEpochId: CryptoHash
    public let outcomeRoot: CryptoHash
    public let prevHash: CryptoHash
    public let prevHeight: UInt64?
    public let prevStateRoot: CryptoHash
    public let randomValue: CryptoHash
    public let rentPaid: NearToken?
    public let signature: Signature
    public let timestamp: UInt64
    public let timestampNanosec: String
    public let totalSupply: NearToken
    public let validatorProposals: [ValidatorStakeView]
    public let validatorReward: NearToken?

    public init(
        approvals: [Signature?],
        blockBodyHash: CryptoHash?,
        blockMerkleRoot: CryptoHash,
        blockOrdinal: UInt64?,
        challengesResult: [SlashedValidator],
        challengesRoot: CryptoHash,
        chunkEndorsements: [[Int]]?,
        chunkHeadersRoot: CryptoHash,
        chunkMask: [Bool],
        chunkReceiptsRoot: CryptoHash,
        chunkTxRoot: CryptoHash,
        chunksIncluded: UInt64,
        epochId: CryptoHash,
        epochSyncDataHash: CryptoHash?,
        gasPrice: NearToken,
        hash: CryptoHash,
        height: UInt64,
        lastDsFinalBlock: CryptoHash,
        lastFinalBlock: CryptoHash,
        latestProtocolVersion: Int,
        nextBpHash: CryptoHash,
        nextEpochId: CryptoHash,
        outcomeRoot: CryptoHash,
        prevHash: CryptoHash,
        prevHeight: UInt64?,
        prevStateRoot: CryptoHash,
        randomValue: CryptoHash,
        rentPaid: NearToken?,
        signature: Signature,
        timestamp: UInt64,
        timestampNanosec: String,
        totalSupply: NearToken,
        validatorProposals: [ValidatorStakeView],
        validatorReward: NearToken?
    ) {
        self.approvals = approvals
        self.blockBodyHash = blockBodyHash
        self.blockMerkleRoot = blockMerkleRoot
        self.blockOrdinal = blockOrdinal
        self.challengesResult = challengesResult
        self.challengesRoot = challengesRoot
        self.chunkEndorsements = chunkEndorsements
        self.chunkHeadersRoot = chunkHeadersRoot
        self.chunkMask = chunkMask
        self.chunkReceiptsRoot = chunkReceiptsRoot
        self.chunkTxRoot = chunkTxRoot
        self.chunksIncluded = chunksIncluded
        self.epochId = epochId
        self.epochSyncDataHash = epochSyncDataHash
        self.gasPrice = gasPrice
        self.hash = hash
        self.height = height
        self.lastDsFinalBlock = lastDsFinalBlock
        self.lastFinalBlock = lastFinalBlock
        self.latestProtocolVersion = latestProtocolVersion
        self.nextBpHash = nextBpHash
        self.nextEpochId = nextEpochId
        self.outcomeRoot = outcomeRoot
        self.prevHash = prevHash
        self.prevHeight = prevHeight
        self.prevStateRoot = prevStateRoot
        self.randomValue = randomValue
        self.rentPaid = rentPaid
        self.signature = signature
        self.timestamp = timestamp
        self.timestampNanosec = timestampNanosec
        self.totalSupply = totalSupply
        self.validatorProposals = validatorProposals
        self.validatorReward = validatorReward
    }
}

// MARK: - BlockStatusView

public struct BlockStatusView: Codable {
    public let hash: CryptoHash
    public let height: UInt64

    public init(
        hash: CryptoHash,
        height: UInt64
    ) {
        self.hash = hash
        self.height = height
    }
}

// MARK: - CallResult

public struct CallResult: Codable {
    public let logs: [String]
    public let result: [Int]

    public init(
        logs: [String],
        result: [Int]
    ) {
        self.logs = logs
        self.result = result
    }
}

// MARK: - CatchupStatusView

public struct CatchupStatusView: Codable {
    public let blocksToCatchup: [BlockStatusView]
    public let shardSyncStatus: AnyCodable
    public let syncBlockHash: CryptoHash
    public let syncBlockHeight: UInt64

    public init(
        blocksToCatchup: [BlockStatusView],
        shardSyncStatus: AnyCodable,
        syncBlockHash: CryptoHash,
        syncBlockHeight: UInt64
    ) {
        self.blocksToCatchup = blocksToCatchup
        self.shardSyncStatus = shardSyncStatus
        self.syncBlockHash = syncBlockHash
        self.syncBlockHeight = syncBlockHeight
    }
}

// MARK: - ChunkDistributionNetworkConfig

public struct ChunkDistributionNetworkConfig: Codable {
    public let enabled: Bool
    public let uris: ChunkDistributionUris

    public init(
        enabled: Bool,
        uris: ChunkDistributionUris
    ) {
        self.enabled = enabled
        self.uris = uris
    }
}

// MARK: - ChunkDistributionUris

public struct ChunkDistributionUris: Codable {
    public let get: String
    public let set: String

    public init(
        get: String,
        set: String
    ) {
        self.get = get
        self.set = set
    }
}

// MARK: - ChunkHeaderView

public struct ChunkHeaderView: Codable {
    public let balanceBurnt: NearToken
    public let bandwidthRequests: BandwidthRequests?
    public let chunkHash: CryptoHash
    public let congestionInfo: CongestionInfoView?
    public let encodedLength: UInt64
    public let encodedMerkleRoot: CryptoHash
    public let gasLimit: NearGas
    public let gasUsed: NearGas
    public let heightCreated: UInt64
    public let heightIncluded: UInt64
    public let outcomeRoot: CryptoHash
    public let outgoingReceiptsRoot: CryptoHash
    public let prevBlockHash: CryptoHash
    public let prevStateRoot: CryptoHash
    public let rentPaid: NearToken?
    public let shardId: ShardId
    public let signature: Signature
    public let txRoot: CryptoHash
    public let validatorProposals: [ValidatorStakeView]
    public let validatorReward: NearToken?

    public init(
        balanceBurnt: NearToken,
        bandwidthRequests: BandwidthRequests?,
        chunkHash: CryptoHash,
        congestionInfo: CongestionInfoView?,
        encodedLength: UInt64,
        encodedMerkleRoot: CryptoHash,
        gasLimit: NearGas,
        gasUsed: NearGas,
        heightCreated: UInt64,
        heightIncluded: UInt64,
        outcomeRoot: CryptoHash,
        outgoingReceiptsRoot: CryptoHash,
        prevBlockHash: CryptoHash,
        prevStateRoot: CryptoHash,
        rentPaid: NearToken?,
        shardId: ShardId,
        signature: Signature,
        txRoot: CryptoHash,
        validatorProposals: [ValidatorStakeView],
        validatorReward: NearToken?
    ) {
        self.balanceBurnt = balanceBurnt
        self.bandwidthRequests = bandwidthRequests
        self.chunkHash = chunkHash
        self.congestionInfo = congestionInfo
        self.encodedLength = encodedLength
        self.encodedMerkleRoot = encodedMerkleRoot
        self.gasLimit = gasLimit
        self.gasUsed = gasUsed
        self.heightCreated = heightCreated
        self.heightIncluded = heightIncluded
        self.outcomeRoot = outcomeRoot
        self.outgoingReceiptsRoot = outgoingReceiptsRoot
        self.prevBlockHash = prevBlockHash
        self.prevStateRoot = prevStateRoot
        self.rentPaid = rentPaid
        self.shardId = shardId
        self.signature = signature
        self.txRoot = txRoot
        self.validatorProposals = validatorProposals
        self.validatorReward = validatorReward
    }
}

// MARK: - CloudArchivalReaderConfig

public struct CloudArchivalReaderConfig: Codable {
    public let cloudStorage: CloudStorageConfig

    public init(
        cloudStorage: CloudStorageConfig
    ) {
        self.cloudStorage = cloudStorage
    }
}

// MARK: - CloudArchivalWriterConfig

public struct CloudArchivalWriterConfig: Codable {
    public let archiveBlockData: Bool?
    public let cloudStorage: CloudStorageConfig
    public let pollingInterval: DurationAsStdSchemaProvider?

    public init(
        archiveBlockData: Bool?,
        cloudStorage: CloudStorageConfig,
        pollingInterval: DurationAsStdSchemaProvider?
    ) {
        self.archiveBlockData = archiveBlockData
        self.cloudStorage = cloudStorage
        self.pollingInterval = pollingInterval
    }
}

// MARK: - CloudStorageConfig

public struct CloudStorageConfig: Codable {
    public let credentialsFile: String?
    public let storage: ExternalStorageLocation

    public init(
        credentialsFile: String?,
        storage: ExternalStorageLocation
    ) {
        self.credentialsFile = credentialsFile
        self.storage = storage
    }
}

// MARK: - CongestionControlConfigView

public struct CongestionControlConfigView: Codable {
    public let allowedShardOutgoingGas: NearGas
    public let maxCongestionIncomingGas: NearGas
    public let maxCongestionMemoryConsumption: UInt64
    public let maxCongestionMissedChunks: UInt64
    public let maxCongestionOutgoingGas: NearGas
    public let maxOutgoingGas: NearGas
    public let maxTxGas: NearGas
    public let minOutgoingGas: NearGas
    public let minTxGas: NearGas
    public let outgoingReceiptsBigSizeLimit: UInt64
    public let outgoingReceiptsUsualSizeLimit: UInt64
    public let rejectTxCongestionThreshold: Double

    public init(
        allowedShardOutgoingGas: NearGas,
        maxCongestionIncomingGas: NearGas,
        maxCongestionMemoryConsumption: UInt64,
        maxCongestionMissedChunks: UInt64,
        maxCongestionOutgoingGas: NearGas,
        maxOutgoingGas: NearGas,
        maxTxGas: NearGas,
        minOutgoingGas: NearGas,
        minTxGas: NearGas,
        outgoingReceiptsBigSizeLimit: UInt64,
        outgoingReceiptsUsualSizeLimit: UInt64,
        rejectTxCongestionThreshold: Double
    ) {
        self.allowedShardOutgoingGas = allowedShardOutgoingGas
        self.maxCongestionIncomingGas = maxCongestionIncomingGas
        self.maxCongestionMemoryConsumption = maxCongestionMemoryConsumption
        self.maxCongestionMissedChunks = maxCongestionMissedChunks
        self.maxCongestionOutgoingGas = maxCongestionOutgoingGas
        self.maxOutgoingGas = maxOutgoingGas
        self.maxTxGas = maxTxGas
        self.minOutgoingGas = minOutgoingGas
        self.minTxGas = minTxGas
        self.outgoingReceiptsBigSizeLimit = outgoingReceiptsBigSizeLimit
        self.outgoingReceiptsUsualSizeLimit = outgoingReceiptsUsualSizeLimit
        self.rejectTxCongestionThreshold = rejectTxCongestionThreshold
    }
}

// MARK: - CongestionInfoView

public struct CongestionInfoView: Codable {
    public let allowedShard: Int
    public let bufferedReceiptsGas: String
    public let delayedReceiptsGas: String
    public let receiptBytes: UInt64

    public init(
        allowedShard: Int,
        bufferedReceiptsGas: String,
        delayedReceiptsGas: String,
        receiptBytes: UInt64
    ) {
        self.allowedShard = allowedShard
        self.bufferedReceiptsGas = bufferedReceiptsGas
        self.delayedReceiptsGas = delayedReceiptsGas
        self.receiptBytes = receiptBytes
    }
}

// MARK: - ContractCodeView

public struct ContractCodeView: Codable {
    public let codeBase64: String
    public let hash: CryptoHash

    public init(
        codeBase64: String,
        hash: CryptoHash
    ) {
        self.codeBase64 = codeBase64
        self.hash = hash
    }
}

// MARK: - CostGasUsed

public struct CostGasUsed: Codable {
    public let cost: String
    public let costCategory: String
    public let gasUsed: String

    public init(
        cost: String,
        costCategory: String,
        gasUsed: String
    ) {
        self.cost = cost
        self.costCategory = costCategory
        self.gasUsed = gasUsed
    }
}

// MARK: - CreateAccountAction

public struct CreateAccountAction: Codable {
    public init() {}
}

// MARK: - CurrentEpochValidatorInfo

public struct CurrentEpochValidatorInfo: Codable {
    public let accountId: AccountId
    public let isSlashed: Bool
    public let numExpectedBlocks: UInt64
    public let numExpectedChunks: UInt64?
    public let numExpectedChunksPerShard: [UInt64]?
    public let numExpectedEndorsements: UInt64?
    public let numExpectedEndorsementsPerShard: [UInt64]?
    public let numProducedBlocks: UInt64
    public let numProducedChunks: UInt64?
    public let numProducedChunksPerShard: [UInt64]?
    public let numProducedEndorsements: UInt64?
    public let numProducedEndorsementsPerShard: [UInt64]?
    public let publicKey: PublicKey
    public let shards: [ShardId]
    public let shardsEndorsed: [ShardId]?
    public let stake: NearToken

    public init(
        accountId: AccountId,
        isSlashed: Bool,
        numExpectedBlocks: UInt64,
        numExpectedChunks: UInt64?,
        numExpectedChunksPerShard: [UInt64]?,
        numExpectedEndorsements: UInt64?,
        numExpectedEndorsementsPerShard: [UInt64]?,
        numProducedBlocks: UInt64,
        numProducedChunks: UInt64?,
        numProducedChunksPerShard: [UInt64]?,
        numProducedEndorsements: UInt64?,
        numProducedEndorsementsPerShard: [UInt64]?,
        publicKey: PublicKey,
        shards: [ShardId],
        shardsEndorsed: [ShardId]?,
        stake: NearToken
    ) {
        self.accountId = accountId
        self.isSlashed = isSlashed
        self.numExpectedBlocks = numExpectedBlocks
        self.numExpectedChunks = numExpectedChunks
        self.numExpectedChunksPerShard = numExpectedChunksPerShard
        self.numExpectedEndorsements = numExpectedEndorsements
        self.numExpectedEndorsementsPerShard = numExpectedEndorsementsPerShard
        self.numProducedBlocks = numProducedBlocks
        self.numProducedChunks = numProducedChunks
        self.numProducedChunksPerShard = numProducedChunksPerShard
        self.numProducedEndorsements = numProducedEndorsements
        self.numProducedEndorsementsPerShard = numProducedEndorsementsPerShard
        self.publicKey = publicKey
        self.shards = shards
        self.shardsEndorsed = shardsEndorsed
        self.stake = stake
    }
}

// MARK: - DataReceiptCreationConfigView

public struct DataReceiptCreationConfigView: Codable {
    public let baseCost: Fee
    public let costPerByte: Fee

    public init(
        baseCost: Fee,
        costPerByte: Fee
    ) {
        self.baseCost = baseCost
        self.costPerByte = costPerByte
    }
}

// MARK: - DataReceiverView

public struct DataReceiverView: Codable {
    public let dataId: CryptoHash
    public let receiverId: AccountId

    public init(
        dataId: CryptoHash,
        receiverId: AccountId
    ) {
        self.dataId = dataId
        self.receiverId = receiverId
    }
}

// MARK: - DelegateAction

public struct DelegateAction: Codable {
    public let actions: [NonDelegateAction]
    public let maxBlockHeight: UInt64
    public let nonce: UInt64
    public let publicKey: PublicKey
    public let receiverId: AccountId
    public let senderId: AccountId

    public init(
        actions: [NonDelegateAction],
        maxBlockHeight: UInt64,
        nonce: UInt64,
        publicKey: PublicKey,
        receiverId: AccountId,
        senderId: AccountId
    ) {
        self.actions = actions
        self.maxBlockHeight = maxBlockHeight
        self.nonce = nonce
        self.publicKey = publicKey
        self.receiverId = receiverId
        self.senderId = senderId
    }
}

// MARK: - DeleteAccountAction

public struct DeleteAccountAction: Codable {
    public let beneficiaryId: AccountId

    public init(
        beneficiaryId: AccountId
    ) {
        self.beneficiaryId = beneficiaryId
    }
}

// MARK: - DeleteKeyAction

public struct DeleteKeyAction: Codable {
    public let publicKey: PublicKey

    public init(
        publicKey: PublicKey
    ) {
        self.publicKey = publicKey
    }
}

// MARK: - DeployContractAction

public struct DeployContractAction: Codable {
    public let code: String

    public init(
        code: String
    ) {
        self.code = code
    }
}

// MARK: - DeployGlobalContractAction

public struct DeployGlobalContractAction: Codable {
    public let code: String
    public let deployMode: GlobalContractDeployMode

    public init(
        code: String,
        deployMode: GlobalContractDeployMode
    ) {
        self.code = code
        self.deployMode = deployMode
    }
}

// MARK: - DetailedDebugStatus

public struct DetailedDebugStatus: Codable {
    public let blockProductionDelayMillis: UInt64
    public let catchupStatus: [CatchupStatusView]
    public let currentHeadStatus: BlockStatusView
    public let currentHeaderHeadStatus: BlockStatusView
    public let networkInfo: NetworkInfoView
    public let syncStatus: String

    public init(
        blockProductionDelayMillis: UInt64,
        catchupStatus: [CatchupStatusView],
        currentHeadStatus: BlockStatusView,
        currentHeaderHeadStatus: BlockStatusView,
        networkInfo: NetworkInfoView,
        syncStatus: String
    ) {
        self.blockProductionDelayMillis = blockProductionDelayMillis
        self.catchupStatus = catchupStatus
        self.currentHeadStatus = currentHeadStatus
        self.currentHeaderHeadStatus = currentHeaderHeadStatus
        self.networkInfo = networkInfo
        self.syncStatus = syncStatus
    }
}

// MARK: - DeterministicAccountStateInitV1

public struct DeterministicAccountStateInitV1: Codable {
    public let code: GlobalContractIdentifier
    public let data: [String: String]

    public init(
        code: GlobalContractIdentifier,
        data: [String: String]
    ) {
        self.code = code
        self.data = data
    }
}

// MARK: - DeterministicStateInitAction

public struct DeterministicStateInitAction: Codable {
    public let deposit: NearToken
    public let stateInit: DeterministicAccountStateInit

    public init(
        deposit: NearToken,
        stateInit: DeterministicAccountStateInit
    ) {
        self.deposit = deposit
        self.stateInit = stateInit
    }
}

// MARK: - DumpConfig

public struct DumpConfig: Codable {
    public let credentialsFile: String?
    public let iterationDelay: DurationAsStdSchemaProvider?
    public let location: ExternalStorageLocation
    public let restartDumpForShards: [ShardId]?

    public init(
        credentialsFile: String?,
        iterationDelay: DurationAsStdSchemaProvider?,
        location: ExternalStorageLocation,
        restartDumpForShards: [ShardId]?
    ) {
        self.credentialsFile = credentialsFile
        self.iterationDelay = iterationDelay
        self.location = location
        self.restartDumpForShards = restartDumpForShards
    }
}

// MARK: - DurationAsStdSchemaProvider

public struct DurationAsStdSchemaProvider: Codable {
    public let nanos: Int32
    public let secs: Int64

    public init(
        nanos: Int32,
        secs: Int64
    ) {
        self.nanos = nanos
        self.secs = secs
    }
}

// MARK: - EpochSyncConfig

public struct EpochSyncConfig: Codable {
    public let disableEpochSyncForBootstrapping: Bool?
    public let epochSyncHorizon: UInt64
    public let ignoreEpochSyncNetworkRequests: Bool?
    public let timeoutForEpochSync: DurationAsStdSchemaProvider

    public init(
        disableEpochSyncForBootstrapping: Bool?,
        epochSyncHorizon: UInt64,
        ignoreEpochSyncNetworkRequests: Bool?,
        timeoutForEpochSync: DurationAsStdSchemaProvider
    ) {
        self.disableEpochSyncForBootstrapping = disableEpochSyncForBootstrapping
        self.epochSyncHorizon = epochSyncHorizon
        self.ignoreEpochSyncNetworkRequests = ignoreEpochSyncNetworkRequests
        self.timeoutForEpochSync = timeoutForEpochSync
    }
}

// MARK: - ExecutionMetadataView

public struct ExecutionMetadataView: Codable {
    public let gasProfile: [CostGasUsed]?
    public let version: Int

    public init(
        gasProfile: [CostGasUsed]?,
        version: Int
    ) {
        self.gasProfile = gasProfile
        self.version = version
    }
}

// MARK: - ExecutionOutcomeView

public struct ExecutionOutcomeView: Codable {
    public let executorId: AccountId
    public let gasBurnt: NearGas
    public let logs: [String]
    public let metadata: ExecutionMetadataView?
    public let receiptIds: [CryptoHash]
    public let status: ExecutionStatusView
    public let tokensBurnt: NearToken

    public init(
        executorId: AccountId,
        gasBurnt: NearGas,
        logs: [String],
        metadata: ExecutionMetadataView?,
        receiptIds: [CryptoHash],
        status: ExecutionStatusView,
        tokensBurnt: NearToken
    ) {
        self.executorId = executorId
        self.gasBurnt = gasBurnt
        self.logs = logs
        self.metadata = metadata
        self.receiptIds = receiptIds
        self.status = status
        self.tokensBurnt = tokensBurnt
    }
}

// MARK: - ExecutionOutcomeWithIdView

public struct ExecutionOutcomeWithIdView: Codable {
    public let blockHash: CryptoHash
    public let id: CryptoHash
    public let outcome: ExecutionOutcomeView
    public let proof: [MerklePathItem]

    public init(
        blockHash: CryptoHash,
        id: CryptoHash,
        outcome: ExecutionOutcomeView,
        proof: [MerklePathItem]
    ) {
        self.blockHash = blockHash
        self.id = id
        self.outcome = outcome
        self.proof = proof
    }
}

// MARK: - ExtCostsConfigView

public struct ExtCostsConfigView: Codable {
    public let altBn128G1MultiexpBase: NearGas
    public let altBn128G1MultiexpElement: NearGas
    public let altBn128G1SumBase: NearGas
    public let altBn128G1SumElement: NearGas
    public let altBn128PairingCheckBase: NearGas
    public let altBn128PairingCheckElement: NearGas
    public let base: NearGas
    public let bls12381G1MultiexpBase: NearGas
    public let bls12381G1MultiexpElement: NearGas
    public let bls12381G2MultiexpBase: NearGas
    public let bls12381G2MultiexpElement: NearGas
    public let bls12381MapFp2ToG2Base: NearGas
    public let bls12381MapFp2ToG2Element: NearGas
    public let bls12381MapFpToG1Base: NearGas
    public let bls12381MapFpToG1Element: NearGas
    public let bls12381P1DecompressBase: NearGas
    public let bls12381P1DecompressElement: NearGas
    public let bls12381P1SumBase: NearGas
    public let bls12381P1SumElement: NearGas
    public let bls12381P2DecompressBase: NearGas
    public let bls12381P2DecompressElement: NearGas
    public let bls12381P2SumBase: NearGas
    public let bls12381P2SumElement: NearGas
    public let bls12381PairingBase: NearGas
    public let bls12381PairingElement: NearGas
    public let contractCompileBase: NearGas
    public let contractCompileBytes: NearGas
    public let contractLoadingBase: NearGas
    public let contractLoadingBytes: NearGas
    public let ecrecoverBase: NearGas
    public let ed25519VerifyBase: NearGas
    public let ed25519VerifyByte: NearGas
    public let keccak256Base: NearGas
    public let keccak256Byte: NearGas
    public let keccak512Base: NearGas
    public let keccak512Byte: NearGas
    public let logBase: NearGas
    public let logByte: NearGas
    public let promiseAndBase: NearGas
    public let promiseAndPerPromise: NearGas
    public let promiseReturn: NearGas
    public let readCachedTrieNode: NearGas
    public let readMemoryBase: NearGas
    public let readMemoryByte: NearGas
    public let readRegisterBase: NearGas
    public let readRegisterByte: NearGas
    public let ripemd160Base: NearGas
    public let ripemd160Block: NearGas
    public let sha256Base: NearGas
    public let sha256Byte: NearGas
    public let storageHasKeyBase: NearGas
    public let storageHasKeyByte: NearGas
    public let storageIterCreateFromByte: NearGas
    public let storageIterCreatePrefixBase: NearGas
    public let storageIterCreatePrefixByte: NearGas
    public let storageIterCreateRangeBase: NearGas
    public let storageIterCreateToByte: NearGas
    public let storageIterNextBase: NearGas
    public let storageIterNextKeyByte: NearGas
    public let storageIterNextValueByte: NearGas
    public let storageLargeReadOverheadBase: NearGas
    public let storageLargeReadOverheadByte: NearGas
    public let storageReadBase: NearGas
    public let storageReadKeyByte: NearGas
    public let storageReadValueByte: NearGas
    public let storageRemoveBase: NearGas
    public let storageRemoveKeyByte: NearGas
    public let storageRemoveRetValueByte: NearGas
    public let storageWriteBase: NearGas
    public let storageWriteEvictedByte: NearGas
    public let storageWriteKeyByte: NearGas
    public let storageWriteValueByte: NearGas
    public let touchingTrieNode: NearGas
    public let utf16DecodingBase: NearGas
    public let utf16DecodingByte: NearGas
    public let utf8DecodingBase: NearGas
    public let utf8DecodingByte: NearGas
    public let validatorStakeBase: NearGas
    public let validatorTotalStakeBase: NearGas
    public let writeMemoryBase: NearGas
    public let writeMemoryByte: NearGas
    public let writeRegisterBase: NearGas
    public let writeRegisterByte: NearGas
    public let yieldCreateBase: NearGas
    public let yieldCreateByte: NearGas
    public let yieldResumeBase: NearGas
    public let yieldResumeByte: NearGas

    public init(
        altBn128G1MultiexpBase: NearGas,
        altBn128G1MultiexpElement: NearGas,
        altBn128G1SumBase: NearGas,
        altBn128G1SumElement: NearGas,
        altBn128PairingCheckBase: NearGas,
        altBn128PairingCheckElement: NearGas,
        base: NearGas,
        bls12381G1MultiexpBase: NearGas,
        bls12381G1MultiexpElement: NearGas,
        bls12381G2MultiexpBase: NearGas,
        bls12381G2MultiexpElement: NearGas,
        bls12381MapFp2ToG2Base: NearGas,
        bls12381MapFp2ToG2Element: NearGas,
        bls12381MapFpToG1Base: NearGas,
        bls12381MapFpToG1Element: NearGas,
        bls12381P1DecompressBase: NearGas,
        bls12381P1DecompressElement: NearGas,
        bls12381P1SumBase: NearGas,
        bls12381P1SumElement: NearGas,
        bls12381P2DecompressBase: NearGas,
        bls12381P2DecompressElement: NearGas,
        bls12381P2SumBase: NearGas,
        bls12381P2SumElement: NearGas,
        bls12381PairingBase: NearGas,
        bls12381PairingElement: NearGas,
        contractCompileBase: NearGas,
        contractCompileBytes: NearGas,
        contractLoadingBase: NearGas,
        contractLoadingBytes: NearGas,
        ecrecoverBase: NearGas,
        ed25519VerifyBase: NearGas,
        ed25519VerifyByte: NearGas,
        keccak256Base: NearGas,
        keccak256Byte: NearGas,
        keccak512Base: NearGas,
        keccak512Byte: NearGas,
        logBase: NearGas,
        logByte: NearGas,
        promiseAndBase: NearGas,
        promiseAndPerPromise: NearGas,
        promiseReturn: NearGas,
        readCachedTrieNode: NearGas,
        readMemoryBase: NearGas,
        readMemoryByte: NearGas,
        readRegisterBase: NearGas,
        readRegisterByte: NearGas,
        ripemd160Base: NearGas,
        ripemd160Block: NearGas,
        sha256Base: NearGas,
        sha256Byte: NearGas,
        storageHasKeyBase: NearGas,
        storageHasKeyByte: NearGas,
        storageIterCreateFromByte: NearGas,
        storageIterCreatePrefixBase: NearGas,
        storageIterCreatePrefixByte: NearGas,
        storageIterCreateRangeBase: NearGas,
        storageIterCreateToByte: NearGas,
        storageIterNextBase: NearGas,
        storageIterNextKeyByte: NearGas,
        storageIterNextValueByte: NearGas,
        storageLargeReadOverheadBase: NearGas,
        storageLargeReadOverheadByte: NearGas,
        storageReadBase: NearGas,
        storageReadKeyByte: NearGas,
        storageReadValueByte: NearGas,
        storageRemoveBase: NearGas,
        storageRemoveKeyByte: NearGas,
        storageRemoveRetValueByte: NearGas,
        storageWriteBase: NearGas,
        storageWriteEvictedByte: NearGas,
        storageWriteKeyByte: NearGas,
        storageWriteValueByte: NearGas,
        touchingTrieNode: NearGas,
        utf16DecodingBase: NearGas,
        utf16DecodingByte: NearGas,
        utf8DecodingBase: NearGas,
        utf8DecodingByte: NearGas,
        validatorStakeBase: NearGas,
        validatorTotalStakeBase: NearGas,
        writeMemoryBase: NearGas,
        writeMemoryByte: NearGas,
        writeRegisterBase: NearGas,
        writeRegisterByte: NearGas,
        yieldCreateBase: NearGas,
        yieldCreateByte: NearGas,
        yieldResumeBase: NearGas,
        yieldResumeByte: NearGas
    ) {
        self.altBn128G1MultiexpBase = altBn128G1MultiexpBase
        self.altBn128G1MultiexpElement = altBn128G1MultiexpElement
        self.altBn128G1SumBase = altBn128G1SumBase
        self.altBn128G1SumElement = altBn128G1SumElement
        self.altBn128PairingCheckBase = altBn128PairingCheckBase
        self.altBn128PairingCheckElement = altBn128PairingCheckElement
        self.base = base
        self.bls12381G1MultiexpBase = bls12381G1MultiexpBase
        self.bls12381G1MultiexpElement = bls12381G1MultiexpElement
        self.bls12381G2MultiexpBase = bls12381G2MultiexpBase
        self.bls12381G2MultiexpElement = bls12381G2MultiexpElement
        self.bls12381MapFp2ToG2Base = bls12381MapFp2ToG2Base
        self.bls12381MapFp2ToG2Element = bls12381MapFp2ToG2Element
        self.bls12381MapFpToG1Base = bls12381MapFpToG1Base
        self.bls12381MapFpToG1Element = bls12381MapFpToG1Element
        self.bls12381P1DecompressBase = bls12381P1DecompressBase
        self.bls12381P1DecompressElement = bls12381P1DecompressElement
        self.bls12381P1SumBase = bls12381P1SumBase
        self.bls12381P1SumElement = bls12381P1SumElement
        self.bls12381P2DecompressBase = bls12381P2DecompressBase
        self.bls12381P2DecompressElement = bls12381P2DecompressElement
        self.bls12381P2SumBase = bls12381P2SumBase
        self.bls12381P2SumElement = bls12381P2SumElement
        self.bls12381PairingBase = bls12381PairingBase
        self.bls12381PairingElement = bls12381PairingElement
        self.contractCompileBase = contractCompileBase
        self.contractCompileBytes = contractCompileBytes
        self.contractLoadingBase = contractLoadingBase
        self.contractLoadingBytes = contractLoadingBytes
        self.ecrecoverBase = ecrecoverBase
        self.ed25519VerifyBase = ed25519VerifyBase
        self.ed25519VerifyByte = ed25519VerifyByte
        self.keccak256Base = keccak256Base
        self.keccak256Byte = keccak256Byte
        self.keccak512Base = keccak512Base
        self.keccak512Byte = keccak512Byte
        self.logBase = logBase
        self.logByte = logByte
        self.promiseAndBase = promiseAndBase
        self.promiseAndPerPromise = promiseAndPerPromise
        self.promiseReturn = promiseReturn
        self.readCachedTrieNode = readCachedTrieNode
        self.readMemoryBase = readMemoryBase
        self.readMemoryByte = readMemoryByte
        self.readRegisterBase = readRegisterBase
        self.readRegisterByte = readRegisterByte
        self.ripemd160Base = ripemd160Base
        self.ripemd160Block = ripemd160Block
        self.sha256Base = sha256Base
        self.sha256Byte = sha256Byte
        self.storageHasKeyBase = storageHasKeyBase
        self.storageHasKeyByte = storageHasKeyByte
        self.storageIterCreateFromByte = storageIterCreateFromByte
        self.storageIterCreatePrefixBase = storageIterCreatePrefixBase
        self.storageIterCreatePrefixByte = storageIterCreatePrefixByte
        self.storageIterCreateRangeBase = storageIterCreateRangeBase
        self.storageIterCreateToByte = storageIterCreateToByte
        self.storageIterNextBase = storageIterNextBase
        self.storageIterNextKeyByte = storageIterNextKeyByte
        self.storageIterNextValueByte = storageIterNextValueByte
        self.storageLargeReadOverheadBase = storageLargeReadOverheadBase
        self.storageLargeReadOverheadByte = storageLargeReadOverheadByte
        self.storageReadBase = storageReadBase
        self.storageReadKeyByte = storageReadKeyByte
        self.storageReadValueByte = storageReadValueByte
        self.storageRemoveBase = storageRemoveBase
        self.storageRemoveKeyByte = storageRemoveKeyByte
        self.storageRemoveRetValueByte = storageRemoveRetValueByte
        self.storageWriteBase = storageWriteBase
        self.storageWriteEvictedByte = storageWriteEvictedByte
        self.storageWriteKeyByte = storageWriteKeyByte
        self.storageWriteValueByte = storageWriteValueByte
        self.touchingTrieNode = touchingTrieNode
        self.utf16DecodingBase = utf16DecodingBase
        self.utf16DecodingByte = utf16DecodingByte
        self.utf8DecodingBase = utf8DecodingBase
        self.utf8DecodingByte = utf8DecodingByte
        self.validatorStakeBase = validatorStakeBase
        self.validatorTotalStakeBase = validatorTotalStakeBase
        self.writeMemoryBase = writeMemoryBase
        self.writeMemoryByte = writeMemoryByte
        self.writeRegisterBase = writeRegisterBase
        self.writeRegisterByte = writeRegisterByte
        self.yieldCreateBase = yieldCreateBase
        self.yieldCreateByte = yieldCreateByte
        self.yieldResumeBase = yieldResumeBase
        self.yieldResumeByte = yieldResumeByte
    }
}

// MARK: - ExternalStorageConfig

public struct ExternalStorageConfig: Codable {
    public let externalStorageFallbackThreshold: UInt64?
    public let location: ExternalStorageLocation
    public let numConcurrentRequests: Int?
    public let numConcurrentRequestsDuringCatchup: Int?

    public init(
        externalStorageFallbackThreshold: UInt64?,
        location: ExternalStorageLocation,
        numConcurrentRequests: Int?,
        numConcurrentRequestsDuringCatchup: Int?
    ) {
        self.externalStorageFallbackThreshold = externalStorageFallbackThreshold
        self.location = location
        self.numConcurrentRequests = numConcurrentRequests
        self.numConcurrentRequestsDuringCatchup = numConcurrentRequestsDuringCatchup
    }
}

// MARK: - Fee

public struct Fee: Codable {
    public let execution: NearGas
    public let sendNotSir: NearGas
    public let sendSir: NearGas

    public init(
        execution: NearGas,
        sendNotSir: NearGas,
        sendSir: NearGas
    ) {
        self.execution = execution
        self.sendNotSir = sendNotSir
        self.sendSir = sendSir
    }
}

// MARK: - FinalExecutionOutcomeView

public struct FinalExecutionOutcomeView: Codable {
    public let receiptsOutcome: [ExecutionOutcomeWithIdView]
    public let status: FinalExecutionStatus
    public let transaction: SignedTransactionView
    public let transactionOutcome: ExecutionOutcomeWithIdView

    public init(
        receiptsOutcome: [ExecutionOutcomeWithIdView],
        status: FinalExecutionStatus,
        transaction: SignedTransactionView,
        transactionOutcome: ExecutionOutcomeWithIdView
    ) {
        self.receiptsOutcome = receiptsOutcome
        self.status = status
        self.transaction = transaction
        self.transactionOutcome = transactionOutcome
    }
}

// MARK: - FinalExecutionOutcomeWithReceiptView

public struct FinalExecutionOutcomeWithReceiptView: Codable {
    public let receipts: [ReceiptView]
    public let receiptsOutcome: [ExecutionOutcomeWithIdView]
    public let status: FinalExecutionStatus
    public let transaction: SignedTransactionView
    public let transactionOutcome: ExecutionOutcomeWithIdView

    public init(
        receipts: [ReceiptView],
        receiptsOutcome: [ExecutionOutcomeWithIdView],
        status: FinalExecutionStatus,
        transaction: SignedTransactionView,
        transactionOutcome: ExecutionOutcomeWithIdView
    ) {
        self.receipts = receipts
        self.receiptsOutcome = receiptsOutcome
        self.status = status
        self.transaction = transaction
        self.transactionOutcome = transactionOutcome
    }
}

// MARK: - FunctionCallAction

public struct FunctionCallAction: Codable {
    public let args: String
    public let deposit: NearToken
    public let gas: NearGas
    public let methodName: String

    public init(
        args: String,
        deposit: NearToken,
        gas: NearGas,
        methodName: String
    ) {
        self.args = args
        self.deposit = deposit
        self.gas = gas
        self.methodName = methodName
    }
}

// MARK: - FunctionCallPermission

public struct FunctionCallPermission: Codable {
    public let allowance: NearToken?
    public let methodNames: [String]
    public let receiverId: String

    public init(
        allowance: NearToken?,
        methodNames: [String],
        receiverId: String
    ) {
        self.allowance = allowance
        self.methodNames = methodNames
        self.receiverId = receiverId
    }
}

// MARK: - GCConfig

public struct GCConfig: Codable {
    public let gcBlocksLimit: UInt64?
    public let gcForkCleanStep: UInt64?
    public let gcNumEpochsToKeep: UInt64?
    public let gcStepPeriod: DurationAsStdSchemaProvider?

    public init(
        gcBlocksLimit: UInt64?,
        gcForkCleanStep: UInt64?,
        gcNumEpochsToKeep: UInt64?,
        gcStepPeriod: DurationAsStdSchemaProvider?
    ) {
        self.gcBlocksLimit = gcBlocksLimit
        self.gcForkCleanStep = gcForkCleanStep
        self.gcNumEpochsToKeep = gcNumEpochsToKeep
        self.gcStepPeriod = gcStepPeriod
    }
}

// MARK: - GasKeyView

public struct GasKeyView: Codable {
    public let balance: NearToken
    public let numNonces: Int
    public let permission: AccessKeyPermissionView

    public init(
        balance: NearToken,
        numNonces: Int,
        permission: AccessKeyPermissionView
    ) {
        self.balance = balance
        self.numNonces = numNonces
        self.permission = permission
    }
}

// MARK: - GenesisConfig

public struct GenesisConfig: Codable {
    public let avgHiddenValidatorSeatsPerShard: [UInt64]
    public let blockProducerKickoutThreshold: Int
    public let chainId: String
    public let chunkProducerAssignmentChangesLimit: UInt64?
    public let chunkProducerKickoutThreshold: Int
    public let chunkValidatorOnlyKickoutThreshold: Int?
    public let dynamicResharding: Bool
    public let epochLength: UInt64
    public let fishermenThreshold: NearToken
    public let gasLimit: NearGas
    public let gasPriceAdjustmentRate: [Int32]
    public let genesisHeight: UInt64
    public let genesisTime: String
    public let maxGasPrice: NearToken
    public let maxInflationRate: [Int32]
    public let maxKickoutStakePerc: Int?
    public let minGasPrice: NearToken
    public let minimumStakeDivisor: UInt64?
    public let minimumStakeRatio: [Int32]?
    public let minimumValidatorsPerShard: UInt64?
    public let numBlockProducerSeats: UInt64
    public let numBlockProducerSeatsPerShard: [UInt64]
    public let numBlocksPerYear: UInt64
    public let numChunkOnlyProducerSeats: UInt64?
    public let numChunkProducerSeats: UInt64?
    public let numChunkValidatorSeats: UInt64?
    public let onlineMaxThreshold: [Int32]?
    public let onlineMinThreshold: [Int32]?
    public let protocolRewardRate: [Int32]
    public let protocolTreasuryAccount: AccountId
    public let protocolUpgradeStakeThreshold: [Int32]?
    public let protocolVersion: Int
    public let shardLayout: ShardLayout?
    public let shuffleShardAssignmentForChunkProducers: Bool?
    public let targetValidatorMandatesPerShard: UInt64?
    public let totalSupply: NearToken
    public let transactionValidityPeriod: UInt64
    public let useProductionConfig: Bool?
    public let validators: [AccountInfo]

    public init(
        avgHiddenValidatorSeatsPerShard: [UInt64],
        blockProducerKickoutThreshold: Int,
        chainId: String,
        chunkProducerAssignmentChangesLimit: UInt64?,
        chunkProducerKickoutThreshold: Int,
        chunkValidatorOnlyKickoutThreshold: Int?,
        dynamicResharding: Bool,
        epochLength: UInt64,
        fishermenThreshold: NearToken,
        gasLimit: NearGas,
        gasPriceAdjustmentRate: [Int32],
        genesisHeight: UInt64,
        genesisTime: String,
        maxGasPrice: NearToken,
        maxInflationRate: [Int32],
        maxKickoutStakePerc: Int?,
        minGasPrice: NearToken,
        minimumStakeDivisor: UInt64?,
        minimumStakeRatio: [Int32]?,
        minimumValidatorsPerShard: UInt64?,
        numBlockProducerSeats: UInt64,
        numBlockProducerSeatsPerShard: [UInt64],
        numBlocksPerYear: UInt64,
        numChunkOnlyProducerSeats: UInt64?,
        numChunkProducerSeats: UInt64?,
        numChunkValidatorSeats: UInt64?,
        onlineMaxThreshold: [Int32]?,
        onlineMinThreshold: [Int32]?,
        protocolRewardRate: [Int32],
        protocolTreasuryAccount: AccountId,
        protocolUpgradeStakeThreshold: [Int32]?,
        protocolVersion: Int,
        shardLayout: ShardLayout?,
        shuffleShardAssignmentForChunkProducers: Bool?,
        targetValidatorMandatesPerShard: UInt64?,
        totalSupply: NearToken,
        transactionValidityPeriod: UInt64,
        useProductionConfig: Bool?,
        validators: [AccountInfo]
    ) {
        self.avgHiddenValidatorSeatsPerShard = avgHiddenValidatorSeatsPerShard
        self.blockProducerKickoutThreshold = blockProducerKickoutThreshold
        self.chainId = chainId
        self.chunkProducerAssignmentChangesLimit = chunkProducerAssignmentChangesLimit
        self.chunkProducerKickoutThreshold = chunkProducerKickoutThreshold
        self.chunkValidatorOnlyKickoutThreshold = chunkValidatorOnlyKickoutThreshold
        self.dynamicResharding = dynamicResharding
        self.epochLength = epochLength
        self.fishermenThreshold = fishermenThreshold
        self.gasLimit = gasLimit
        self.gasPriceAdjustmentRate = gasPriceAdjustmentRate
        self.genesisHeight = genesisHeight
        self.genesisTime = genesisTime
        self.maxGasPrice = maxGasPrice
        self.maxInflationRate = maxInflationRate
        self.maxKickoutStakePerc = maxKickoutStakePerc
        self.minGasPrice = minGasPrice
        self.minimumStakeDivisor = minimumStakeDivisor
        self.minimumStakeRatio = minimumStakeRatio
        self.minimumValidatorsPerShard = minimumValidatorsPerShard
        self.numBlockProducerSeats = numBlockProducerSeats
        self.numBlockProducerSeatsPerShard = numBlockProducerSeatsPerShard
        self.numBlocksPerYear = numBlocksPerYear
        self.numChunkOnlyProducerSeats = numChunkOnlyProducerSeats
        self.numChunkProducerSeats = numChunkProducerSeats
        self.numChunkValidatorSeats = numChunkValidatorSeats
        self.onlineMaxThreshold = onlineMaxThreshold
        self.onlineMinThreshold = onlineMinThreshold
        self.protocolRewardRate = protocolRewardRate
        self.protocolTreasuryAccount = protocolTreasuryAccount
        self.protocolUpgradeStakeThreshold = protocolUpgradeStakeThreshold
        self.protocolVersion = protocolVersion
        self.shardLayout = shardLayout
        self.shuffleShardAssignmentForChunkProducers = shuffleShardAssignmentForChunkProducers
        self.targetValidatorMandatesPerShard = targetValidatorMandatesPerShard
        self.totalSupply = totalSupply
        self.transactionValidityPeriod = transactionValidityPeriod
        self.useProductionConfig = useProductionConfig
        self.validators = validators
    }
}

// MARK: - JsonRpcRequestForEXPERIMENTALChanges

public struct JsonRpcRequestForEXPERIMENTALChanges: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcStateChangesInBlockByTypeRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcStateChangesInBlockByTypeRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForEXPERIMENTALChangesInBlock

public struct JsonRpcRequestForEXPERIMENTALChangesInBlock: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcStateChangesInBlockRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcStateChangesInBlockRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForEXPERIMENTALCongestionLevel

public struct JsonRpcRequestForEXPERIMENTALCongestionLevel: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcCongestionLevelRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcCongestionLevelRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForEXPERIMENTALGenesisConfig

public struct JsonRpcRequestForEXPERIMENTALGenesisConfig: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: GenesisConfigRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: GenesisConfigRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForEXPERIMENTALLightClientBlockProof

public struct JsonRpcRequestForEXPERIMENTALLightClientBlockProof: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcLightClientBlockProofRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcLightClientBlockProofRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForEXPERIMENTALLightClientProof

public struct JsonRpcRequestForEXPERIMENTALLightClientProof: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcLightClientExecutionProofRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcLightClientExecutionProofRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForEXPERIMENTALMaintenanceWindows

public struct JsonRpcRequestForEXPERIMENTALMaintenanceWindows: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcMaintenanceWindowsRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcMaintenanceWindowsRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForEXPERIMENTALProtocolConfig

public struct JsonRpcRequestForEXPERIMENTALProtocolConfig: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcProtocolConfigRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcProtocolConfigRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForEXPERIMENTALReceipt

public struct JsonRpcRequestForEXPERIMENTALReceipt: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcReceiptRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcReceiptRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForEXPERIMENTALSplitStorageInfo

public struct JsonRpcRequestForEXPERIMENTALSplitStorageInfo: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcSplitStorageInfoRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcSplitStorageInfoRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForEXPERIMENTALTxStatus

public struct JsonRpcRequestForEXPERIMENTALTxStatus: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcTransactionStatusRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcTransactionStatusRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForEXPERIMENTALValidatorsOrdered

public struct JsonRpcRequestForEXPERIMENTALValidatorsOrdered: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcValidatorsOrderedRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcValidatorsOrderedRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForBlock

public struct JsonRpcRequestForBlock: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcBlockRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcBlockRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForBlockEffects

public struct JsonRpcRequestForBlockEffects: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcStateChangesInBlockRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcStateChangesInBlockRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForBroadcastTxAsync

public struct JsonRpcRequestForBroadcastTxAsync: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcSendTransactionRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcSendTransactionRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForBroadcastTxCommit

public struct JsonRpcRequestForBroadcastTxCommit: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcSendTransactionRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcSendTransactionRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForChanges

public struct JsonRpcRequestForChanges: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcStateChangesInBlockByTypeRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcStateChangesInBlockByTypeRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForChunk

public struct JsonRpcRequestForChunk: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcChunkRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcChunkRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForClientConfig

public struct JsonRpcRequestForClientConfig: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcClientConfigRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcClientConfigRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForGasPrice

public struct JsonRpcRequestForGasPrice: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcGasPriceRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcGasPriceRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForGenesisConfig

public struct JsonRpcRequestForGenesisConfig: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: GenesisConfigRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: GenesisConfigRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForHealth

public struct JsonRpcRequestForHealth: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcHealthRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcHealthRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForLightClientProof

public struct JsonRpcRequestForLightClientProof: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcLightClientExecutionProofRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcLightClientExecutionProofRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForMaintenanceWindows

public struct JsonRpcRequestForMaintenanceWindows: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcMaintenanceWindowsRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcMaintenanceWindowsRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForNetworkInfo

public struct JsonRpcRequestForNetworkInfo: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcNetworkInfoRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcNetworkInfoRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForNextLightClientBlock

public struct JsonRpcRequestForNextLightClientBlock: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcLightClientNextBlockRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcLightClientNextBlockRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForQuery

public struct JsonRpcRequestForQuery: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcQueryRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcQueryRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForSendTx

public struct JsonRpcRequestForSendTx: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcSendTransactionRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcSendTransactionRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForStatus

public struct JsonRpcRequestForStatus: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcStatusRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcStatusRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForTx

public struct JsonRpcRequestForTx: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcTransactionStatusRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcTransactionStatusRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - JsonRpcRequestForValidators

public struct JsonRpcRequestForValidators: Codable {
    public let id: String
    public let jsonrpc: String
    public let method: String
    public let params: RpcValidatorRequest

    public init(
        id: String,
        jsonrpc: String,
        method: String,
        params: RpcValidatorRequest
    ) {
        self.id = id
        self.jsonrpc = jsonrpc
        self.method = method
        self.params = params
    }
}

// MARK: - KnownProducerView

public struct KnownProducerView: Codable {
    public let accountId: AccountId
    public let nextHops: [PublicKey]?
    public let peerId: PublicKey

    public init(
        accountId: AccountId,
        nextHops: [PublicKey]?,
        peerId: PublicKey
    ) {
        self.accountId = accountId
        self.nextHops = nextHops
        self.peerId = peerId
    }
}

// MARK: - LightClientBlockLiteView

public struct LightClientBlockLiteView: Codable {
    public let innerLite: BlockHeaderInnerLiteView
    public let innerRestHash: CryptoHash
    public let prevBlockHash: CryptoHash

    public init(
        innerLite: BlockHeaderInnerLiteView,
        innerRestHash: CryptoHash,
        prevBlockHash: CryptoHash
    ) {
        self.innerLite = innerLite
        self.innerRestHash = innerRestHash
        self.prevBlockHash = prevBlockHash
    }
}

// MARK: - LimitConfig

public struct LimitConfig: Codable {
    public let accountIdValidityRulesVersion: AccountIdValidityRulesVersion?
    public let initialMemoryPages: Int
    public let maxActionsPerReceipt: UInt64
    public let maxArgumentsLength: UInt64
    public let maxContractSize: UInt64
    public let maxElementsPerContractTable: Int?
    public let maxFunctionsNumberPerContract: UInt64?
    public let maxGasBurnt: NearGas
    public let maxLengthMethodName: UInt64
    public let maxLengthReturnedData: UInt64
    public let maxLengthStorageKey: UInt64
    public let maxLengthStorageValue: UInt64
    public let maxLocalsPerContract: UInt64?
    public let maxMemoryPages: Int
    public let maxNumberBytesMethodNames: UInt64
    public let maxNumberInputDataDependencies: UInt64
    public let maxNumberLogs: UInt64
    public let maxNumberRegisters: UInt64
    public let maxPromisesPerFunctionCallAction: UInt64
    public let maxReceiptSize: UInt64
    public let maxRegisterSize: UInt64
    public let maxStackHeight: Int
    public let maxTablesPerContract: Int?
    public let maxTotalLogLength: UInt64
    public let maxTotalPrepaidGas: NearGas
    public let maxTransactionSize: UInt64
    public let maxYieldPayloadSize: UInt64
    public let perReceiptStorageProofSizeLimit: Int
    public let registersMemoryLimit: UInt64
    public let yieldTimeoutLengthInBlocks: UInt64

    public init(
        accountIdValidityRulesVersion: AccountIdValidityRulesVersion?,
        initialMemoryPages: Int,
        maxActionsPerReceipt: UInt64,
        maxArgumentsLength: UInt64,
        maxContractSize: UInt64,
        maxElementsPerContractTable: Int?,
        maxFunctionsNumberPerContract: UInt64?,
        maxGasBurnt: NearGas,
        maxLengthMethodName: UInt64,
        maxLengthReturnedData: UInt64,
        maxLengthStorageKey: UInt64,
        maxLengthStorageValue: UInt64,
        maxLocalsPerContract: UInt64?,
        maxMemoryPages: Int,
        maxNumberBytesMethodNames: UInt64,
        maxNumberInputDataDependencies: UInt64,
        maxNumberLogs: UInt64,
        maxNumberRegisters: UInt64,
        maxPromisesPerFunctionCallAction: UInt64,
        maxReceiptSize: UInt64,
        maxRegisterSize: UInt64,
        maxStackHeight: Int,
        maxTablesPerContract: Int?,
        maxTotalLogLength: UInt64,
        maxTotalPrepaidGas: NearGas,
        maxTransactionSize: UInt64,
        maxYieldPayloadSize: UInt64,
        perReceiptStorageProofSizeLimit: Int,
        registersMemoryLimit: UInt64,
        yieldTimeoutLengthInBlocks: UInt64
    ) {
        self.accountIdValidityRulesVersion = accountIdValidityRulesVersion
        self.initialMemoryPages = initialMemoryPages
        self.maxActionsPerReceipt = maxActionsPerReceipt
        self.maxArgumentsLength = maxArgumentsLength
        self.maxContractSize = maxContractSize
        self.maxElementsPerContractTable = maxElementsPerContractTable
        self.maxFunctionsNumberPerContract = maxFunctionsNumberPerContract
        self.maxGasBurnt = maxGasBurnt
        self.maxLengthMethodName = maxLengthMethodName
        self.maxLengthReturnedData = maxLengthReturnedData
        self.maxLengthStorageKey = maxLengthStorageKey
        self.maxLengthStorageValue = maxLengthStorageValue
        self.maxLocalsPerContract = maxLocalsPerContract
        self.maxMemoryPages = maxMemoryPages
        self.maxNumberBytesMethodNames = maxNumberBytesMethodNames
        self.maxNumberInputDataDependencies = maxNumberInputDataDependencies
        self.maxNumberLogs = maxNumberLogs
        self.maxNumberRegisters = maxNumberRegisters
        self.maxPromisesPerFunctionCallAction = maxPromisesPerFunctionCallAction
        self.maxReceiptSize = maxReceiptSize
        self.maxRegisterSize = maxRegisterSize
        self.maxStackHeight = maxStackHeight
        self.maxTablesPerContract = maxTablesPerContract
        self.maxTotalLogLength = maxTotalLogLength
        self.maxTotalPrepaidGas = maxTotalPrepaidGas
        self.maxTransactionSize = maxTransactionSize
        self.maxYieldPayloadSize = maxYieldPayloadSize
        self.perReceiptStorageProofSizeLimit = perReceiptStorageProofSizeLimit
        self.registersMemoryLimit = registersMemoryLimit
        self.yieldTimeoutLengthInBlocks = yieldTimeoutLengthInBlocks
    }
}

// MARK: - MerklePathItem

public struct MerklePathItem: Codable {
    public let direction: Direction
    public let hash: CryptoHash

    public init(
        direction: Direction,
        hash: CryptoHash
    ) {
        self.direction = direction
        self.hash = hash
    }
}

// MARK: - MissingTrieValue

public struct MissingTrieValue: Codable {
    public let context: MissingTrieValueContext
    public let hash: CryptoHash

    public init(
        context: MissingTrieValueContext,
        hash: CryptoHash
    ) {
        self.context = context
        self.hash = hash
    }
}

// MARK: - NetworkInfoView

public struct NetworkInfoView: Codable {
    public let connectedPeers: [PeerInfoView]
    public let knownProducers: [KnownProducerView]
    public let numConnectedPeers: Int
    public let peerMaxCount: Int
    public let tier1AccountsData: [AccountDataView]
    public let tier1AccountsKeys: [PublicKey]
    public let tier1Connections: [PeerInfoView]

    public init(
        connectedPeers: [PeerInfoView],
        knownProducers: [KnownProducerView],
        numConnectedPeers: Int,
        peerMaxCount: Int,
        tier1AccountsData: [AccountDataView],
        tier1AccountsKeys: [PublicKey],
        tier1Connections: [PeerInfoView]
    ) {
        self.connectedPeers = connectedPeers
        self.knownProducers = knownProducers
        self.numConnectedPeers = numConnectedPeers
        self.peerMaxCount = peerMaxCount
        self.tier1AccountsData = tier1AccountsData
        self.tier1AccountsKeys = tier1AccountsKeys
        self.tier1Connections = tier1Connections
    }
}

// MARK: - NextEpochValidatorInfo

public struct NextEpochValidatorInfo: Codable {
    public let accountId: AccountId
    public let publicKey: PublicKey
    public let shards: [ShardId]
    public let stake: NearToken

    public init(
        accountId: AccountId,
        publicKey: PublicKey,
        shards: [ShardId],
        stake: NearToken
    ) {
        self.accountId = accountId
        self.publicKey = publicKey
        self.shards = shards
        self.stake = stake
    }
}

// MARK: - PeerInfoView

public struct PeerInfoView: Codable {
    public let accountId: AccountId?
    public let addr: String
    public let archival: Bool
    public let blockHash: CryptoHash?
    public let connectionEstablishedTimeMillis: UInt64
    public let height: UInt64?
    public let isHighestBlockInvalid: Bool
    public let isOutboundPeer: Bool
    public let lastTimePeerRequestedMillis: UInt64
    public let lastTimeReceivedMessageMillis: UInt64
    public let nonce: UInt64
    public let peerId: PublicKey
    public let receivedBytesPerSec: UInt64
    public let sentBytesPerSec: UInt64
    public let trackedShards: [ShardId]

    public init(
        accountId: AccountId?,
        addr: String,
        archival: Bool,
        blockHash: CryptoHash?,
        connectionEstablishedTimeMillis: UInt64,
        height: UInt64?,
        isHighestBlockInvalid: Bool,
        isOutboundPeer: Bool,
        lastTimePeerRequestedMillis: UInt64,
        lastTimeReceivedMessageMillis: UInt64,
        nonce: UInt64,
        peerId: PublicKey,
        receivedBytesPerSec: UInt64,
        sentBytesPerSec: UInt64,
        trackedShards: [ShardId]
    ) {
        self.accountId = accountId
        self.addr = addr
        self.archival = archival
        self.blockHash = blockHash
        self.connectionEstablishedTimeMillis = connectionEstablishedTimeMillis
        self.height = height
        self.isHighestBlockInvalid = isHighestBlockInvalid
        self.isOutboundPeer = isOutboundPeer
        self.lastTimePeerRequestedMillis = lastTimePeerRequestedMillis
        self.lastTimeReceivedMessageMillis = lastTimeReceivedMessageMillis
        self.nonce = nonce
        self.peerId = peerId
        self.receivedBytesPerSec = receivedBytesPerSec
        self.sentBytesPerSec = sentBytesPerSec
        self.trackedShards = trackedShards
    }
}

// MARK: - RangeOfUint64

public struct RangeOfUint64: Codable {
    public let end: UInt64
    public let start: UInt64

    public init(
        end: UInt64,
        start: UInt64
    ) {
        self.end = end
        self.start = start
    }
}

// MARK: - ReceiptView

public struct ReceiptView: Codable {
    public let predecessorId: AccountId
    public let priority: UInt64?
    public let receipt: ReceiptEnumView
    public let receiptId: CryptoHash
    public let receiverId: AccountId

    public init(
        predecessorId: AccountId,
        priority: UInt64?,
        receipt: ReceiptEnumView,
        receiptId: CryptoHash,
        receiverId: AccountId
    ) {
        self.predecessorId = predecessorId
        self.priority = priority
        self.receipt = receipt
        self.receiptId = receiptId
        self.receiverId = receiverId
    }
}

// MARK: - RpcBlockResponse

public struct RpcBlockResponse: Codable {
    public let author: AccountId
    public let chunks: [ChunkHeaderView]
    public let header: BlockHeaderView

    public init(
        author: AccountId,
        chunks: [ChunkHeaderView],
        header: BlockHeaderView
    ) {
        self.author = author
        self.chunks = chunks
        self.header = header
    }
}

// MARK: - RpcChunkResponse

public struct RpcChunkResponse: Codable {
    public let author: AccountId
    public let header: ChunkHeaderView
    public let receipts: [ReceiptView]
    public let transactions: [SignedTransactionView]

    public init(
        author: AccountId,
        header: ChunkHeaderView,
        receipts: [ReceiptView],
        transactions: [SignedTransactionView]
    ) {
        self.author = author
        self.header = header
        self.receipts = receipts
        self.transactions = transactions
    }
}

// MARK: - RpcClientConfigResponse

public struct RpcClientConfigResponse: Codable {
    public let archive: Bool
    public let blockFetchHorizon: UInt64
    public let blockHeaderFetchHorizon: UInt64
    public let blockProductionTrackingDelay: [UInt64]
    public let catchupStepPeriod: [UInt64]
    public let chainId: String
    public let chunkDistributionNetwork: ChunkDistributionNetworkConfig?
    public let chunkRequestRetryPeriod: [UInt64]
    public let chunkValidationThreads: Int
    public let chunkWaitMult: [Int32]
    public let clientBackgroundMigrationThreads: Int
    public let cloudArchivalReader: CloudArchivalReaderConfig?
    public let cloudArchivalWriter: CloudArchivalWriterConfig?
    public let doomslugStepPeriod: [UInt64]
    public let enableMultilineLogging: Bool
    public let enableStatisticsExport: Bool
    public let epochLength: UInt64
    public let epochSync: EpochSyncConfig
    public let expectedShutdown: MutableConfigValue
    public let gc: GCConfig
    public let headerSyncExpectedHeightPerSecond: UInt64
    public let headerSyncInitialTimeout: [UInt64]
    public let headerSyncProgressTimeout: [UInt64]
    public let headerSyncStallBanTimeout: [UInt64]
    public let logSummaryPeriod: [UInt64]
    public let logSummaryStyle: LogSummaryStyle
    public let maxBlockProductionDelay: [UInt64]
    public let maxBlockWaitDelay: [UInt64]
    public let maxGasBurntView: NearGas?
    public let minBlockProductionDelay: [UInt64]
    public let minNumPeers: Int
    public let numBlockProducerSeats: UInt64
    public let orphanStateWitnessMaxSize: UInt64
    public let orphanStateWitnessPoolSize: Int
    public let produceChunkAddTransactionsTimeLimit: String
    public let produceEmptyBlocks: Bool
    public let protocolVersionCheck: ProtocolVersionCheckConfig
    public let reshardingConfig: MutableConfigValue
    public let rpcAddr: String?
    public let saveInvalidWitnesses: Bool
    public let saveLatestWitnesses: Bool
    public let saveTrieChanges: Bool
    public let saveTxOutcomes: Bool
    public let saveUntrackedPartialChunksParts: Bool
    public let skipSyncWait: Bool
    public let stateRequestServerThreads: Int
    public let stateRequestThrottlePeriod: [UInt64]
    public let stateRequestsPerThrottlePeriod: Int
    public let stateSync: StateSyncConfig
    public let stateSyncEnabled: Bool
    public let stateSyncExternalBackoff: [UInt64]
    public let stateSyncExternalTimeout: [UInt64]
    public let stateSyncP2PTimeout: [UInt64]
    public let stateSyncRetryBackoff: [UInt64]
    public let syncCheckPeriod: [UInt64]
    public let syncHeightThreshold: UInt64
    public let syncMaxBlockRequests: Int
    public let syncStepPeriod: [UInt64]
    public let trackedShardsConfig: TrackedShardsConfig
    public let transactionPoolSizeLimit: UInt64?
    public let transactionRequestHandlerThreads: Int
    public let trieViewerStateSizeLimit: UInt64?
    public let ttlAccountIdRouter: [UInt64]
    public let txRoutingHeightHorizon: UInt64
    public let version: Version
    public let viewClientThreads: Int

    public init(
        archive: Bool,
        blockFetchHorizon: UInt64,
        blockHeaderFetchHorizon: UInt64,
        blockProductionTrackingDelay: [UInt64],
        catchupStepPeriod: [UInt64],
        chainId: String,
        chunkDistributionNetwork: ChunkDistributionNetworkConfig?,
        chunkRequestRetryPeriod: [UInt64],
        chunkValidationThreads: Int,
        chunkWaitMult: [Int32],
        clientBackgroundMigrationThreads: Int,
        cloudArchivalReader: CloudArchivalReaderConfig?,
        cloudArchivalWriter: CloudArchivalWriterConfig?,
        doomslugStepPeriod: [UInt64],
        enableMultilineLogging: Bool,
        enableStatisticsExport: Bool,
        epochLength: UInt64,
        epochSync: EpochSyncConfig,
        expectedShutdown: MutableConfigValue,
        gc: GCConfig,
        headerSyncExpectedHeightPerSecond: UInt64,
        headerSyncInitialTimeout: [UInt64],
        headerSyncProgressTimeout: [UInt64],
        headerSyncStallBanTimeout: [UInt64],
        logSummaryPeriod: [UInt64],
        logSummaryStyle: LogSummaryStyle,
        maxBlockProductionDelay: [UInt64],
        maxBlockWaitDelay: [UInt64],
        maxGasBurntView: NearGas?,
        minBlockProductionDelay: [UInt64],
        minNumPeers: Int,
        numBlockProducerSeats: UInt64,
        orphanStateWitnessMaxSize: UInt64,
        orphanStateWitnessPoolSize: Int,
        produceChunkAddTransactionsTimeLimit: String,
        produceEmptyBlocks: Bool,
        protocolVersionCheck: ProtocolVersionCheckConfig,
        reshardingConfig: MutableConfigValue,
        rpcAddr: String?,
        saveInvalidWitnesses: Bool,
        saveLatestWitnesses: Bool,
        saveTrieChanges: Bool,
        saveTxOutcomes: Bool,
        saveUntrackedPartialChunksParts: Bool,
        skipSyncWait: Bool,
        stateRequestServerThreads: Int,
        stateRequestThrottlePeriod: [UInt64],
        stateRequestsPerThrottlePeriod: Int,
        stateSync: StateSyncConfig,
        stateSyncEnabled: Bool,
        stateSyncExternalBackoff: [UInt64],
        stateSyncExternalTimeout: [UInt64],
        stateSyncP2PTimeout: [UInt64],
        stateSyncRetryBackoff: [UInt64],
        syncCheckPeriod: [UInt64],
        syncHeightThreshold: UInt64,
        syncMaxBlockRequests: Int,
        syncStepPeriod: [UInt64],
        trackedShardsConfig: TrackedShardsConfig,
        transactionPoolSizeLimit: UInt64?,
        transactionRequestHandlerThreads: Int,
        trieViewerStateSizeLimit: UInt64?,
        ttlAccountIdRouter: [UInt64],
        txRoutingHeightHorizon: UInt64,
        version: Version,
        viewClientThreads: Int
    ) {
        self.archive = archive
        self.blockFetchHorizon = blockFetchHorizon
        self.blockHeaderFetchHorizon = blockHeaderFetchHorizon
        self.blockProductionTrackingDelay = blockProductionTrackingDelay
        self.catchupStepPeriod = catchupStepPeriod
        self.chainId = chainId
        self.chunkDistributionNetwork = chunkDistributionNetwork
        self.chunkRequestRetryPeriod = chunkRequestRetryPeriod
        self.chunkValidationThreads = chunkValidationThreads
        self.chunkWaitMult = chunkWaitMult
        self.clientBackgroundMigrationThreads = clientBackgroundMigrationThreads
        self.cloudArchivalReader = cloudArchivalReader
        self.cloudArchivalWriter = cloudArchivalWriter
        self.doomslugStepPeriod = doomslugStepPeriod
        self.enableMultilineLogging = enableMultilineLogging
        self.enableStatisticsExport = enableStatisticsExport
        self.epochLength = epochLength
        self.epochSync = epochSync
        self.expectedShutdown = expectedShutdown
        self.gc = gc
        self.headerSyncExpectedHeightPerSecond = headerSyncExpectedHeightPerSecond
        self.headerSyncInitialTimeout = headerSyncInitialTimeout
        self.headerSyncProgressTimeout = headerSyncProgressTimeout
        self.headerSyncStallBanTimeout = headerSyncStallBanTimeout
        self.logSummaryPeriod = logSummaryPeriod
        self.logSummaryStyle = logSummaryStyle
        self.maxBlockProductionDelay = maxBlockProductionDelay
        self.maxBlockWaitDelay = maxBlockWaitDelay
        self.maxGasBurntView = maxGasBurntView
        self.minBlockProductionDelay = minBlockProductionDelay
        self.minNumPeers = minNumPeers
        self.numBlockProducerSeats = numBlockProducerSeats
        self.orphanStateWitnessMaxSize = orphanStateWitnessMaxSize
        self.orphanStateWitnessPoolSize = orphanStateWitnessPoolSize
        self.produceChunkAddTransactionsTimeLimit = produceChunkAddTransactionsTimeLimit
        self.produceEmptyBlocks = produceEmptyBlocks
        self.protocolVersionCheck = protocolVersionCheck
        self.reshardingConfig = reshardingConfig
        self.rpcAddr = rpcAddr
        self.saveInvalidWitnesses = saveInvalidWitnesses
        self.saveLatestWitnesses = saveLatestWitnesses
        self.saveTrieChanges = saveTrieChanges
        self.saveTxOutcomes = saveTxOutcomes
        self.saveUntrackedPartialChunksParts = saveUntrackedPartialChunksParts
        self.skipSyncWait = skipSyncWait
        self.stateRequestServerThreads = stateRequestServerThreads
        self.stateRequestThrottlePeriod = stateRequestThrottlePeriod
        self.stateRequestsPerThrottlePeriod = stateRequestsPerThrottlePeriod
        self.stateSync = stateSync
        self.stateSyncEnabled = stateSyncEnabled
        self.stateSyncExternalBackoff = stateSyncExternalBackoff
        self.stateSyncExternalTimeout = stateSyncExternalTimeout
        self.stateSyncP2PTimeout = stateSyncP2PTimeout
        self.stateSyncRetryBackoff = stateSyncRetryBackoff
        self.syncCheckPeriod = syncCheckPeriod
        self.syncHeightThreshold = syncHeightThreshold
        self.syncMaxBlockRequests = syncMaxBlockRequests
        self.syncStepPeriod = syncStepPeriod
        self.trackedShardsConfig = trackedShardsConfig
        self.transactionPoolSizeLimit = transactionPoolSizeLimit
        self.transactionRequestHandlerThreads = transactionRequestHandlerThreads
        self.trieViewerStateSizeLimit = trieViewerStateSizeLimit
        self.ttlAccountIdRouter = ttlAccountIdRouter
        self.txRoutingHeightHorizon = txRoutingHeightHorizon
        self.version = version
        self.viewClientThreads = viewClientThreads
    }
}

// MARK: - RpcCongestionLevelResponse

public struct RpcCongestionLevelResponse: Codable {
    public let congestionLevel: Double

    public init(
        congestionLevel: Double
    ) {
        self.congestionLevel = congestionLevel
    }
}

// MARK: - RpcGasPriceRequest

public struct RpcGasPriceRequest: Codable {
    public let blockId: BlockId?

    public init(
        blockId: BlockId?
    ) {
        self.blockId = blockId
    }
}

// MARK: - RpcGasPriceResponse

public struct RpcGasPriceResponse: Codable {
    public let gasPrice: NearToken

    public init(
        gasPrice: NearToken
    ) {
        self.gasPrice = gasPrice
    }
}

// MARK: - RpcKnownProducer

public struct RpcKnownProducer: Codable {
    public let accountId: AccountId
    public let addr: String?
    public let peerId: PeerId

    public init(
        accountId: AccountId,
        addr: String?,
        peerId: PeerId
    ) {
        self.accountId = accountId
        self.addr = addr
        self.peerId = peerId
    }
}

// MARK: - RpcLightClientBlockProofRequest

public struct RpcLightClientBlockProofRequest: Codable {
    public let blockHash: CryptoHash
    public let lightClientHead: CryptoHash

    public init(
        blockHash: CryptoHash,
        lightClientHead: CryptoHash
    ) {
        self.blockHash = blockHash
        self.lightClientHead = lightClientHead
    }
}

// MARK: - RpcLightClientBlockProofResponse

public struct RpcLightClientBlockProofResponse: Codable {
    public let blockHeaderLite: LightClientBlockLiteView
    public let blockProof: [MerklePathItem]

    public init(
        blockHeaderLite: LightClientBlockLiteView,
        blockProof: [MerklePathItem]
    ) {
        self.blockHeaderLite = blockHeaderLite
        self.blockProof = blockProof
    }
}

// MARK: - RpcLightClientExecutionProofResponse

public struct RpcLightClientExecutionProofResponse: Codable {
    public let blockHeaderLite: LightClientBlockLiteView
    public let blockProof: [MerklePathItem]
    public let outcomeProof: ExecutionOutcomeWithIdView
    public let outcomeRootProof: [MerklePathItem]

    public init(
        blockHeaderLite: LightClientBlockLiteView,
        blockProof: [MerklePathItem],
        outcomeProof: ExecutionOutcomeWithIdView,
        outcomeRootProof: [MerklePathItem]
    ) {
        self.blockHeaderLite = blockHeaderLite
        self.blockProof = blockProof
        self.outcomeProof = outcomeProof
        self.outcomeRootProof = outcomeRootProof
    }
}

// MARK: - RpcLightClientNextBlockRequest

public struct RpcLightClientNextBlockRequest: Codable {
    public let lastBlockHash: CryptoHash

    public init(
        lastBlockHash: CryptoHash
    ) {
        self.lastBlockHash = lastBlockHash
    }
}

// MARK: - RpcLightClientNextBlockResponse

public struct RpcLightClientNextBlockResponse: Codable {
    public let approvalsAfterNext: [Signature?]?
    public let innerLite: BlockHeaderInnerLiteView?
    public let innerRestHash: CryptoHash?
    public let nextBlockInnerHash: CryptoHash?
    public let nextBps: [ValidatorStakeView]?
    public let prevBlockHash: CryptoHash?

    public init(
        approvalsAfterNext: [Signature?]?,
        innerLite: BlockHeaderInnerLiteView?,
        innerRestHash: CryptoHash?,
        nextBlockInnerHash: CryptoHash?,
        nextBps: [ValidatorStakeView]?,
        prevBlockHash: CryptoHash?
    ) {
        self.approvalsAfterNext = approvalsAfterNext
        self.innerLite = innerLite
        self.innerRestHash = innerRestHash
        self.nextBlockInnerHash = nextBlockInnerHash
        self.nextBps = nextBps
        self.prevBlockHash = prevBlockHash
    }
}

// MARK: - RpcMaintenanceWindowsRequest

public struct RpcMaintenanceWindowsRequest: Codable {
    public let accountId: AccountId

    public init(
        accountId: AccountId
    ) {
        self.accountId = accountId
    }
}

// MARK: - RpcNetworkInfoResponse

public struct RpcNetworkInfoResponse: Codable {
    public let activePeers: [RpcPeerInfo]
    public let knownProducers: [RpcKnownProducer]
    public let numActivePeers: Int
    public let peerMaxCount: Int
    public let receivedBytesPerSec: UInt64
    public let sentBytesPerSec: UInt64

    public init(
        activePeers: [RpcPeerInfo],
        knownProducers: [RpcKnownProducer],
        numActivePeers: Int,
        peerMaxCount: Int,
        receivedBytesPerSec: UInt64,
        sentBytesPerSec: UInt64
    ) {
        self.activePeers = activePeers
        self.knownProducers = knownProducers
        self.numActivePeers = numActivePeers
        self.peerMaxCount = peerMaxCount
        self.receivedBytesPerSec = receivedBytesPerSec
        self.sentBytesPerSec = sentBytesPerSec
    }
}

// MARK: - RpcPeerInfo

public struct RpcPeerInfo: Codable {
    public let accountId: AccountId?
    public let addr: String?
    public let id: PeerId

    public init(
        accountId: AccountId?,
        addr: String?,
        id: PeerId
    ) {
        self.accountId = accountId
        self.addr = addr
        self.id = id
    }
}

// MARK: - RpcProtocolConfigResponse

public struct RpcProtocolConfigResponse: Codable {
    public let avgHiddenValidatorSeatsPerShard: [UInt64]
    public let blockProducerKickoutThreshold: Int
    public let chainId: String
    public let chunkProducerKickoutThreshold: Int
    public let chunkValidatorOnlyKickoutThreshold: Int
    public let dynamicResharding: Bool
    public let epochLength: UInt64
    public let fishermenThreshold: NearToken
    public let gasLimit: NearGas
    public let gasPriceAdjustmentRate: [Int32]
    public let genesisHeight: UInt64
    public let genesisTime: String
    public let maxGasPrice: NearToken
    public let maxInflationRate: [Int32]
    public let maxKickoutStakePerc: Int
    public let minGasPrice: NearToken
    public let minimumStakeDivisor: UInt64
    public let minimumStakeRatio: [Int32]
    public let minimumValidatorsPerShard: UInt64
    public let numBlockProducerSeats: UInt64
    public let numBlockProducerSeatsPerShard: [UInt64]
    public let numBlocksPerYear: UInt64
    public let onlineMaxThreshold: [Int32]
    public let onlineMinThreshold: [Int32]
    public let protocolRewardRate: [Int32]
    public let protocolTreasuryAccount: AccountId
    public let protocolUpgradeStakeThreshold: [Int32]
    public let protocolVersion: Int
    public let runtimeConfig: RuntimeConfigView
    public let shardLayout: ShardLayout
    public let shuffleShardAssignmentForChunkProducers: Bool
    public let targetValidatorMandatesPerShard: UInt64
    public let transactionValidityPeriod: UInt64

    public init(
        avgHiddenValidatorSeatsPerShard: [UInt64],
        blockProducerKickoutThreshold: Int,
        chainId: String,
        chunkProducerKickoutThreshold: Int,
        chunkValidatorOnlyKickoutThreshold: Int,
        dynamicResharding: Bool,
        epochLength: UInt64,
        fishermenThreshold: NearToken,
        gasLimit: NearGas,
        gasPriceAdjustmentRate: [Int32],
        genesisHeight: UInt64,
        genesisTime: String,
        maxGasPrice: NearToken,
        maxInflationRate: [Int32],
        maxKickoutStakePerc: Int,
        minGasPrice: NearToken,
        minimumStakeDivisor: UInt64,
        minimumStakeRatio: [Int32],
        minimumValidatorsPerShard: UInt64,
        numBlockProducerSeats: UInt64,
        numBlockProducerSeatsPerShard: [UInt64],
        numBlocksPerYear: UInt64,
        onlineMaxThreshold: [Int32],
        onlineMinThreshold: [Int32],
        protocolRewardRate: [Int32],
        protocolTreasuryAccount: AccountId,
        protocolUpgradeStakeThreshold: [Int32],
        protocolVersion: Int,
        runtimeConfig: RuntimeConfigView,
        shardLayout: ShardLayout,
        shuffleShardAssignmentForChunkProducers: Bool,
        targetValidatorMandatesPerShard: UInt64,
        transactionValidityPeriod: UInt64
    ) {
        self.avgHiddenValidatorSeatsPerShard = avgHiddenValidatorSeatsPerShard
        self.blockProducerKickoutThreshold = blockProducerKickoutThreshold
        self.chainId = chainId
        self.chunkProducerKickoutThreshold = chunkProducerKickoutThreshold
        self.chunkValidatorOnlyKickoutThreshold = chunkValidatorOnlyKickoutThreshold
        self.dynamicResharding = dynamicResharding
        self.epochLength = epochLength
        self.fishermenThreshold = fishermenThreshold
        self.gasLimit = gasLimit
        self.gasPriceAdjustmentRate = gasPriceAdjustmentRate
        self.genesisHeight = genesisHeight
        self.genesisTime = genesisTime
        self.maxGasPrice = maxGasPrice
        self.maxInflationRate = maxInflationRate
        self.maxKickoutStakePerc = maxKickoutStakePerc
        self.minGasPrice = minGasPrice
        self.minimumStakeDivisor = minimumStakeDivisor
        self.minimumStakeRatio = minimumStakeRatio
        self.minimumValidatorsPerShard = minimumValidatorsPerShard
        self.numBlockProducerSeats = numBlockProducerSeats
        self.numBlockProducerSeatsPerShard = numBlockProducerSeatsPerShard
        self.numBlocksPerYear = numBlocksPerYear
        self.onlineMaxThreshold = onlineMaxThreshold
        self.onlineMinThreshold = onlineMinThreshold
        self.protocolRewardRate = protocolRewardRate
        self.protocolTreasuryAccount = protocolTreasuryAccount
        self.protocolUpgradeStakeThreshold = protocolUpgradeStakeThreshold
        self.protocolVersion = protocolVersion
        self.runtimeConfig = runtimeConfig
        self.shardLayout = shardLayout
        self.shuffleShardAssignmentForChunkProducers = shuffleShardAssignmentForChunkProducers
        self.targetValidatorMandatesPerShard = targetValidatorMandatesPerShard
        self.transactionValidityPeriod = transactionValidityPeriod
    }
}

// MARK: - RpcReceiptRequest

public struct RpcReceiptRequest: Codable {
    public let receiptId: CryptoHash

    public init(
        receiptId: CryptoHash
    ) {
        self.receiptId = receiptId
    }
}

// MARK: - RpcReceiptResponse

public struct RpcReceiptResponse: Codable {
    public let predecessorId: AccountId
    public let priority: UInt64?
    public let receipt: ReceiptEnumView
    public let receiptId: CryptoHash
    public let receiverId: AccountId

    public init(
        predecessorId: AccountId,
        priority: UInt64?,
        receipt: ReceiptEnumView,
        receiptId: CryptoHash,
        receiverId: AccountId
    ) {
        self.predecessorId = predecessorId
        self.priority = priority
        self.receipt = receipt
        self.receiptId = receiptId
        self.receiverId = receiverId
    }
}

// MARK: - RpcSendTransactionRequest

public struct RpcSendTransactionRequest: Codable {
    public let signedTxBase64: SignedTransaction
    public let waitUntil: TxExecutionStatus?

    public init(
        signedTxBase64: SignedTransaction,
        waitUntil: TxExecutionStatus?
    ) {
        self.signedTxBase64 = signedTxBase64
        self.waitUntil = waitUntil
    }
}

// MARK: - RpcSplitStorageInfoRequest

public struct RpcSplitStorageInfoRequest: Codable {
    public init() {}
}

// MARK: - RpcSplitStorageInfoResponse

public struct RpcSplitStorageInfoResponse: Codable {
    public let coldHeadHeight: UInt64?
    public let finalHeadHeight: UInt64?
    public let headHeight: UInt64?
    public let hotDbKind: String?

    public init(
        coldHeadHeight: UInt64?,
        finalHeadHeight: UInt64?,
        headHeight: UInt64?,
        hotDbKind: String?
    ) {
        self.coldHeadHeight = coldHeadHeight
        self.finalHeadHeight = finalHeadHeight
        self.headHeight = headHeight
        self.hotDbKind = hotDbKind
    }
}

// MARK: - RpcStateChangesInBlockByTypeResponse

public struct RpcStateChangesInBlockByTypeResponse: Codable {
    public let blockHash: CryptoHash
    public let changes: [StateChangeKindView]

    public init(
        blockHash: CryptoHash,
        changes: [StateChangeKindView]
    ) {
        self.blockHash = blockHash
        self.changes = changes
    }
}

// MARK: - RpcStateChangesInBlockResponse

public struct RpcStateChangesInBlockResponse: Codable {
    public let blockHash: CryptoHash
    public let changes: [StateChangeWithCauseView]

    public init(
        blockHash: CryptoHash,
        changes: [StateChangeWithCauseView]
    ) {
        self.blockHash = blockHash
        self.changes = changes
    }
}

// MARK: - RpcStatusResponse

public struct RpcStatusResponse: Codable {
    public let chainId: String
    public let detailedDebugStatus: DetailedDebugStatus?
    public let genesisHash: CryptoHash
    public let latestProtocolVersion: Int
    public let nodeKey: PublicKey?
    public let nodePublicKey: PublicKey
    public let protocolVersion: Int
    public let rpcAddr: String?
    public let syncInfo: StatusSyncInfo
    public let uptimeSec: Int64
    public let validatorAccountId: AccountId?
    public let validatorPublicKey: PublicKey?
    public let validators: [ValidatorInfo]
    public let version: Version

    public init(
        chainId: String,
        detailedDebugStatus: DetailedDebugStatus?,
        genesisHash: CryptoHash,
        latestProtocolVersion: Int,
        nodeKey: PublicKey?,
        nodePublicKey: PublicKey,
        protocolVersion: Int,
        rpcAddr: String?,
        syncInfo: StatusSyncInfo,
        uptimeSec: Int64,
        validatorAccountId: AccountId?,
        validatorPublicKey: PublicKey?,
        validators: [ValidatorInfo],
        version: Version
    ) {
        self.chainId = chainId
        self.detailedDebugStatus = detailedDebugStatus
        self.genesisHash = genesisHash
        self.latestProtocolVersion = latestProtocolVersion
        self.nodeKey = nodeKey
        self.nodePublicKey = nodePublicKey
        self.protocolVersion = protocolVersion
        self.rpcAddr = rpcAddr
        self.syncInfo = syncInfo
        self.uptimeSec = uptimeSec
        self.validatorAccountId = validatorAccountId
        self.validatorPublicKey = validatorPublicKey
        self.validators = validators
        self.version = version
    }
}

// MARK: - RpcValidatorResponse

public struct RpcValidatorResponse: Codable {
    public let currentFishermen: [ValidatorStakeView]
    public let currentProposals: [ValidatorStakeView]
    public let currentValidators: [CurrentEpochValidatorInfo]
    public let epochHeight: UInt64
    public let epochStartHeight: UInt64
    public let nextFishermen: [ValidatorStakeView]
    public let nextValidators: [NextEpochValidatorInfo]
    public let prevEpochKickout: [ValidatorKickoutView]

    public init(
        currentFishermen: [ValidatorStakeView],
        currentProposals: [ValidatorStakeView],
        currentValidators: [CurrentEpochValidatorInfo],
        epochHeight: UInt64,
        epochStartHeight: UInt64,
        nextFishermen: [ValidatorStakeView],
        nextValidators: [NextEpochValidatorInfo],
        prevEpochKickout: [ValidatorKickoutView]
    ) {
        self.currentFishermen = currentFishermen
        self.currentProposals = currentProposals
        self.currentValidators = currentValidators
        self.epochHeight = epochHeight
        self.epochStartHeight = epochStartHeight
        self.nextFishermen = nextFishermen
        self.nextValidators = nextValidators
        self.prevEpochKickout = prevEpochKickout
    }
}

// MARK: - RpcValidatorsOrderedRequest

public struct RpcValidatorsOrderedRequest: Codable {
    public let blockId: BlockId?

    public init(
        blockId: BlockId?
    ) {
        self.blockId = blockId
    }
}

// MARK: - RuntimeConfigView

public struct RuntimeConfigView: Codable {
    public let accountCreationConfig: AccountCreationConfigView
    public let congestionControlConfig: CongestionControlConfigView
    public let storageAmountPerByte: NearToken
    public let transactionCosts: RuntimeFeesConfigView
    public let wasmConfig: VMConfigView
    public let witnessConfig: WitnessConfigView

    public init(
        accountCreationConfig: AccountCreationConfigView,
        congestionControlConfig: CongestionControlConfigView,
        storageAmountPerByte: NearToken,
        transactionCosts: RuntimeFeesConfigView,
        wasmConfig: VMConfigView,
        witnessConfig: WitnessConfigView
    ) {
        self.accountCreationConfig = accountCreationConfig
        self.congestionControlConfig = congestionControlConfig
        self.storageAmountPerByte = storageAmountPerByte
        self.transactionCosts = transactionCosts
        self.wasmConfig = wasmConfig
        self.witnessConfig = witnessConfig
    }
}

// MARK: - RuntimeFeesConfigView

public struct RuntimeFeesConfigView: Codable {
    public let actionCreationConfig: ActionCreationConfigView
    public let actionReceiptCreationConfig: Fee
    public let burntGasReward: [Int32]
    public let dataReceiptCreationConfig: DataReceiptCreationConfigView
    public let pessimisticGasPriceInflationRatio: [Int32]
    public let storageUsageConfig: StorageUsageConfigView

    public init(
        actionCreationConfig: ActionCreationConfigView,
        actionReceiptCreationConfig: Fee,
        burntGasReward: [Int32],
        dataReceiptCreationConfig: DataReceiptCreationConfigView,
        pessimisticGasPriceInflationRatio: [Int32],
        storageUsageConfig: StorageUsageConfigView
    ) {
        self.actionCreationConfig = actionCreationConfig
        self.actionReceiptCreationConfig = actionReceiptCreationConfig
        self.burntGasReward = burntGasReward
        self.dataReceiptCreationConfig = dataReceiptCreationConfig
        self.pessimisticGasPriceInflationRatio = pessimisticGasPriceInflationRatio
        self.storageUsageConfig = storageUsageConfig
    }
}

// MARK: - ShardLayoutV0

public struct ShardLayoutV0: Codable {
    public let numShards: UInt64
    public let version: Int

    public init(
        numShards: UInt64,
        version: Int
    ) {
        self.numShards = numShards
        self.version = version
    }
}

// MARK: - ShardLayoutV1

public struct ShardLayoutV1: Codable {
    public let boundaryAccounts: [AccountId]
    public let shardsSplitMap: [[ShardId]]?
    public let toParentShardMap: [ShardId]?
    public let version: Int

    public init(
        boundaryAccounts: [AccountId],
        shardsSplitMap: [[ShardId]]?,
        toParentShardMap: [ShardId]?,
        version: Int
    ) {
        self.boundaryAccounts = boundaryAccounts
        self.shardsSplitMap = shardsSplitMap
        self.toParentShardMap = toParentShardMap
        self.version = version
    }
}

// MARK: - ShardLayoutV2

public struct ShardLayoutV2: Codable {
    public let boundaryAccounts: [AccountId]
    public let idToIndexMap: [String: Int]
    public let indexToIdMap: [String: ShardId]
    public let shardIds: [ShardId]
    public let shardsParentMap: [String: ShardId]?
    public let shardsSplitMap: [String: [ShardId]]?
    public let version: Int

    public init(
        boundaryAccounts: [AccountId],
        idToIndexMap: [String: Int],
        indexToIdMap: [String: ShardId],
        shardIds: [ShardId],
        shardsParentMap: [String: ShardId]?,
        shardsSplitMap: [String: [ShardId]]?,
        version: Int
    ) {
        self.boundaryAccounts = boundaryAccounts
        self.idToIndexMap = idToIndexMap
        self.indexToIdMap = indexToIdMap
        self.shardIds = shardIds
        self.shardsParentMap = shardsParentMap
        self.shardsSplitMap = shardsSplitMap
        self.version = version
    }
}

// MARK: - ShardUId

public struct ShardUId: Codable {
    public let shardId: Int
    public let version: Int

    public init(
        shardId: Int,
        version: Int
    ) {
        self.shardId = shardId
        self.version = version
    }
}

// MARK: - SignedDelegateAction

public struct SignedDelegateAction: Codable {
    public let delegateAction: DelegateAction
    public let signature: Signature

    public init(
        delegateAction: DelegateAction,
        signature: Signature
    ) {
        self.delegateAction = delegateAction
        self.signature = signature
    }
}

// MARK: - SignedTransactionView

public struct SignedTransactionView: Codable {
    public let actions: [ActionView]
    public let hash: CryptoHash
    public let nonce: UInt64
    public let priorityFee: UInt64?
    public let publicKey: PublicKey
    public let receiverId: AccountId
    public let signature: Signature
    public let signerId: AccountId

    public init(
        actions: [ActionView],
        hash: CryptoHash,
        nonce: UInt64,
        priorityFee: UInt64?,
        publicKey: PublicKey,
        receiverId: AccountId,
        signature: Signature,
        signerId: AccountId
    ) {
        self.actions = actions
        self.hash = hash
        self.nonce = nonce
        self.priorityFee = priorityFee
        self.publicKey = publicKey
        self.receiverId = receiverId
        self.signature = signature
        self.signerId = signerId
    }
}

// MARK: - SlashedValidator

public struct SlashedValidator: Codable {
    public let accountId: AccountId
    public let isDoubleSign: Bool

    public init(
        accountId: AccountId,
        isDoubleSign: Bool
    ) {
        self.accountId = accountId
        self.isDoubleSign = isDoubleSign
    }
}

// MARK: - StakeAction

public struct StakeAction: Codable {
    public let publicKey: PublicKey
    public let stake: NearToken

    public init(
        publicKey: PublicKey,
        stake: NearToken
    ) {
        self.publicKey = publicKey
        self.stake = stake
    }
}

// MARK: - StateItem

public struct StateItem: Codable {
    public let key: StoreKey
    public let value: StoreValue

    public init(
        key: StoreKey,
        value: StoreValue
    ) {
        self.key = key
        self.value = value
    }
}

// MARK: - StateSyncConfig

public struct StateSyncConfig: Codable {
    public let concurrency: SyncConcurrency?
    public let dump: DumpConfig?
    public let partsCompressionLvl: Int32?
    public let sync: SyncConfig?

    public init(
        concurrency: SyncConcurrency?,
        dump: DumpConfig?,
        partsCompressionLvl: Int32?,
        sync: SyncConfig?
    ) {
        self.concurrency = concurrency
        self.dump = dump
        self.partsCompressionLvl = partsCompressionLvl
        self.sync = sync
    }
}

// MARK: - StatusSyncInfo

public struct StatusSyncInfo: Codable {
    public let earliestBlockHash: CryptoHash?
    public let earliestBlockHeight: UInt64?
    public let earliestBlockTime: String?
    public let epochId: EpochId?
    public let epochStartHeight: UInt64?
    public let latestBlockHash: CryptoHash
    public let latestBlockHeight: UInt64
    public let latestBlockTime: String
    public let latestStateRoot: CryptoHash
    public let syncing: Bool

    public init(
        earliestBlockHash: CryptoHash?,
        earliestBlockHeight: UInt64?,
        earliestBlockTime: String?,
        epochId: EpochId?,
        epochStartHeight: UInt64?,
        latestBlockHash: CryptoHash,
        latestBlockHeight: UInt64,
        latestBlockTime: String,
        latestStateRoot: CryptoHash,
        syncing: Bool
    ) {
        self.earliestBlockHash = earliestBlockHash
        self.earliestBlockHeight = earliestBlockHeight
        self.earliestBlockTime = earliestBlockTime
        self.epochId = epochId
        self.epochStartHeight = epochStartHeight
        self.latestBlockHash = latestBlockHash
        self.latestBlockHeight = latestBlockHeight
        self.latestBlockTime = latestBlockTime
        self.latestStateRoot = latestStateRoot
        self.syncing = syncing
    }
}

// MARK: - StorageUsageConfigView

public struct StorageUsageConfigView: Codable {
    public let numBytesAccount: UInt64
    public let numExtraBytesRecord: UInt64

    public init(
        numBytesAccount: UInt64,
        numExtraBytesRecord: UInt64
    ) {
        self.numBytesAccount = numBytesAccount
        self.numExtraBytesRecord = numExtraBytesRecord
    }
}

// MARK: - SyncConcurrency

public struct SyncConcurrency: Codable {
    public let apply: Int
    public let applyDuringCatchup: Int
    public let peerDownloads: Int
    public let perShard: Int

    public init(
        apply: Int,
        applyDuringCatchup: Int,
        peerDownloads: Int,
        perShard: Int
    ) {
        self.apply = apply
        self.applyDuringCatchup = applyDuringCatchup
        self.peerDownloads = peerDownloads
        self.perShard = perShard
    }
}

// MARK: - Tier1ProxyView

public struct Tier1ProxyView: Codable {
    public let addr: String
    public let peerId: PublicKey

    public init(
        addr: String,
        peerId: PublicKey
    ) {
        self.addr = addr
        self.peerId = peerId
    }
}

// MARK: - TransferAction

public struct TransferAction: Codable {
    public let deposit: NearToken

    public init(
        deposit: NearToken
    ) {
        self.deposit = deposit
    }
}

// MARK: - UseGlobalContractAction

public struct UseGlobalContractAction: Codable {
    public let contractIdentifier: GlobalContractIdentifier

    public init(
        contractIdentifier: GlobalContractIdentifier
    ) {
        self.contractIdentifier = contractIdentifier
    }
}

// MARK: - VMConfigView

public struct VMConfigView: Codable {
    public let deterministicAccountIds: Bool
    public let discardCustomSections: Bool
    public let ethImplicitAccounts: Bool
    public let extCosts: ExtCostsConfigView
    public let fixContractLoadingCost: Bool
    public let globalContractHostFns: Bool
    public let growMemCost: Int
    public let implicitAccountCreation: Bool
    public let limitConfig: LimitConfig
    public let reftypesBulkMemory: Bool
    public let regularOpCost: Int
    public let saturatingFloatToInt: Bool
    public let storageGetMode: StorageGetMode
    public let vmKind: VMKind

    public init(
        deterministicAccountIds: Bool,
        discardCustomSections: Bool,
        ethImplicitAccounts: Bool,
        extCosts: ExtCostsConfigView,
        fixContractLoadingCost: Bool,
        globalContractHostFns: Bool,
        growMemCost: Int,
        implicitAccountCreation: Bool,
        limitConfig: LimitConfig,
        reftypesBulkMemory: Bool,
        regularOpCost: Int,
        saturatingFloatToInt: Bool,
        storageGetMode: StorageGetMode,
        vmKind: VMKind
    ) {
        self.deterministicAccountIds = deterministicAccountIds
        self.discardCustomSections = discardCustomSections
        self.ethImplicitAccounts = ethImplicitAccounts
        self.extCosts = extCosts
        self.fixContractLoadingCost = fixContractLoadingCost
        self.globalContractHostFns = globalContractHostFns
        self.growMemCost = growMemCost
        self.implicitAccountCreation = implicitAccountCreation
        self.limitConfig = limitConfig
        self.reftypesBulkMemory = reftypesBulkMemory
        self.regularOpCost = regularOpCost
        self.saturatingFloatToInt = saturatingFloatToInt
        self.storageGetMode = storageGetMode
        self.vmKind = vmKind
    }
}

// MARK: - ValidatorInfo

public struct ValidatorInfo: Codable {
    public let accountId: AccountId

    public init(
        accountId: AccountId
    ) {
        self.accountId = accountId
    }
}

// MARK: - ValidatorKickoutView

public struct ValidatorKickoutView: Codable {
    public let accountId: AccountId
    public let reason: ValidatorKickoutReason

    public init(
        accountId: AccountId,
        reason: ValidatorKickoutReason
    ) {
        self.accountId = accountId
        self.reason = reason
    }
}

// MARK: - ValidatorStakeViewV1

public struct ValidatorStakeViewV1: Codable {
    public let accountId: AccountId
    public let publicKey: PublicKey
    public let stake: NearToken

    public init(
        accountId: AccountId,
        publicKey: PublicKey,
        stake: NearToken
    ) {
        self.accountId = accountId
        self.publicKey = publicKey
        self.stake = stake
    }
}

// MARK: - Version

public struct Version: Codable {
    public let build: String
    public let commit: String
    public let rustcVersion: String?
    public let version: String

    public init(
        build: String,
        commit: String,
        rustcVersion: String?,
        version: String
    ) {
        self.build = build
        self.commit = commit
        self.rustcVersion = rustcVersion
        self.version = version
    }
}

// MARK: - ViewStateResult

public struct ViewStateResult: Codable {
    public let proof: [String]?
    public let values: [StateItem]

    public init(
        proof: [String]?,
        values: [StateItem]
    ) {
        self.proof = proof
        self.values = values
    }
}

// MARK: - WitnessConfigView

public struct WitnessConfigView: Codable {
    public let combinedTransactionsSizeLimit: Int
    public let mainStorageProofSizeSoftLimit: UInt64
    public let newTransactionsValidationStateSizeSoftLimit: UInt64

    public init(
        combinedTransactionsSizeLimit: Int,
        mainStorageProofSizeSoftLimit: UInt64,
        newTransactionsValidationStateSizeSoftLimit: UInt64
    ) {
        self.combinedTransactionsSizeLimit = combinedTransactionsSizeLimit
        self.mainStorageProofSizeSoftLimit = mainStorageProofSizeSoftLimit
        self.newTransactionsValidationStateSizeSoftLimit = newTransactionsValidationStateSizeSoftLimit
    }
}

// MARK: - Generated Inline Types

public struct InlineObject: Codable {
    public let accountId: AccountId

    public init(
        accountId: AccountId
    ) {
        self.accountId = accountId
    }
}
