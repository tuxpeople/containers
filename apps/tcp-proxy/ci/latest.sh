#!/usr/bin/env bash
version=$(curl -sX GET https://api.github.com/repos/hpello/tcp-proxy-docker/git/refs/tags | jq -r .[].ref | cut -d'/' -f3 | sort --version-sort | tail -1 2>/dev/null)
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
