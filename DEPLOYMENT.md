# Deployment Guide

This guide covers the deployment and release process for the NEAR JSON-RPC Swift Client, including tagging, versioning, and distribution via Swift Package Manager.

## Overview

The project uses:

- **Git Tags** for version management
- **GitHub Actions** for CI/CD
- **Swift Package Manager** for distribution
- **Semantic Versioning** for version numbers
- **Conventional Commits** for changelog generation

### Package Structure

The Swift package contains two modules:

```
NearJsonRpc
├── NearJsonRpcClient    # Main client implementation
└── NearJsonRpcTypes     # Types and Codable structures
```

## Release Process

### Standard Release Flow

1. **Development**: Merge PRs with conventional commits to `main`
2. **Version Update**: Update `VERSION` file with new version number
3. **Tag Creation**: Create and push a git tag for the release
4. **GitHub Release**: Create GitHub release with changelog
5. **Distribution**: Package is automatically available via SPM

### Release Types

Following Semantic Versioning:

- `fix:` commits → Patch release (0.0.X)
- `feat:` commits → Minor release (0.X.0)
- `feat!:` or `BREAKING CHANGE:` → Major release (X.0.0)

## Version Management

### Version File

The project maintains a `VERSION` file at the root:

```bash
# View current version
cat VERSION

# Update version
echo "1.1.0" > VERSION
```

### Semantic Versioning

