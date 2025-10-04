# Setup Guide

This guide will help you set up your development environment for contributing to the NEAR JSON-RPC Swift Client.

## System Requirements

### Required Software

- **Swift**: 5.9 or higher

  ```bash
  # Check version
  swift --version

  # macOS: Install via Xcode
  # Download from App Store or https://developer.apple.com/xcode/

  # Linux: Install Swift toolchain
  # Visit https://swift.org/install/linux/
  ```

- **Xcode**: 15.0+ (for iOS/macOS development on macOS)

  ```bash
  # Check version
  xcodebuild -version
  ```

- **Python**: 3.8 or higher (for code generation)

  ```bash
  # Check version
  python3 --version

  # macOS
  brew install python3

  # Linux
  sudo apt-get install python3 python3-pip python3-venv
  ```

- **Git**: Latest version
  ```bash
  # Check version
  git --version
  ```

### Recommended Software

- **SwiftFormat**: For code formatting

  ```bash
  # macOS
  brew install swiftformat

  # Check version
  swiftformat --version
  ```

- **GitHub CLI**: For easier PR management

  ```bash
  # macOS
  brew install gh

  # Linux
  sudo apt install gh
  ```

## Environment Setup

### 1. Fork and Clone

```bash
# Fork the repository on GitHub first
# Then clone your fork
git clone https://github.com/YOUR_USERNAME/jsonrpc-client.git
cd jsonrpc-client

# Add upstream remote
git remote add upstream https://github.com/@near-js/jsonrpc-client.git

# Verify remotes
git remote -v
```

### 2. Setup Python Environment

```bash
# Setup Python virtual environment for code generation
cd Scripts
./setup.sh
cd ..

# This will:
# - Create Python virtual environment
# - Install required packages (jsonschema)
# - Prepare code generation tools
```

### 3. Initial Build

```bash
# Build the Swift package
swift build

# Build for release (optimized)
swift build -c release
```

### 4. Verify Setup

```bash
# Run tests to verify setup
swift test

# Expected: All tests should pass
```

## Project Setup

### Package Configuration

The `Package.swift` manifest defines:

- **Products**: `NearJsonRpcClient` and `NearJsonRpcTypes` libraries
- **Platforms**: iOS 13+ and macOS 10.15+
- **Targets**: Source modules and test suites
- **Dependencies**: Zero external dependencies

## Development Commands

### Swift Commands

```bash
# Build the package
swift build

# Build for release
swift build -c release

# Run tests
swift test

# Run tests with verbose output
swift test --verbose

# Run specific test
swift test --filter NearJsonRpcClientTests

# Clean build artifacts
swift package clean

# Generate Xcode project (optional)
swift package generate-xcodeproj

# Update package dependencies (if any added)
swift package update
```

### Code Formatting

```bash
# Format all Swift code
swiftformat Sources/ Tests/ Examples/

# Check if formatting is needed (doesn't modify files)
swiftformat --lint Sources/ Tests/ Examples/

# Format with specific rules
swiftformat --swiftversion 5.9 Sources/
```

## Code Generation Setup

### Understanding Code Generation

The project uses Python scripts to generate Swift code from NEAR's OpenAPI specification:

1. **`generate_types.py`**: Generates Swift types and RPC method wrappers
2. **`generate_mock.py`**: Generates mock JSON test data
3. **`generate_tests.py`**: Generates Swift test files

### Initial Setup

```bash
# First time setup
cd Scripts
./setup.sh

# This creates a Python virtual environment and installs dependencies
```

### Running Code Generation

```bash
# Generate all code (from Scripts directory)
cd Scripts
./codegen.sh

# Or run individual generators
python3 generate_types.py    # Generate Types.swift and Methods.swift
python3 generate_mock.py      # Generate Mock/*.json files
python3 generate_tests.py     # Generate test Swift files

# Return to root
cd ..
```

### Updating OpenAPI Specification

