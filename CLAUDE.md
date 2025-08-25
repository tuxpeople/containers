# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a container image repository that builds and publishes opinionated container images for various applications. Each application lives in the `apps/` directory with its own `Dockerfile`, `metadata.yaml`, and CI configuration.

## Key Architecture

### Directory Structure
- **apps/**: Each subdirectory contains a containerized application
  - `Dockerfile`: Container build instructions
  - `metadata.yaml`: Application metadata following CUE schema validation
  - `ci/latest.sh` or `ci/latest.py`: Script to determine latest upstream version
  - `ci/goss.yaml`: Container testing configuration (optional)
- **metadata.rules.cue**: CUE schema that validates all metadata.yaml files
- **Taskfile.yml**: Task runner for building and testing containers locally
- **.github/workflows/**: CI/CD pipelines for automated building and publishing
- **.github/scripts/**: Python automation scripts for CI/CD
  - `prepare-matrices.py`: Generates build matrices for GitHub Actions
  - `render-readme.py`: Automatically generates README files
  - `json-to-yaml.py`: Converts between JSON and YAML formats
  - `upstream.sh`: Helper script for version detection

### Container Registry
Images are published to GitHub Container Registry (ghcr.io) under the repository owner's namespace:
- Registry: `ghcr.io/tuxpeople/`
- Image naming: `ghcr.io/tuxpeople/<app-name>:<tag>`

## Development Commands

### Building and Testing Containers
```bash
# Test a specific application and channel
task APP=<app-name> CHANNEL=<channel-name> test

# Example: Test ansible container on main channel
task APP=ansible CHANNEL=main test

# Test with multiplatform build
task APP=ansible CHANNEL=main MULTIPLATFORM=true test
```

### Container Validation
```bash
# Validate metadata.yaml against CUE schema
cue vet --schema '#Spec' ./apps/<app>/metadata.json metadata.rules.cue

# Test container with dgoss (if goss config exists)
dgoss run <image-name>

# Check upstream version for an app
bash ./.github/scripts/upstream.sh <app-name> <channel-name>
```

### Local Development Workflow
```bash
# 1. Create new app structure
mkdir -p apps/myapp/ci
touch apps/myapp/Dockerfile
touch apps/myapp/metadata.yaml
touch apps/myapp/ci/latest.sh

# 2. Test locally before CI
task APP=myapp CHANNEL=main test

# 3. Validate metadata
cue vet --schema '#Spec' ./apps/myapp/metadata.json metadata.rules.cue
```

## Container Structure Patterns

### Metadata Configuration
Each app requires a `metadata.yaml` with:
- `app`: Application name (alphanumeric, hyphens, underscores)
- `base`: Boolean indicating if this is a base image
- `channels`: Array of build channels with platforms and stability info
  - `name`: Channel name (e.g., "main", "develop", "stable")
  - `platforms`: Array of target platforms (e.g., ["linux/amd64", "linux/arm64"])
  - `stable`: Boolean indicating if this is the stable channel
  - `tests`: Optional testing configuration
    - `enabled`: Boolean to enable/disable tests
    - `type`: Test type ("cli", "service", etc.)
- `semantic_versioning`: Optional boolean for version handling

#### Example metadata.yaml:
```yaml
---
app: myapp
base: false
semantic_versioning: true
channels:
  - name: main
    platforms: ["linux/amd64", "linux/arm64"]
    stable: true
    tests:
      enabled: true
      type: cli
```

### Version Detection
Apps use `ci/latest.sh` or `ci/latest.py` scripts to determine upstream versions. Common patterns:
- Parse requirements files (Python apps)
- Query GitHub releases API
- Parse upstream version strings
- Docker Hub API queries
- Custom version extraction logic

#### Version Script Requirements:
- Must accept channel name as first argument
- Must output version string to stdout
- Should handle API rate limits gracefully
- Must exit with status 0 on success

#### Docker Tag Sanitization:
Version strings containing `+` characters (e.g., `1.37.0-musl+8.15.0`) are automatically sanitized by replacing `+` with `-` to ensure Docker tag compatibility (becomes `1.37.0-musl-8.15.0`).

### Container Testing
Uses Goss (via dgoss) for container testing:
- Test files in `apps/<app>/ci/goss.yaml`
- Tests run automatically during `task test`
- Environment variables control Goss behavior

## Image Tagging Strategy

Images use semantic versioning with both version-specific and rolling tags:
- `rolling`: Latest build of the channel
- Version tags: e.g., `1.2.3`, `1.2`, `1`
- Channel prefixes for non-stable: e.g., `app-develop:rolling`

## CI/CD Pipeline

### Workflow Overview
The CI/CD system uses GitHub Actions with multiple specialized workflows:

#### Core Workflows
1. **pr-validate.yaml**: Validates pull requests
   - Builds changed images without pushing
   - Runs tests if configured
   - Validates metadata schemas

2. **release-on-merge.yaml**: Production releases
   - Triggers on main branch merges
   - Builds and pushes all changed images
   - Sends Discord notifications

3. **release-scheduled.yaml**: Automated updates
   - Runs on schedule (typically daily/weekly)
   - Rebuilds images with upstream version changes
   - Force rebuilds with `force: true` parameter

4. **build-images.yaml**: Reusable build workflow
   - Matrix builds for multiple architectures
   - Multi-platform manifest creation
   - Artifact management for cross-platform builds

#### Supporting Workflows
- **simple-checks.yaml**: Basic validation (metadata, formatting)
- **render-readme.yaml**: Auto-generates README files
- **renovate.yaml**: Dependency updates via Renovate bot
- **get-changed-images.yaml**: Detects which images need rebuilding

### Build Process
1. **Matrix Generation**: `prepare-matrices.py` creates build matrices
2. **Platform Builds**: Each platform built separately as job
3. **Artifact Collection**: Build digests stored as GitHub artifacts
4. **Manifest Merge**: Cross-platform manifests created using `docker buildx imagetools`
5. **Registry Push**: Images pushed to ghcr.io with multiple tags

### Build Matrix Structure
The build system generates matrices with:
- `images`: Array of image configurations for manifest merging
- `imagePlatforms`: Array of platform-specific build configurations

Each matrix entry contains:
- `name`: Image name
- `version`: Version string
- `tags`: Array of Docker tags
- `platforms`: Target platforms
- `dockerfile`: Path to Dockerfile
- `context`: Build context path
- `goss_config`: Path to test configuration
- `tests_enabled`: Boolean for test execution

## Configuration Volume Convention

All applications expecting persistent configuration use `/config` as the hardcoded configuration volume path inside containers.

## Troubleshooting

### Common Issues

#### Build Failures
1. **Invalid Docker Tag Format**
   - Error: `ERROR: invalid reference format`
   - Cause: Tags containing `+` characters
   - Solution: Handled automatically by tag sanitization in `prepare-matrices.py`

2. **Platform Count Mismatch**
   - Error: `Expected X platforms, but only found Y`
   - Cause: Artifact download pattern mismatch
   - Solution: Check artifact naming in build-platform-images job

3. **Missing Artifacts**
   - Error: Artifacts not found during merge
   - Cause: Build job failures or artifact naming issues
   - Solution: Check individual platform build logs

#### Version Detection Issues
1. **Script Not Executable**
   - Make sure `ci/latest.sh` has execute permissions
   - Or use Python alternative `ci/latest.py`

2. **API Rate Limits**
   - GitHub API calls may be rate limited
   - Use authentication tokens when possible
   - Implement retry logic with backoff

#### Metadata Validation
1. **CUE Schema Errors**
   - Run local validation: `cue vet --schema '#Spec' ./apps/<app>/metadata.json metadata.rules.cue`
   - Common issues: missing required fields, incorrect types

### Debugging Tips
1. **Local Testing**: Always test locally with `task APP=<name> CHANNEL=<channel> test`
2. **Matrix Inspection**: Check `prepare-matrices.py` output for matrix generation issues
3. **Workflow Logs**: GitHub Actions logs show detailed build information
4. **Registry Inspection**: Use `docker buildx imagetools inspect <image>` to verify pushed images

## Advanced Configuration

### Custom Build Args
Dockerfiles can use these build arguments:
- `VERSION`: Upstream version from version detection script
- `REVISION`: Git commit SHA
- `CHANNEL`: Build channel name

### Testing Configuration
Goss tests can be configured per application:
```yaml
# In metadata.yaml
tests:
  enabled: true
  type: cli  # or 'service' for long-running containers
```

### Multi-Channel Applications
Applications can have multiple channels (stable, beta, nightly):
```yaml
channels:
  - name: stable
    platforms: ["linux/amd64", "linux/arm64"]
    stable: true
  - name: beta
    platforms: ["linux/amd64"]
    stable: false
```

### Semantic Versioning
When `semantic_versioning: true`, additional tags are created:
- `1.2.3` (full version)
- `1.2` (minor version)
- `1` (major version)

## Development Guidelines

### Adding New Applications
1. Create directory structure in `apps/`
2. Write `Dockerfile` with multi-stage build if possible
3. Create `metadata.yaml` following schema
4. Implement version detection script
5. Optional: Add Goss tests
6. Test locally before submitting PR

### Best Practices
- Use multi-stage Dockerfiles for smaller images
- Implement proper signal handling in applications
- Use non-root users when possible
- Follow semantic versioning for stable applications
- Document configuration requirements
- Test cross-platform compatibility