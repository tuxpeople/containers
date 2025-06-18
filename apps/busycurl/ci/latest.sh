#!/usr/bin/env bash

# renovate: datasource=docker depName=library/busybox
BUSYBOX_VERSION=1.37.0-musl

# r e n o v a t e: datasource=github-releases depName=curl/curl
CURL_VERSION=$(curl -sX GET https://api.github.com/repos/curl/curl/releases/latest | jq -r .name)

version="${BUSYBOX_VERSION}+${CURL_VERSION}"
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
