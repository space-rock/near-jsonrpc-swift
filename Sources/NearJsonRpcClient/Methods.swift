
import Foundation
import NearJsonRpcTypes

// MARK: - Auto-generated RPC Methods

public extension NearJsonRpcClient {
    /// [Deprecated] Returns changes for a given account, contract or contract code for given block height or hash.
    /// Consider using changes instead.
    func experimentalChanges(_ request: RpcStateChangesInBlockByTypeRequest) async throws(NearJsonRpcError)
        -> RpcStateChangesInBlockResponse {
        let response: JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError =
            try await performRequest(
                method: "EXPERIMENTAL_changes",
                params: request,
                responseType: JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError.self,
            )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcStateChangesError(error))
        }
    }

    /// [Deprecated] Returns changes in block for given block height or hash over all transactions for all the types.
    /// Includes changes like account_touched, access_key_touched, data_touched, contract_code_touched. Consider using
    /// block_effects instead
    func experimentalChangesInBlock(_ request: RpcStateChangesInBlockRequest) async throws(NearJsonRpcError)
        -> RpcStateChangesInBlockByTypeResponse {
        let response: JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError =
            try await performRequest(
                method: "EXPERIMENTAL_changes_in_block",
                params: request,
                responseType: JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError.self,
            )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcStateChangesError(error))
        }
    }

    /// Queries the congestion level of a shard. More info about congestion [here](https://near.github.io/nearcore/architecture/how/receipt-congestion.html?highlight=congestion#receipt-congestion)
    func experimentalCongestionLevel(_ request: RpcCongestionLevelRequest) async throws(NearJsonRpcError)
        -> RpcCongestionLevelResponse {
        let response: JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError = try await performRequest(
            method: "EXPERIMENTAL_congestion_level",
            params: request,
            responseType: JsonRpcResponseForRpcCongestionLevelResponseAndRpcChunkError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcChunkError(error))
        }
    }

    /// [Deprecated] Get initial state and parameters for the genesis block. Consider genesis_config instead.
    func experimentalGenesisConfig(_ request: GenesisConfigRequest) async throws(NearJsonRpcError) -> GenesisConfig {
        let response: JsonRpcResponseForGenesisConfigAndGenesisConfigError = try await performRequest(
            method: "EXPERIMENTAL_genesis_config",
            params: request,
            responseType: JsonRpcResponseForGenesisConfigAndGenesisConfigError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForGenesisConfigError(error))
        }
    }

    /// Returns the proofs for a transaction execution.
    func experimentalLightClientBlockProof(_ request: RpcLightClientBlockProofRequest) async throws(NearJsonRpcError)
        -> RpcLightClientBlockProofResponse {
        let response: JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError =
            try await performRequest(
                method: "EXPERIMENTAL_light_client_block_proof",
                params: request,
                responseType: JsonRpcResponseForRpcLightClientBlockProofResponseAndRpcLightClientProofError.self,
            )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcLightClientProofError(error))
        }
    }

    /// Returns the proofs for a transaction execution.
    func experimentalLightClientProof(_ request: RpcLightClientExecutionProofRequest) async throws(NearJsonRpcError)
        -> RpcLightClientExecutionProofResponse {
        let response: JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError =
            try await performRequest(
                method: "EXPERIMENTAL_light_client_proof",
                params: request,
                responseType: JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError.self,
            )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcLightClientProofError(error))
        }
    }

    /// [Deprecated] Returns the future windows for maintenance in current epoch for the specified account. In the
    /// maintenance windows, the node will not be block producer or chunk producer. Consider using maintenance_windows
    /// instead.
    func experimentalMaintenanceWindows(_ request: RpcMaintenanceWindowsRequest) async throws(NearJsonRpcError)
        -> [RangeOfUint64] {
        let response: JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError = try await performRequest(
            method: "EXPERIMENTAL_maintenance_windows",
            params: request,
            responseType: JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcMaintenanceWindowsError(error))
        }
    }

    /// A configuration that defines the protocol-level parameters such as gas/storage costs, limits, feature flags,
    /// other settings
    func experimentalProtocolConfig(_ request: RpcProtocolConfigRequest) async throws(NearJsonRpcError)
        -> RpcProtocolConfigResponse {
        let response: JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError = try await performRequest(
            method: "EXPERIMENTAL_protocol_config",
            params: request,
            responseType: JsonRpcResponseForRpcProtocolConfigResponseAndRpcProtocolConfigError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcProtocolConfigError(error))
        }
    }

    /// Fetches a receipt by its ID (as is, without a status or execution outcome)
    func experimentalReceipt(_ request: RpcReceiptRequest) async throws(NearJsonRpcError) -> RpcReceiptResponse {
        let response: JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError = try await performRequest(
            method: "EXPERIMENTAL_receipt",
            params: request,
            responseType: JsonRpcResponseForRpcReceiptResponseAndRpcReceiptError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcReceiptError(error))
        }
    }

    /// Contains the split storage information. More info on split storage
    /// [here](https://near-nodes.io/archival/split-storage-archival)
    func experimentalSplitStorageInfo(_ request: RpcSplitStorageInfoRequest) async throws(NearJsonRpcError)
        -> RpcSplitStorageInfoResponse {
        let response: JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError =
            try await performRequest(
                method: "EXPERIMENTAL_split_storage_info",
                params: request,
                responseType: JsonRpcResponseForRpcSplitStorageInfoResponseAndRpcSplitStorageInfoError.self,
            )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcSplitStorageInfoError(error))
        }
    }

    /// Queries status of a transaction by hash, returning the final transaction result and details of all receipts.
    func experimentalTxStatus(_ request: RpcTransactionStatusRequest) async throws(NearJsonRpcError)
        -> RpcTransactionResponse {
        let response: JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError = try await performRequest(
            method: "EXPERIMENTAL_tx_status",
            params: request,
            responseType: JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcTransactionError(error))
        }
    }

    /// Returns the current epoch validators ordered in the block producer order with repetition. This endpoint is
    /// solely used for bridge currently and is not intended for other external use cases.
    func experimentalValidatorsOrdered(_ request: RpcValidatorsOrderedRequest) async throws(NearJsonRpcError)
        -> [ValidatorStakeView] {
        let response: JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError = try await performRequest(
            method: "EXPERIMENTAL_validators_ordered",
            params: request,
            responseType: JsonRpcResponseForArrayOfValidatorStakeViewAndRpcValidatorError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcValidatorError(error))
        }
    }

    /// Returns block details for given height or hash
    func block(_ request: RpcBlockRequest) async throws(NearJsonRpcError) -> RpcBlockResponse {
        let response: JsonRpcResponseForRpcBlockResponseAndRpcBlockError = try await performRequest(
            method: "block",
            params: request,
            responseType: JsonRpcResponseForRpcBlockResponseAndRpcBlockError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcBlockError(error))
        }
    }

    /// Returns changes in block for given block height or hash over all transactions for all the types. Includes
    /// changes like account_touched, access_key_touched, data_touched, contract_code_touched.
    func blockEffects(_ request: RpcStateChangesInBlockRequest) async throws(NearJsonRpcError)
        -> RpcStateChangesInBlockByTypeResponse {
        let response: JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError =
            try await performRequest(
                method: "block_effects",
                params: request,
                responseType: JsonRpcResponseForRpcStateChangesInBlockByTypeResponseAndRpcStateChangesError.self,
            )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcStateChangesError(error))
        }
    }

    /// [Deprecated] Sends a transaction and immediately returns transaction hash. Consider using send_tx instead.
    func broadcastTxAsync(_ request: RpcSendTransactionRequest) async throws(NearJsonRpcError) -> CryptoHash {
        let response: JsonRpcResponseForCryptoHashAndRpcTransactionError = try await performRequest(
            method: "broadcast_tx_async",
            params: request,
            responseType: JsonRpcResponseForCryptoHashAndRpcTransactionError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcTransactionError(error))
        }
    }

    /// [Deprecated] Sends a transaction and waits until transaction is fully complete. (Has a 10 second timeout).
    /// Consider using send_tx instead.
    func broadcastTxCommit(_ request: RpcSendTransactionRequest) async throws(NearJsonRpcError)
        -> RpcTransactionResponse {
        let response: JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError = try await performRequest(
            method: "broadcast_tx_commit",
            params: request,
            responseType: JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcTransactionError(error))
        }
    }

    /// Returns changes for a given account, contract or contract code for given block height or hash.
    func changes(_ request: RpcStateChangesInBlockByTypeRequest) async throws(NearJsonRpcError)
        -> RpcStateChangesInBlockResponse {
        let response: JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError =
            try await performRequest(
                method: "changes",
                params: request,
                responseType: JsonRpcResponseForRpcStateChangesInBlockResponseAndRpcStateChangesError.self,
            )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcStateChangesError(error))
        }
    }

    /// Returns details of a specific chunk. You can run a block details query to get a valid chunk hash.
    func chunk(_ request: RpcChunkRequest) async throws(NearJsonRpcError) -> RpcChunkResponse {
        let response: JsonRpcResponseForRpcChunkResponseAndRpcChunkError = try await performRequest(
            method: "chunk",
            params: request,
            responseType: JsonRpcResponseForRpcChunkResponseAndRpcChunkError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcChunkError(error))
        }
    }

    /// Queries client node configuration
    func clientConfig(_ request: RpcClientConfigRequest) async throws(NearJsonRpcError) -> RpcClientConfigResponse {
        let response: JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError = try await performRequest(
            method: "client_config",
            params: request,
            responseType: JsonRpcResponseForRpcClientConfigResponseAndRpcClientConfigError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcClientConfigError(error))
        }
    }

    /// Returns gas price for a specific block_height or block_hash. Using [null] will return the most recent block's
    /// gas price.
    func gasPrice(_ request: RpcGasPriceRequest) async throws(NearJsonRpcError) -> RpcGasPriceResponse {
        let response: JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError = try await performRequest(
            method: "gas_price",
            params: request,
            responseType: JsonRpcResponseForRpcGasPriceResponseAndRpcGasPriceError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcGasPriceError(error))
        }
    }

    /// Get initial state and parameters for the genesis block
    func genesisConfig(_ request: GenesisConfigRequest) async throws(NearJsonRpcError) -> GenesisConfig {
        let response: JsonRpcResponseForGenesisConfigAndGenesisConfigError = try await performRequest(
            method: "genesis_config",
            params: request,
            responseType: JsonRpcResponseForGenesisConfigAndGenesisConfigError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForGenesisConfigError(error))
        }
    }

    /// Returns the current health status of the RPC node the client connects to.
    func health(_ request: RpcHealthRequest) async throws(NearJsonRpcError) -> RpcHealthResponse? {
        let response: JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError = try await performRequest(
            method: "health",
            params: request,
            responseType: JsonRpcResponseForNullableRpcHealthResponseAndRpcStatusError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcStatusError(error))
        }
    }

    /// Returns the proofs for a transaction execution.
    func lightClientProof(_ request: RpcLightClientExecutionProofRequest) async throws(NearJsonRpcError)
        -> RpcLightClientExecutionProofResponse {
        let response: JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError =
            try await performRequest(
                method: "light_client_proof",
                params: request,
                responseType: JsonRpcResponseForRpcLightClientExecutionProofResponseAndRpcLightClientProofError.self,
            )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcLightClientProofError(error))
        }
    }

    /// Returns the future windows for maintenance in current epoch for the specified account. In the maintenance
    /// windows, the node will not be block producer or chunk producer.
    func maintenanceWindows(_ request: RpcMaintenanceWindowsRequest) async throws(NearJsonRpcError) -> [RangeOfUint64] {
        let response: JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError = try await performRequest(
            method: "maintenance_windows",
            params: request,
            responseType: JsonRpcResponseForArrayOfRangeOfUint64AndRpcMaintenanceWindowsError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcMaintenanceWindowsError(error))
        }
    }

    /// Queries the current state of node network connections. This includes information about active peers, transmitted
    /// data, known producers, etc.
    func networkInfo(_ request: RpcNetworkInfoRequest) async throws(NearJsonRpcError) -> RpcNetworkInfoResponse {
        let response: JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError = try await performRequest(
            method: "network_info",
            params: request,
            responseType: JsonRpcResponseForRpcNetworkInfoResponseAndRpcNetworkInfoError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcNetworkInfoError(error))
        }
    }

    /// Returns the next light client block.
    func nextLightClientBlock(_ request: RpcLightClientNextBlockRequest) async throws(NearJsonRpcError)
        -> RpcLightClientNextBlockResponse {
        let response: JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError =
            try await performRequest(
                method: "next_light_client_block",
                params: request,
                responseType: JsonRpcResponseForRpcLightClientNextBlockResponseAndRpcLightClientNextBlockError.self,
            )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcLightClientNextBlockError(error))
        }
    }

    /// This module allows you to make generic requests to the network.
    /// The `RpcQueryRequest` struct takes in a
    /// [`BlockReference`](https://docs.rs/near-primitives/0.12.0/near_primitives/types/enum.BlockReference.html) and a
    /// [`QueryRequest`](https://docs.rs/near-primitives/0.12.0/near_primitives/views/enum.QueryRequest.html).
    /// The `BlockReference` enum allows you to specify a block by `Finality`, `BlockId` or `SyncCheckpoint`.
    /// The `QueryRequest` enum provides multiple variants for performing the following actions:
    /// - View an account's details
    /// - View a contract's code
    /// - View the state of an account
    /// - View the `AccessKey` of an account
    /// - View the `AccessKeyList` of an account
    /// - Call a function in a contract deployed on the network.
    func query(_ request: RpcQueryRequest) async throws(NearJsonRpcError) -> RpcQueryResponse {
        let response: JsonRpcResponseForRpcQueryResponseAndRpcQueryError = try await performRequest(
            method: "query",
            params: request,
            responseType: JsonRpcResponseForRpcQueryResponseAndRpcQueryError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcQueryError(error))
        }
    }

    /// Sends transaction. Returns the guaranteed execution status and the results the blockchain can provide at the
    /// moment.
    func sendTx(_ request: RpcSendTransactionRequest) async throws(NearJsonRpcError) -> RpcTransactionResponse {
        let response: JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError = try await performRequest(
            method: "send_tx",
            params: request,
            responseType: JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcTransactionError(error))
        }
    }

    /// Requests the status of the connected RPC node. This includes information about sync status, nearcore node
    /// version, protocol version, the current set of validators, etc.
    func status(_ request: RpcStatusRequest) async throws(NearJsonRpcError) -> RpcStatusResponse {
        let response: JsonRpcResponseForRpcStatusResponseAndRpcStatusError = try await performRequest(
            method: "status",
            params: request,
            responseType: JsonRpcResponseForRpcStatusResponseAndRpcStatusError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcStatusError(error))
        }
    }

    /// Queries status of a transaction by hash and returns the final transaction result.
    func tx(_ request: RpcTransactionStatusRequest) async throws(NearJsonRpcError) -> RpcTransactionResponse {
        let response: JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError = try await performRequest(
            method: "tx",
            params: request,
            responseType: JsonRpcResponseForRpcTransactionResponseAndRpcTransactionError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcTransactionError(error))
        }
    }

    /// Queries active validators on the network. Returns details and the state of validation on the blockchain.
    func validators(_ request: RpcValidatorRequest) async throws(NearJsonRpcError) -> RpcValidatorResponse {
        let response: JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError = try await performRequest(
            method: "validators",
            params: request,
            responseType: JsonRpcResponseForRpcValidatorResponseAndRpcValidatorError.self,
        )

        switch response {
        case let .result(result):
            return result
        case let .error(error):
            throw NearJsonRpcError.rpcError(.errorwrapperForRpcValidatorError(error))
        }
    }
}
