#!/usr/bin/env bash

# Get latest commit hash from GitHub API
commit_hash=$(curl -sX GET https://api.github.com/repos/benjojo/alertmanager-discord/commits/master | jq -r .sha | cut -c1-7 2>/dev/null)

# Fallback if API call fails  
if [[ -z "$commit_hash" || "$commit_hash" == "null" ]]; then
  # Use timestamp as fallback (git-hash style projects don't use renovate fallbacks)
  commit_hash=$(date +%s | tail -c 8)
fi

version="git-${commit_hash}"
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
