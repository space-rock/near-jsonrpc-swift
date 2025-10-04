# Deployment Guide

This guide covers the deployment and release process for the NEAR JSON-RPC Swift Client, including tagging, versioning, and distribution via Swift Package Manager.

## Overview

The project uses:

- **Git Tags** for version management
- **GitHub Actions** for CI/CD automation
- **Release Please** for automated releases and changelog generation
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

Following Semantic Versioning (automated via Release Please):

- `fix:` commits → Patch release (0.0.X)
- `feat:` commits → Minor release (0.X.0)
- `feat!:` or `BREAKING CHANGE:` → Major release (X.0.0)

### Automated Release Process

The project uses **Release Please** for automated releases:

1. **Merge PRs** with conventional commits to `main`
2. **Release Please** automatically:
   - Creates/updates a release PR with changelog
   - Bumps version based on commit types
   - Updates CHANGELOG.md
3. **Merge Release PR** to trigger:
   - Tag creation
   - GitHub release creation
   - Release asset publishing

## Version Management

### Automated Version Management

Versions are automatically managed by **Release Please**:

- Analyzes conventional commits since last release
- Determines version bump (major/minor/patch)
- Updates CHANGELOG.md automatically
- Creates release PR with version changes

### Version File

The project uses CHANGELOG.md for version tracking (managed by Release Please):

```bash
# View current version
head -n 10 CHANGELOG.md

# Version is automatically updated by Release Please
# Do not manually edit CHANGELOG.md
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

### Automated Release Process (Recommended)

The project uses **Release Please** for automated releases. Simply merge PRs with conventional commits:

#### 1. Develop with Conventional Commits

```bash
# Make changes and commit with conventional commit format
git commit -m "feat: add new RPC method support"
git commit -m "fix: correct decoding issue for AccountView"
git push origin feature-branch
```

#### 2. Merge PR to Main

```bash
# Create and merge PR to main
# Release Please will automatically:
# - Analyze commits since last release
# - Create/update a release PR
```

#### 3. Review Release PR

- Release Please creates a PR titled "chore(main): release X.Y.Z"
- Review the generated CHANGELOG.md
- Verify version bump is correct
- Check that all changes are documented

#### 4. Merge Release PR

```bash
# Merge the release PR
# This automatically:
# - Creates a git tag (vX.Y.Z)
# - Creates a GitHub release
# - Publishes release assets
# - Updates CHANGELOG.md on main
```

### Manual Release Process (Not Recommended)

For emergency releases or if automation fails:

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

#### 2. Update CHANGELOG.md

```bash
# Manually update CHANGELOG.md with release notes
# Follow the existing format
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

### Workflow Overview

The project uses three GitHub Actions workflows:

1. **CI/CD** (`.github/workflows/ci-cd.yml`)
2. **Daily OpenAPI Spec Fetch** (`.github/workflows/generate.yml`)
3. **Release Please** (`.github/workflows/publish.yml`)

### CI/CD Workflow

The `.github/workflows/ci-cd.yml` runs on every push and PR:

**Triggers:**
- Push to `main` branch
- Pull requests to `main` branch

**Jobs:**

1. **test-macos**: Tests on macOS 14 with Swift 6.1
   - Generates Swift code from OpenAPI spec
   - Builds Swift package
   - Runs tests with code coverage
   - Uploads coverage to Codecov

2. **test-linux**: Tests on Linux with Swift 6.1
   - Generates Swift code from OpenAPI spec
   - Builds Swift package
   - Runs tests

3. **validate-package**: Validates Swift package structure (PR only)
   - Runs after macOS and Linux tests pass
   - Validates package manifest

### Daily OpenAPI Spec Fetch Workflow

The `.github/workflows/generate.yml` automatically updates the OpenAPI spec:

**Triggers:**
- Daily at midnight (cron: `0 0 * * *`)
- Manual workflow dispatch with optional custom URL

**Process:**
1. Downloads latest OpenAPI spec from configured URL (repository variable `INPUT_JSON_URL`)
2. Checks for changes in the spec
3. If changes detected:
   - Regenerates Swift code
   - Builds and tests the package
   - Creates/updates PR with changes

**Configuration:**
- Set repository variable `INPUT_JSON_URL` to the OpenAPI spec URL
- Or provide URL via manual workflow dispatch

### Release Please Workflow

The `.github/workflows/publish.yml` automates releases:

**Triggers:**
- Push to `main` branch

**Jobs:**

1. **release-please**: Creates/updates release PR
   - Analyzes conventional commits since last release
   - Determines version bump (major/minor/patch)
   - Updates CHANGELOG.md
   - Creates/updates release PR

2. **publish-release**: Publishes release assets (when release PR is merged)
   - Generates Swift code from OpenAPI spec
   - Validates package (build + test)
   - Builds documentation (if available)
   - Creates release archive (.zip)
   - Uploads assets to GitHub release

### Release Pipeline Stages

1. **PR Checks** (CI/CD Workflow)
   - Swift build verification on macOS and Linux
   - Unit tests with code coverage
   - Code generation from OpenAPI spec
   - Package structure validation

2. **Release PR Creation** (Release Please Workflow)
   - Automatic release PR creation/update
   - Changelog generation from conventional commits
   - Version bumping based on commit types

3. **Release Publishing** (Release Please Workflow)
   - Triggered when release PR is merged
   - Tag creation
   - GitHub release creation
   - Release assets upload
   - SPM cache updates

4. **Post-Release**
   - Documentation updates (automated)
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

# Check specific workflow runs
gh run list --workflow=ci-cd.yml
gh run list --workflow=generate.yml
gh run list --workflow=publish.yml
```

#### Release Please Not Creating PR

```bash
# Ensure commits follow conventional commit format
git log --oneline -10

# Check if release PR already exists
gh pr list --label "autorelease: pending"

# Manually trigger Release Please workflow
gh workflow run publish.yml

# Check workflow logs
gh run list --workflow=publish.yml
```

#### OpenAPI Spec Update Fails

```bash
# Check if INPUT_JSON_URL repository variable is set
gh variable list

# Set the variable if missing
gh variable set INPUT_JSON_URL --body "https://raw.githubusercontent.com/near/near-jsonrpc-client-rs/master/openapi.json"

# Manually trigger the workflow
gh workflow run generate.yml

# Or with custom URL
gh workflow run generate.yml -f openapi_url="https://custom-url.com/openapi.json"
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

**For Automated Releases (Release Please):**
- [ ] All PRs use conventional commit format
- [ ] All tests passing in CI/CD workflow
- [ ] Code formatted (`swiftformat Sources/ Tests/ Examples/`)
- [ ] No compiler warnings
- [ ] Generated code up to date (if OpenAPI spec changed)
- [ ] Documentation updated
- [ ] Examples still work
- [ ] Review Release Please PR before merging

**For Manual Releases (Emergency Only):**
- [ ] All tests passing (`swift test`)
- [ ] Code formatted (`swiftformat Sources/ Tests/ Examples/`)
- [ ] No compiler warnings
- [ ] Generated code up to date (if OpenAPI spec changed)
- [ ] Documentation updated
- [ ] CHANGELOG.md manually updated
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
