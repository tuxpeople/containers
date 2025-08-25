#!/usr/bin/env bash

# Get latest semantic version from GitLab domrod/docker-openvpn repository
version=$(curl -sX GET "https://gitlab.com/api/v4/projects/24751406/repository/tags" | \
  jq -r '.[0].name' | \
  sed 's/^v//' 2>/dev/null)

# Fallback if API call fails
if [[ -z "$version" || "$version" == "null" ]]; then
  version="2.6.12"  # Last known good version
fi

version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
