import Foundation
import NearJsonRpcClient
import NearJsonRpcTypes

@main
struct NearJsonRpcExample {
    static func main() async {
        await demonstrateAllMethods()
    }

    // Helper function to pretty print JSON
    static func prettyPrint(_ value: some Encodable, label: String) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        if let jsonData = try? encoder.encode(value),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print("\n\(label):")
            print(jsonString)
        } else {
            print("\n\(label): [Unable to encode]")
        }
    }

    static func demonstrateAllMethods() async {
        // Track test results
        var successCount = 0
        var failureCount = 0
        var failures: [(method: String, error: String)] = []

        do {
            // Initialize the client
            let client = try NearRpcClient(baseURLString: "https://archival-rpc.testnet.fastnear.com")

            print("🚀 NEAR JSON-RPC Client - Complete Method Examples")
            print("===================================================")
            print("All methods in OpenAPI spec order with prettified JSON output\n")

            // MARK: - 1. EXPERIMENTAL_changes

            print("\n" + String(repeating: "=", count: 80))
            print("1. EXPERIMENTAL_changes")
            print(String(repeating: "=", count: 80))
            do {
                let request = RpcStateChangesInBlockByTypeRequest.accountChangesByBlockId(
                    AccountChangesByBlockId(
                        blockId: .integer(216_862_270),
                        accountIds: ["relay.aurora"],
                        changesType: .accountChanges,
                    ),
                )
                let response = try await client.experimentalChanges(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                switch error {
                case .invalidURL(let url):
                    prettyPrint(["error": "Invalid URL: \(url)"], label: "✗ Error")
                case .httpError(let code):
                    prettyPrint(["error": "HTTP error: \(code)"], label: "✗ Error")
                case .rpcError(let rpcError):
                    prettyPrint(["error": "RPC error: \(rpcError)"], label: "✗ Error")
                case .decodingError(let decodingError):
                    prettyPrint(["error": "Decoding error: \(decodingError)"], label: "✗ Error")
                case .invalidResponse:
                    prettyPrint(["error": "Invalid response from server"], label: "✗ Error")
                }
                failureCount += 1
                failures.append((method: "EXPERIMENTAL_changes", error: error.localizedDescription))
            }

            // MARK: - 2. EXPERIMENTAL_changes_in_block

            print("\n" + String(repeating: "=", count: 80))
            print("2. EXPERIMENTAL_changes_in_block")
            print(String(repeating: "=", count: 80))
            do {
                let request = RpcStateChangesInBlockRequest.blockId(.integer(216_910_612))
                let response = try await client.experimentalChangesInBlock(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "EXPERIMENTAL_changes_in_block", error: errorMsg))
            }

            // MARK: - 3. EXPERIMENTAL_congestion_level

            print("\n" + String(repeating: "=", count: 80))
            print("3. EXPERIMENTAL_congestion_level")
            print(String(repeating: "=", count: 80))
            do {
                let request = RpcCongestionLevelRequest.blockShardId(
                    BlockShardId(blockId: .integer(216_838_942), shardId: 1),
                )
                let response = try await client.experimentalCongestionLevel(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "EXPERIMENTAL_congestion_level", error: errorMsg))
            }

            // MARK: - 4. EXPERIMENTAL_genesis_config

            print("\n" + String(repeating: "=", count: 80))
            print("4. EXPERIMENTAL_genesis_config")
            print(String(repeating: "=", count: 80))
            do {
                let request = GenesisConfigRequest()
                let response = try await client.experimentalGenesisConfig(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "EXPERIMENTAL_genesis_config", error: errorMsg))
            }

            // MARK: - 5. EXPERIMENTAL_maintenance_windows

            print("\n" + String(repeating: "=", count: 80))
            print("5. EXPERIMENTAL_maintenance_windows")
            print(String(repeating: "=", count: 80))
            do {
                // Sample data - replace with real validator account
                let request = RpcMaintenanceWindowsRequest(accountId: "node0")
                let response = try await client.experimentalMaintenanceWindows(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "EXPERIMENTAL_maintenance_windows", error: errorMsg))
            }

            // MARK: - 6. EXPERIMENTAL_receipt

            print("\n" + String(repeating: "=", count: 80))
            print("6. EXPERIMENTAL_receipt")
            print(String(repeating: "=", count: 80))
            do {
                // Sample data - replace with real receipt ID
                let request = RpcReceiptRequest(receiptId: "3zYdPjRrhAbGCnZv7aypJ7JCAn1Vj3JSQ4RKZueV73kv")
                let response = try await client.experimentalReceipt(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "EXPERIMENTAL_receipt", error: errorMsg))
            }

            // MARK: - 7. EXPERIMENTAL_split_storage_info

            print("\n" + String(repeating: "=", count: 80))
            print("7. EXPERIMENTAL_split_storage_info")
            print(String(repeating: "=", count: 80))
            do {
                let request = RpcSplitStorageInfoRequest()
                let response = try await client.experimentalSplitStorageInfo(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "EXPERIMENTAL_split_storage_info", error: errorMsg))
            }

            // MARK: - 8. EXPERIMENTAL_tx_status

            print("\n" + String(repeating: "=", count: 80))
            print("8. EXPERIMENTAL_tx_status")
            print(String(repeating: "=", count: 80))
            do {
                // Sample data - replace with real transaction hash
                let request = RpcTransactionStatusRequest.rpcTransactionStatusRequestSenderAccountIdTxHash(
                    RpcTransactionStatusRequestOneOfSenderAccountIdTxHash(
                        senderAccountId: "relay.aurora",
                        txHash: "FB5d5Ehn7Q4Bx8XwrWV19jtTDJsTvaR7YnPgCkbSKPRP",
                    ),
                )
                let response = try await client.experimentalTxStatus(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "EXPERIMENTAL_tx_status", error: errorMsg))
            }

            // MARK: - 9. EXPERIMENTAL_validators_ordered

            print("\n" + String(repeating: "=", count: 80))
            print("9. EXPERIMENTAL_validators_ordered")
            print(String(repeating: "=", count: 80))
            do {
                let request = RpcValidatorsOrderedRequest(blockId: .integer(216_910_612))
                let response = try await client.experimentalValidatorsOrdered(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "EXPERIMENTAL_validators_ordered", error: errorMsg))
            }

            // MARK: - 10. block

            print("\n" + String(repeating: "=", count: 80))
            print("10. block")
            print(String(repeating: "=", count: 80))
            do {
                let request = RpcBlockRequest.finality(.final)
                let response = try await client.block(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "block", error: errorMsg))
            }

            // MARK: - 11. changes

            print("\n" + String(repeating: "=", count: 80))
            print("11. changes")
            print(String(repeating: "=", count: 80))
            do {
                let request = RpcStateChangesInBlockByTypeRequest.accountChangesByBlockId(
                    AccountChangesByBlockId(
                        blockId: .integer(216_910_612),
                        accountIds: ["aurora.pool.f863973.m0"],
                        changesType: .accountChanges,
                    ),
                )
                let response = try await client.changes(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "changes", error: errorMsg))
            }

            // MARK: - 12. chunk

            print("\n" + String(repeating: "=", count: 80))
            print("12. chunk")
            print(String(repeating: "=", count: 80))
            do {
                // Get a chunk hash from the latest block
                let blockRequest = RpcBlockRequest.finality(.final)
                let block = try await client.block(blockRequest)

                if let chunkHash = block.chunks.first?.chunkHash {
                    let request = RpcChunkRequest.chunkId(chunkHash)
                    let response = try await client.chunk(request)
                    prettyPrint(response, label: "✓ Response")
                    successCount += 1
                } else {
                    print("✗ No chunks available in latest block")
                    failureCount += 1
                    failures.append((method: "chunk", error: "No chunks available"))
                }
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "chunk", error: errorMsg))
            }

            // MARK: - 13. gas_price

            print("\n" + String(repeating: "=", count: 80))
            print("13. gas_price")
            print(String(repeating: "=", count: 80))
            do {
                let request = RpcGasPriceRequest(blockId: nil)
                let response = try await client.gasPrice(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "gas_price", error: errorMsg))
            }

            // MARK: - 14. health

            print("\n" + String(repeating: "=", count: 80))
            print("14. health")
            print(String(repeating: "=", count: 80))
            do {
                let request = RpcHealthRequest()
                let response = try await client.health(request)
                if let healthResponse = response {
                    prettyPrint(healthResponse, label: "✓ Response")
                } else {
                    print("✓ Response: Node is healthy (null response)")
                }
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "health", error: errorMsg))
            }

            // MARK: - 15. network_info

            print("\n" + String(repeating: "=", count: 80))
            print("15. network_info")
            print(String(repeating: "=", count: 80))
            do {
                let request = RpcNetworkInfoRequest()
                let response = try await client.networkInfo(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "network_info", error: errorMsg))
            }

            // MARK: - 16. next_light_client_block

            print("\n" + String(repeating: "=", count: 80))
            print("16. next_light_client_block")
            print(String(repeating: "=", count: 80))
            do {
                let blockRequest = RpcBlockRequest.finality(.final)
                let block = try await client.block(blockRequest)

                let request = RpcLightClientNextBlockRequest(lastBlockHash: block.header.hash)
                let response = try await client.nextLightClientBlock(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "next_light_client_block", error: errorMsg))
            }

            // MARK: - 17. query

            print("\n" + String(repeating: "=", count: 80))
            print("17. view_account")
            print(String(repeating: "=", count: 80))
            do {
                let request = RpcQueryRequest.viewAccountByFinality(
                    ViewAccountByFinality(
                        finality: .final,
                        accountId: "guestbook.near-examples.testnet",
                        requestType: .viewAccount,
                    ),
                )
                let response = try await client.query(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "query", error: errorMsg))
            }

            print("\n" + String(repeating: "=", count: 80))
            print("17. view_code")
            print(String(repeating: "=", count: 80))
            do {
                let request = RpcQueryRequest.viewCodeByBlockId(
                    ViewCodeByBlockId(
                        blockId: .integer(217_371_061),
                        accountId: "guestbook.near-examples.testnet",
                        requestType: .viewCode,
                    ),
                )
                let response = try await client.query(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "query", error: errorMsg))
            }

            print("\n" + String(repeating: "=", count: 80))
            print("17. call_function")
            print(String(repeating: "=", count: 80))
            do {
                let args = ["account_id": "zavodil2.testnet"]
                let jsonData = try JSONEncoder().encode(args)
                let argsBase64 = jsonData.base64EncodedString()

                let request = RpcQueryRequest.callFunctionBySyncCheckpoint(
                    CallFunctionBySyncCheckpoint(
                        syncCheckpoint: .earliestAvailable,
                        accountId: "usdn.testnet",
                        argsBase64: argsBase64,
                        methodName: "ft_balance_of",
                        requestType: .callFunction,
                    ),
                )
                let response = try await client.query(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "query", error: errorMsg))
            }

            // MARK: - 18. status

            print("\n" + String(repeating: "=", count: 80))
            print("18. status")
            print(String(repeating: "=", count: 80))
            do {
                let request = RpcStatusRequest()
                let response = try await client.status(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "status", error: errorMsg))
            }

            // MARK: - 19. tx

            print("\n" + String(repeating: "=", count: 80))
            print("19. tx")
            print(String(repeating: "=", count: 80))
            do {
                // Sample data - replace with real transaction hash
                let request = RpcTransactionStatusRequest.rpcTransactionStatusRequestSenderAccountIdTxHash(
                    RpcTransactionStatusRequestOneOfSenderAccountIdTxHash(
                        senderAccountId: "relay.aurora",
                        txHash: "FB5d5Ehn7Q4Bx8XwrWV19jtTDJsTvaR7YnPgCkbSKPRP",
                    ),
                )
                let response = try await client.tx(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "tx", error: errorMsg))
            }

            // MARK: - 20. validators

            print("\n" + String(repeating: "=", count: 80))
            print("20. validators")
            print(String(repeating: "=", count: 80))
            do {
                let request = RpcValidatorRequest.latest
                let response = try await client.validators(request)
                prettyPrint(response, label: "✓ Response")
                successCount += 1
            } catch {
                let errorMsg = error.localizedDescription
                prettyPrint(["error": errorMsg], label: "✗ Error")
                failureCount += 1
                failures.append((method: "validators", error: errorMsg))
            }

            // MARK: - Summary

            print("\n" + String(repeating: "=", count: 80))
            print("📊 TEST SUMMARY")
            print(String(repeating: "=", count: 80))
            print("\n✅ Successful: \(successCount)")
            print("❌ Failed: \(failureCount)")
            print("📈 Total: \(successCount + failureCount)")

            if !failures.isEmpty {
                print("\n" + String(repeating: "-", count: 80))
                print("Failed Methods:")
                print(String(repeating: "-", count: 80))
                for (index, failure) in failures.enumerated() {
                    print("\n\(index + 1). \(failure.method)")
                    print("   Error: \(failure.error)")
                }
            }

            print("\n" + String(repeating: "=", count: 80))
        } catch {
            print("\n❌ Fatal Error during client initialization")
            switch error {
            case .invalidURL(let url):
                prettyPrint(["error": "Invalid URL: \(url)"], label: "Error Details")
            case .httpError(let code):
                prettyPrint(["error": "HTTP error: \(code)"], label: "Error Details")
            case .rpcError(let rpcError):
                prettyPrint(["rpcError": "\(rpcError)"], label: "Error Details")
            case .decodingError(let decodingError):
                prettyPrint(["error": "Decoding error: \(decodingError)"], label: "Error Details")
            case .invalidResponse:
                prettyPrint(["error": "Invalid response from server"], label: "Error Details")
            }
        }
    }
}
