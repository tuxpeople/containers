#!/usr/bin/env bash

# renovate: datasource=docker depName=library/busybox
BUSYBOX_VERSION=1.37.0-musl

# renovate: datasource=github-releases depName=curl/curl
CURL_VERSION=8.11.0

version="${BUSYBOX_VERSION}+${CURL_VERSION}"
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