```bash
# Download latest specification
curl -L -o Scripts/openapi.json \
  https://raw.githubusercontent.com/near/near-jsonrpc-client-rs/master/openapi.json

# Regenerate all code
cd Scripts
./codegen.sh
cd ..

# Review generated changes
git diff Sources/
git diff Tests/

# Test the generated code
swift test
```

### Customizing Generation

To modify code generation behavior, edit the Python scripts in `Scripts/`:

- **`generate_types.py`**: Customize type mapping, enum generation, method signatures
- **`generate_mock.py`**: Customize mock data generation, add special cases
- **`generate_tests.py`**: Customize test generation, add test patterns

## Testing Setup

### Running Tests

```bash
# Run all tests
swift test

# Run with verbose output
swift test --verbose

# Run specific test target
swift test --filter NearJsonRpcClientTests
swift test --filter NearJsonRpcTypesTests

# Run specific test case
swift test --filter ClientTests.testBlockQuery

# Run tests in parallel (default)
swift test --parallel

# Run tests serially
swift test --num-workers 1
```

### Test Structure

The project has two test targets:

1. **NearJsonRpcClientTests**: Tests for the client implementation
   - Unit tests for client logic
   - Integration tests for RPC methods
   - Mock JSON for response testing

2. **NearJsonRpcTypesTests**: Tests for type decoding
   - Decoding tests for all types
   - Codable conformance verification
   - Mock JSON for type testing

## Additional Resources

- [Swift.org Documentation](https://swift.org/documentation/)
- [Swift Package Manager Documentation](https://swift.org/package-manager/)
- [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/)
- [NEAR RPC Documentation](https://docs.near.org/api/rpc/introduction)
- [OpenAPI Specification](https://github.com/near/near-jsonrpc-client-rs/blob/master/openapi.json)
- [CONTRIBUTING.md](./CONTRIBUTING.md) - Contribution guidelines
- [README.md](./README.md) - Project overview

## CI/CD Local Setup

### Running CI Checks Locally

```bash
# Run all CI checks
swift test && swiftformat --lint Sources/ Tests/ Examples/ && swift build

# Create a local CI script
cat > check-ci.sh << 'EOF'
#!/bin/bash
set -e

echo "🧪 Running tests..."
swift test

swiftformat --lint Sources/ Tests/ Examples/

echo "📦 Building package..."
swift build

echo "✅ All checks passed!"
EOF

chmod +x check-ci.sh
./check-ci.sh
```

## Troubleshooting

### Common Issues

#### 1. Swift Version Mismatch

```bash
# Error: Swift 5.9 required, but 5.8 found
# Solution: Update Swift/Xcode

# macOS: Update Xcode from App Store
# Then select the new Xcode:
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer

# Verify version
swift --version
```

#### 2. Build Failures

```bash
# Clean and rebuild
swift package clean
swift build

# Reset package cache
rm -rf .build
swift build

# For Xcode
# Product → Clean Build Folder (Shift+Cmd+K)
```

#### 3. Test Failures

```bash
# Run tests with verbose output
swift test --verbose

# Check for network issues (some tests may require network access)
# Run specific test to isolate issue
swift test --filter SpecificTestName
```

#### 4. Python Environment Issues

```bash
# Recreate Python virtual environment
cd Scripts
rm -rf venv
./setup.sh

# Verify Python packages
source venv/bin/activate
pip list
deactivate
```

#### 5. SwiftFormat Issues

```bash
# Install SwiftFormat
brew install swiftformat

# Verify installation
swiftformat --version

# Format files
swiftformat Sources/ Tests/ Examples/
```

### Getting Help

If you encounter issues not covered here:

1. Check the [main README](./README.md)
2. Search [GitHub Issues](https://github.com/space-rock/near-jsonrpc-swift/issues)
3. Check [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines
4. Create a new issue with:
   - Swift version (`swift --version`)
   - Platform (macOS/Linux, version)
   - Full error message
   - Steps to reproduce
