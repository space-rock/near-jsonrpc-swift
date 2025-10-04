# Contributing to NEAR JSON-RPC Swift Client

Thank you for your interest in contributing to the NEAR JSON-RPC Swift Client! This document provides guidelines and instructions for contributing to the project.

## Getting Started

### Prerequisites

- Swift 6.1 or later
- Xcode 15.0+ (for iOS/macOS development)
- Python 3.8+ (for code generation)
- Git
- A GitHub account

### Setting Up Your Development Environment

1. **Fork the Repository**

   ```bash
   # Visit https://github.com/space-rock/near-jsonrpc-swift
   # Click the "Fork" button
   ```

2. **Clone Your Fork**

   ```bash
   git clone https://github.com/YOUR_USERNAME/near-jsonrpc-swift.git
   cd near-jsonrpc-swift
   ```

3. **Add Upstream Remote**

   ```bash
   git remote add upstream https://github.com/space-rock/near-jsonrpc-swift.git
   ```

4. **Setup Python Environment** (for code generation)

   ```bash
   cd Scripts
   ./setup.sh
   cd ..
   ```

5. **Build the Project**

   ```bash
   swift build
   ```

6. **Run Tests**
   ```bash
   swift test
   ```

## Code Generation

This project uses Python scripts to generate Swift code from the NEAR OpenAPI specification.

### When to Regenerate Code

Regenerate code when:
- Updating the OpenAPI specification
- Modifying generation scripts
- Adding support for new RPC methods

### How to Regenerate

```bash
# Setup Python environment (first time only)
cd Scripts
./setup.sh

# Run full code generation
./codegen.sh

# Or run individual generators
python3 generate_types.py    # Generate Swift types and methods
python3 generate_mock.py      # Generate mock JSON data
python3 generate_tests.py     # Generate test files
```

### Updating OpenAPI Spec

```bash
# Download latest specification
curl -L -o Scripts/openapi.json https://raw.githubusercontent.com/near/near-jsonrpc-client-rs/master/openapi.json

# Regenerate all code
cd Scripts
./codegen.sh
cd ..

# Review changes
git diff
```

## Development Workflow

### 1. Start with an Issue

- Check existing issues or create a new one
- Discuss your proposed changes
- Wait for maintainer approval before starting major work

### 2. Create a Feature Branch

```bash
# Update your local main branch
git checkout main
git pull upstream main

# Create a new feature branch
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

### 3. Make Your Changes

Follow these guidelines:

- Write clean, readable code
- Follow existing code style
- Add/update tests as needed
- Update documentation
- Keep commits focused and atomic

### 4. Run Quality Checks

Before committing:

```bash
# Format code
swiftformat Sources/ Tests/ Examples/

# Run tests
swift test

# Run tests with verbose output
swift test --verbose

# Build package
swift build
```

### 5. Commit Your Changes

Follow [Conventional Commits](#commit-conventions) format.

### 6. Push and Create PR

```bash
git push origin feature/your-feature-name
```

Then create a Pull Request on GitHub.

## Commit Conventions

We use [Conventional Commits](https://www.conventionalcommits.org/) for clear and automated release management.

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring without feature changes
- `perf`: Performance improvements
- `test`: Adding or updating tests
- `build`: Build system or dependency changes
- `ci`: CI/CD configuration changes
- `chore`: Other changes that don't modify src or test files

### Scopes

- `client`: Changes to NearJsonRpcClient
- `types`: Changes to NearJsonRpcTypes
- `codegen`: Changes to code generation scripts
- `tests`: Test-related changes
- `examples`: Example code changes

### Examples

```bash
# Feature
feat(client): add request timeout configuration

# Bug fix
fix(types): correct Codable conformance for AccountView

# Documentation
docs(client): add usage examples for query method

# Code generation
chore(codegen): update OpenAPI specification to latest

# Breaking change (note the !)
feat(client)!: change actor isolation strategy

BREAKING CHANGE: NearJsonRpcClient is now a global actor
```

## Pull Request Process

### Before Submitting

1. **Ensure all tests pass**

   ```bash
   swift test
   ```

2. **Format code**

   ```bash
   swiftformat Sources/ Tests/ Examples/
   ```

3. **Build package**

   ```bash
   swift build
   ```

4. **Update documentation**
   - Update relevant READMEs
   - Add documentation comments for public APIs
   - Update examples if needed

### PR Title Format

Use the same format as commit messages:

- `feat(client): add retry configuration`
- `fix(types): correct validation schema`
- `docs: improve contribution guidelines`

### PR Description Template

```markdown
## Description

