#!/usr/bin/env bash

# Auto-increment version based on git commits since last release
# Format: 1.0.COMMITS_COUNT

BASE_VERSION="1.0"

# Count commits in this app directory since repository start
COMMIT_COUNT=$(git -C /Volumes/development/github/tuxpeople/containers rev-list --count HEAD -- apps/bildergallerie/ 2>/dev/null || echo "0")

# Fallback if git command fails (e.g., in CI without full history)
if [[ "$COMMIT_COUNT" == "0" || -z "$COMMIT_COUNT" ]]; then
    # Use current timestamp as fallback
    COMMIT_COUNT=$(date +%s | tail -c 4)
fi

version="${BASE_VERSION}.${COMMIT_COUNT}"
printf "%s" "${version}"
