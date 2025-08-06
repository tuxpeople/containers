# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a container image repository that builds and publishes opinionated container images for various applications. Each application lives in the `apps/` directory with its own `Dockerfile`, `metadata.yaml`, and CI configuration.

## Key Architecture

- **apps/**: Each subdirectory contains a containerized application
  - `Dockerfile`: Container build instructions
  - `metadata.yaml`: Application metadata following CUE schema validation
  - `ci/latest.sh`: Script to determine latest upstream version
  - `ci/goss.yaml`: Container testing configuration (optional)
- **metadata.rules.cue**: CUE schema that validates all metadata.yaml files
- **Taskfile.yml**: Task runner for building and testing containers
- **.github/workflows/**: CI/CD pipelines for automated building and publishing

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
```

## Container Structure Patterns

### Metadata Configuration
Each app requires a `metadata.yaml` with:
- `app`: Application name (alphanumeric, hyphens, underscores)
- `base`: Boolean indicating if this is a base image
- `channels`: Array of build channels with platforms and stability info
- `semantic_versioning`: Optional boolean for version handling

### Version Detection
Apps use `ci/latest.sh` scripts to determine upstream versions. Common patterns:
- Parse requirements files (Python apps)
- Query GitHub releases API
- Parse upstream version strings

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

- **PR Validation**: Builds changed images without pushing
- **Release on Merge**: Builds and pushes to registry on main branch
- **Scheduled Releases**: Periodic rebuilds to catch upstream updates
- Uses GitHub Actions with matrix builds for multiple architectures

## Configuration Volume Convention

All applications expecting persistent configuration use `/config` as the hardcoded configuration volume path inside containers.