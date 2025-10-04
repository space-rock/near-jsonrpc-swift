# NEAR JSON-RPC Swift Client

[![Swift 5.9+](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/platforms-iOS%2013+%20%7C%20macOS%2010.15+-lightgrey.svg)](https://developer.apple.com)
[![SPM Compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)

## 🚀 Features

- **🎯 Type-Safe Design**: Swift types generated directly from OpenAPI specification
- **⚡ Native Swift Performance**: Built with modern Swift concurrency (async/await)
- **🎬 Actor-Based Client**: Thread-safe actor model for concurrent request handling
- **🛡️ Comprehensive Type System**: Codable types for all RPC requests and responses
- **🔀 Discriminated Union Types**: Helper enums for complex requests like `query` and `changes`
- **📦 Zero Dependencies**: Pure Swift implementation with no external dependencies
- **🧪 Extensive Test Coverage**: Comprehensive test suites with mock data
- **🔄 Auto-Generated Code**: Types, methods, and tests generated from NEAR's OpenAPI spec
- **📱 Multi-Platform**: Support for iOS 13+ and macOS 10.15+
- **🎭 Mock Data Generation**: Python-based mock JSON generation for testing

## Overview

A type-safe, high-performance Swift Package Manager library for interacting with NEAR Protocol JSON-RPC API. Built with Swift concurrency features and automatically generated from the official OpenAPI specification.

## Modules

| Module                  | Description                                     |
| ----------------------- | ----------------------------------------------- |
| `NearJsonRpcClient`     | JSON-RPC client with all RPC method wrappers    |
| `NearJsonRpcTypes`      | Swift Codable types for requests and responses  |

## Quick Start

### Swift Package Manager

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/space-rock/near-jsonrpc-swift.git", from: "1.0.0")
]
```

Or in Xcode:
1. File → Add Package Dependencies
2. Enter: `https://github.com/space-rock/near-jsonrpc-swift.git`

### Basic Usage

```swift
import NearJsonRpcClient
import NearJsonRpcTypes

// Initialize client
let client = try NearRpcClient(baseURLString: "https://rpc.testnet.near.org")

// Query block information
let blockRequest = RpcBlockRequest.finality(.final)
let blockResponse = try await client.block(blockRequest)
print("Block hash: \(blockResponse.header.hash)")

// Query account details
let queryRequest = RpcQueryRequest.viewAccountByFinality(
    ViewAccountByFinality(
        finality: .final,
        accountId: "example.testnet",
        requestType: .viewAccount
    )
)
let queryResponse = try await client.query(queryRequest)

// Check node health
let healthRequest = RpcHealthRequest()
let healthResponse = try await client.health(healthRequest)
```

## Installation

### Prerequisites

- Swift 5.9 or later
- Xcode 15.0+ (for iOS/macOS development)
- Python 3.8+ (for code generation)

### Development Setup

```bash
# Clone the repository
git clone https://github.com/space-rock/near-jsonrpc-swift.git
cd near-jsonrpc-swift

# Setup Python environment for code generation
cd Scripts
./setup.sh
cd ..

# Build the package
swift build

# Run tests
swift test
```

## Code Generation

The project uses Python scripts to generate Swift code from NEAR's OpenAPI specification:

### Generation Pipeline

1. **Types & Methods** (`Scripts/generate_types.py`)
   - Generates `Sources/NearJsonRpcTypes/Types.swift` with all Codable types
   - Generates `Sources/NearJsonRpcClient/Methods.swift` with RPC method wrappers
   - Parses OpenAPI spec and creates Swift enums, structs, and protocols

2. **Mock Data** (`Scripts/generate_mock.py`)
   - Generates JSON mock files in `Tests/*/Mock/` directories
   - Creates valid test data for all type structures

3. **Test Suites** (`Scripts/generate_tests.py`)
   - Generates comprehensive unit tests
   - Creates decoding tests for all types
   - Ensures type safety across the entire API surface

### Running Code Generation

```bash
# Generate all code (types, mocks, and tests)
cd Scripts
./codegen.sh

# Or run individual generators
python3 generate_types.py    # Generate Swift types and methods
python3 generate_mock.py      # Generate mock JSON data
python3 generate_tests.py     # Generate test files
```

### Updating OpenAPI Specification

```bash
# Download the latest OpenAPI spec
curl -L -o Scripts/openapi.json https://raw.githubusercontent.com/near/near-jsonrpc-client-rs/master/openapi.json

# Regenerate all code
cd Scripts
./codegen.sh
```

## Testing

### Running Tests

```bash
# Run all tests
swift test

# Run with verbose output
swift test --verbose

# Run specific test suite
swift test --filter NearJsonRpcClientTests
swift test --filter NearJsonRpcTypesTests
```

### Test Structure

- **Unit Tests**: Test individual components and methods
- **Integration Tests**: Test actual RPC calls (when enabled)
- **Decoding Tests**: Verify all types decode correctly from mock JSON
- **Mock Data**: Comprehensive JSON fixtures for all response types

## Examples

See [`Examples/Sources/Example.swift`](./Examples/Sources/Example.swift) for a comprehensive demonstration of all RPC methods.

```bash
# Run the example
cd Examples
swift run
```

## Error Handling

The client provides structured error handling:

```swift
do {
    let response = try await client.block(request)
    // Handle success
} catch NearJsonRpcError.invalidURL(let url) {
    print("Invalid URL: \(url)")
} catch NearJsonRpcError.httpError(let code) {
    print("HTTP error: \(code)")
} catch NearJsonRpcError.rpcError(let error) {
    print("RPC error: \(error.message)")
} catch NearJsonRpcError.decodingError(let error) {
    print("Decoding failed: \(error)")
} catch {
    print("Unknown error: \(error)")
}
```

## Architecture

### Design Principles

1. **Type-Safe Swift**
   - Generated from OpenAPI spec
   - Comprehensive Codable conformance
   - Swift enums for variants

2. **Modern Concurrency**
   - Actor-based client for thread safety
   - Async/await for all network calls
   - Structured concurrency support

3. **Zero Dependencies**
   - Built on Foundation and URLSession
   - No external dependencies
   - Minimal runtime overhead

4. **Generated Code**
   - Types auto-generated from spec
   - Methods auto-generated with proper signatures
   - Tests auto-generated for coverage

## Documentation

For more detailed information, check out:

- **[CONTRIBUTING.md](./CONTRIBUTING.md)** - Guidelines for contributing to the project
- **[SETUP.md](./SETUP.md)** - Complete development environment setup guide
- **[DEPLOYMENT.md](./DEPLOYMENT.md)** - Release and deployment procedures

## Contributing

Contributions are welcome! Please read our [Contributing Guide](./CONTRIBUTING.md) for details on our development process, coding standards, and how to submit pull requests.

**Quick checklist before submitting a PR:**

1. All tests pass (`swift test`)
2. Code is formatted with `swiftformat`
3. New features include tests
4. Generated code is updated if needed

```bash
# Before submitting a PR
swift test                              # Run all tests
swiftformat Sources/ Tests/ Examples/  # Format code
cd Scripts && ./codegen.sh             # Regenerate if needed
```

See [CONTRIBUTING.md](./CONTRIBUTING.md) for complete contribution guidelines.

## License

MIT License - see [LICENSE](./LICENSE) for details.

## Links

- [NEAR Protocol](https://near.org)
- [NEAR RPC Documentation](https://docs.near.org/api/rpc/introduction)
- [OpenAPI Specification](https://github.com/near/near-jsonrpc-client-rs/blob/master/openapi.json)
- [Swift Package Manager](https://swift.org/package-manager/)

---

Built with ❤️ for the NEAR Swift community