Follow [SemVer](https://semver.org/) guidelines:

- **Major (X.0.0)**: Breaking API changes
- **Minor (0.X.0)**: New features, backwards compatible
- **Patch (0.0.X)**: Bug fixes, backwards compatible

### Version Numbering Examples

```
1.0.0 → 1.0.1  # Bug fix
1.0.1 → 1.1.0  # New feature
1.1.0 → 2.0.0  # Breaking change
```

## Creating a Release

### Prerequisites

1. **Repository Access**: Write access to the repository
2. **Clean Working Directory**: All changes committed
3. **Tests Passing**: All tests must pass
4. **Updated Documentation**: README and docs reflect changes

### Release Steps

#### 1. Prepare the Release

```bash
# Ensure you're on main and up to date
git checkout main
git pull origin main

# Ensure clean working directory
git status

# Run all tests
swift test

# Format code
swiftformat Sources/ Tests/ Examples/

# Build in release mode
swift build -c release
```

#### 2. Update Version

```bash
# Update VERSION file
echo "1.1.0" > VERSION

# Update Package.swift if needed (version references in comments)

# Commit version change
git add VERSION
git commit -m "chore: bump version to 1.1.0"
git push origin main
```

#### 3. Create and Push Tag

```bash
# Create annotated tag
git tag -a v1.1.0 -m "Release v1.1.0

Features:
- Add new RPC method support
- Improve error handling

Bug Fixes:
- Fix decoding issue for AccountView
"

# Push tag
git push origin v1.1.0
```

#### 4. Create GitHub Release

```bash
# Using GitHub CLI
gh release create v1.1.0 \
  --title "v1.1.0" \
  --notes "## What's Changed

### Features
- Add new RPC method support (#123)
- Improve error handling (#124)

### Bug Fixes
- Fix decoding issue for AccountView (#125)

**Full Changelog**: https://github.com/space-rock/near-jsonrpc-swift/compare/v1.0.0...v1.1.0"

# Or create manually on GitHub:
# https://github.com/space-rock/near-jsonrpc-swift/releases/new
```

### Pre-release Versions

For beta or alpha releases:

```bash
# Update version with pre-release suffix
echo "2.0.0-beta.1" > VERSION

# Create tag
git tag -a v2.0.0-beta.1 -m "Release v2.0.0-beta.1 (Beta)"

# Push tag
git push origin v2.0.0-beta.1

# Create GitHub release with pre-release flag
gh release create v2.0.0-beta.1 \
  --title "v2.0.0-beta.1" \
  --notes "Beta release for testing" \
  --prerelease
```

## Distribution

### Swift Package Manager

The package is distributed via Swift Package Manager. Users can add it to their projects in several ways:

#### Package.swift

```swift
dependencies: [
    .package(url: "https://github.com/space-rock/near-jsonrpc-swift.git", from: "1.0.0")
]
```

#### Xcode

1. File → Add Package Dependencies
2. Enter repository URL: `https://github.com/space-rock/near-jsonrpc-swift.git`
3. Select version rules

### Version Resolution

SPM uses git tags for version resolution:

- **Exact Version**: `.package(url: "...", exact: "1.0.0")`
- **Range**: `.package(url: "...", "1.0.0"..<"2.0.0")`
- **From**: `.package(url: "...", from: "1.0.0")` (recommended)
- **Branch**: `.package(url: "...", branch: "main")` (development only)

### Testing Package Resolution

```bash
# Test that SPM can resolve the package
swift package resolve

# Show dependencies
swift package show-dependencies

# Verify specific version can be resolved
swift package update
```

## CI/CD Pipeline

### CI Workflow

The `.github/workflows/ci.yml` runs on every push and PR:

```yaml
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build
        run: swift build
      - name: Run tests
        run: swift test
```

### Release Pipeline Stages

1. **PR Checks**
   - Swift build verification
   - Unit tests
   - Code formatting (swiftformat)
   - Integration tests (if applicable)

2. **Tag Push**
   - Automatic tagging (optional)
   - GitHub release creation
   - SPM cache updates

3. **Post-Release**
   - Documentation updates
   - Announcement (if major release)
   - Version verification

## Security

### Access Control

1. **GitHub Access**
   - Protected branches for `main`
   - Required reviews for PRs
   - Signed commits recommended
   - Tag protection enabled

2. **Release Access**
   - Limit release creation to maintainers
   - Use GitHub environments for production releases
   - Require manual approval for releases

### Security Checklist

- [ ] GitHub branch protection enabled
- [ ] Tag protection enabled for `v*` pattern
- [ ] All dependencies reviewed
- [ ] No sensitive data in code
- [ ] Security advisories enabled
- [ ] Dependabot alerts enabled (if applicable)
- [ ] Code signing considered for future

### Secure Release Process

```bash
# Use signed commits
git config --global commit.gpgsign true

# Sign tags
git tag -s v1.0.0 -m "Release v1.0.0"

# Verify tag signature
git tag -v v1.0.0
```

## Rollback Procedures

### Tag and Release Rollback

```bash
# 1. Delete the faulty tag locally and remotely
git tag -d v1.2.3
git push --delete origin v1.2.3

# 2. Delete the GitHub release
gh release delete v1.2.3 --yes

# 3. Revert problematic commits (if needed)
git revert <commit-hash>
git push origin main

# 4. Create a new patch release
echo "1.2.4" > VERSION
git add VERSION
git commit -m "chore: bump version to 1.2.4"
git push origin main

git tag -a v1.2.4 -m "Release v1.2.4 - Fixes issues in v1.2.3"
git push origin v1.2.4
```

### Communication

When rolling back a release:

1. **Immediate**: Create GitHub issue explaining the problem
2. **Users**: Update GitHub release notes with warning
3. **Documentation**: Add to known issues
4. **Fix**: Release patch version ASAP
5. **Post-mortem**: Document what went wrong and how to prevent it

### Emergency Hotfix Process

```bash
# 1. Create hotfix branch from main
git checkout -b hotfix/critical-bug main

# 2. Fix the bug
# Make necessary changes

# 3. Test thoroughly
swift test

# 4. Merge back to main
git checkout main
git merge --no-ff hotfix/critical-bug

# 5. Create new patch release immediately
echo "1.2.4" > VERSION
git add VERSION
git commit -m "chore: bump version to 1.2.4 (hotfix)"
git push origin main

git tag -a v1.2.4 -m "Hotfix: Critical bug fix"
git push origin v1.2.4
```

## Monitoring

### Package Usage

Monitor via GitHub:

- Stars and watchers
- Forks
- Dependent repositories
- Traffic analytics

```bash
# Check dependent repositories
gh api /repos/space-rock/near-jsonrpc-swift/dependents

# View traffic
# Visit: https://github.com/space-rock/near-jsonrpc-swift/graphs/traffic
```

### Issue Tracking

Monitor for deployment-related issues:

1. **GitHub Issues**: Filter for `deployment` or `release` labels
2. **GitHub Discussions**: Check for user reports
3. **CI/CD Failures**: Monitor workflow runs

### Health Checks

```bash
# Verify package can be resolved by SPM
swift package resolve

# Test installation in a clean project
mkdir test-install && cd test-install
swift package init --type executable
# Add package dependency to Package.swift
swift build

```

## Troubleshooting

### Common Issues

#### Tag Already Exists

```bash
# Error: Tag v1.0.0 already exists
# Solution: Delete local and remote tag, then recreate
git tag -d v1.0.0
git push --delete origin v1.0.0

# Create new tag
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

#### GitHub Actions Fails

```bash
# Check workflow logs
gh run list
gh run view <run-id>

# View specific job logs
gh run view <run-id> --log

# Re-run failed jobs
gh run rerun <run-id>
```

#### SPM Cannot Resolve Package

```bash
# Clear SPM cache
rm -rf ~/Library/Caches/org.swift.swiftpm/
rm -rf ~/Library/Developer/Xcode/DerivedData/

# Try resolving again
swift package resolve

# Check if tag exists
git ls-remote --tags origin

# Verify Package.swift is valid
swift package dump-package
```

#### Version Mismatch

```bash
# Ensure VERSION file matches the git tag
cat VERSION  # Should match tag without 'v' prefix

# Update if needed
echo "1.0.0" > VERSION
git add VERSION
git commit -m "chore: sync VERSION file"
git push origin main
```

### Emergency Procedures

1. **Broken Release**

   ```bash
   # Delete tag and release
   git tag -d v1.2.3
   git push --delete origin v1.2.3
   gh release delete v1.2.3 --yes

   # Notify users
   # Create GitHub issue with label "critical"
   gh issue create --title "Critical issue in v1.2.3" --label critical
   
   # Update release notes with warning
   ```

2. **Security Issue**

   ```bash
   # Create security advisory
   # Go to: https://github.com/space-rock/near-jsonrpc-swift/security/advisories/new

   # Immediate hotfix
   git checkout -b security/CVE-fix main
   # Fix vulnerability
   swift test
   git commit -am "fix: security vulnerability"
   git push

   # Fast-track PR and release patch
   ```

3. **CI Failure**
   ```bash
   # Check CI logs
   gh run list --limit 5
   
   # Manual verification
   swift build -c release
   swift test
   
   # If CI is broken but code is good, tag manually
   git tag -a v1.0.0 -m "Release v1.0.0"
   git push origin v1.0.0
   ```

### Debug Commands

```bash
# Verify tag
git show v1.0.0

# List all tags
git tag -l

# Check remote tags
git ls-remote --tags origin

# Validate Package.swift
swift package dump-package | python3 -m json.tool

# Test package resolution
swift package resolve --verbose

# Show package dependencies
swift package show-dependencies
```

## Best Practices

### Pre-Release Checklist

- [ ] All tests passing (`swift test`)
- [ ] Code formatted (`swiftformat Sources/ Tests/ Examples/`)
- [ ] No compiler warnings
- [ ] Generated code up to date (if OpenAPI spec changed)
- [ ] Documentation updated
- [ ] CHANGELOG.md updated
- [ ] VERSION file updated
- [ ] Migration guide (if breaking changes)
- [ ] Examples still work

### Release Notes Template

```markdown
## What's Changed

### Features
- Add support for new RPC methods (#123)
- Improve error handling in client (#124)

### Bug Fixes
- Fix Codable conformance for AccountView (#125)
- Correct decoding strategy for nested enums (#126)

### Breaking Changes
- Change actor isolation model for NearJsonRpcClient (#127)
  - Migration: Update your code to handle the new actor isolation
  - See MIGRATING.md for details

### Code Generation
- Update OpenAPI specification to latest version
- Regenerate all types and methods

**Full Changelog**: https://github.com/space-rock/near-jsonrpc-swift/compare/v1.0.0...v1.1.0
```

### Post-Release Tasks

1. **Verify Release**
   - Check GitHub release page
   - Test SPM installation in clean project
   - Verify examples compile and run
   - Check that documentation is accessible

2. **Update Documentation**
   - Update README version references
   - Add migration notes (if breaking)
   - Update code examples
   - Update API documentation (if using DocC)

3. **Announce** (for major releases)
   - GitHub discussions
   - Twitter/social media
   - NEAR community channels
   - Update project website (if applicable)

4. **Monitor**
   - Watch for issues
   - Check CI status
   - Monitor GitHub discussions
   - Respond to user feedback

## Additional Resources

- [Swift Package Manager Documentation](https://swift.org/package-manager/)
- [GitHub Releases Documentation](https://docs.github.com/en/repositories/releasing-projects-on-github)
- [Semantic Versioning](https://semver.org/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Git Tag Documentation](https://git-scm.com/book/en/v2/Git-Basics-Tagging)
- [CONTRIBUTING.md](./CONTRIBUTING.md)
- [SETUP.md](./SETUP.md)
