#!/usr/bin/env bash

# renovate: datasource=docker depName=library/busybox
BUSYBOX_VERSION=1.37.0-musl

# r e n o v a t e: datasource=github-releases depName=curl/curl
CURL_VERSION=$(curl -sX GET https://api.github.com/repos/curl/curl/releases/latest | jq -r .name 2>/dev/null)

# Fallback if API call fails
if [[ -z "$CURL_VERSION" || "$CURL_VERSION" == "null" ]]; then
  # renovate: fallback-version=curl/curl
  CURL_VERSION="8.11.0"  # Last known good version
fi

version="${BUSYBOX_VERSION}+${CURL_VERSION}"
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