Brief description of changes

## Type of Change

- [ ] Bug fix (non-breaking change)
- [ ] New feature (non-breaking change)
- [ ] Breaking change
- [ ] Documentation update

## Testing

- [ ] All tests pass
- [ ] Added new tests
- [ ] Coverage maintained/improved

## Checklist

- [ ] Follows code style
- [ ] Self-reviewed code
- [ ] Updated documentation
- [ ] No debug print statements
- [ ] Follows conventional commit format
```

### Review Process

1. **Automated CI/CD checks must pass**:
   - macOS and Linux builds
   - All tests pass
   - Code generation succeeds
   - Package validation passes
2. At least one maintainer review required
3. Address review feedback
4. Maintainer merges when approved
5. Release Please will automatically create release PR if needed

## Testing Requirements

### Test Coverage

- Maintain high test coverage
- All new code must include tests
- Tests should cover:
  - Happy path
  - Error cases
  - Edge cases
  - Type safety and Codable conformance

### Test Structure

```swift
import XCTest
@testable import NearJsonRpcClient
@testable import NearJsonRpcTypes

final class ClientTests: XCTestCase {
    var client: NearJsonRpcClient!
    
    override func setUp() async throws {
        client = try NearJsonRpcClient(baseURLString: "https://rpc.testnet.near.org")
    }
    
    func testBlockQuery() async throws {
        // Arrange
        let request = RpcBlockRequest.finality(.final)
        
        // Act
        let response = try await client.block(request)
        
        // Assert
        XCTAssertFalse(response.header.hash.isEmpty)
        XCTAssertGreaterThan(response.header.height, 0)
    }
    
    func testInvalidURL() {
        // Assert
        XCTAssertThrowsError(try NearJsonRpcClient(baseURLString: "invalid-url")) { error in
            guard case NearJsonRpcError.invalidURL = error else {
                XCTFail("Expected invalidURL error")
                return
            }
        }
    }
}
```

### Mock Data Testing

```swift
// Decoding tests use mock JSON files
func testAccountViewDecoding() throws {
    let jsonData = try loadMockData("AccountView.json")
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    let accountView = try decoder.decode(AccountView.self, from: jsonData)
    XCTAssertNotNil(accountView.amount)
}
```

## Code Style

### Swift Style Guidelines

- Follow [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/)
- Use 4 spaces for indentation
- Maximum line length: 120 characters
- Use meaningful variable and function names

### Formatting

We use [SwiftFormat](https://github.com/nicklockwood/SwiftFormat) for code formatting:

```bash
# Install SwiftFormat
brew install swiftformat

# Format all code
swiftformat Sources/ Tests/ Examples/

# Check if formatting is needed
swiftformat --lint Sources/ Tests/ Examples/
```

### Naming Conventions

- **Types**: PascalCase (e.g., `RpcBlockRequest`, `AccountView`)
- **Functions/Methods**: camelCase (e.g., `performRequest`, `block`)
- **Variables**: camelCase (e.g., `blockHeight`, `accountId`)
- **Constants**: camelCase (e.g., `maxRetries`, `defaultTimeout`)
- **Actor**: PascalCase (e.g., `NearJsonRpcClient`)

## Community

### Getting Help

- 📖 Read the documentation first
- 🔍 Search existing issues
- 💬 Ask in discussions
- 🐛 File detailed bug reports

### Ways to Contribute

- 🐛 Report bugs
- 💡 Suggest features
- 📖 Improve documentation
- 🔧 Submit pull requests
- 👥 Help others in discussions
- ⭐ Star the repository
- 🧪 Improve test coverage
- 📝 Update code generation scripts

### Recognition

Contributors are recognized in:

- GitHub contributors page
- Release notes
- Special mentions for significant contributions

## Pre-Commit Checklist

Before submitting your PR, ensure:

- [ ] All tests pass (`swift test`)
- [ ] Code is formatted (`swiftformat Sources/ Tests/ Examples/`)
- [ ] No compiler warnings
- [ ] Documentation is updated
- [ ] Examples work correctly
- [ ] Commit messages follow conventions
- [ ] Generated code is up to date (if modified OpenAPI spec)

## Questions?

If you have questions about contributing:

1. Check this guide and [SETUP.md](./SETUP.md)
2. Search existing issues/discussions
3. Open a new discussion
4. Contact maintainers

Thank you for contributing to the NEAR JSON-RPC Swift Client! 🚀
