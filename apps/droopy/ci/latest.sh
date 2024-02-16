#!/usr/bin/env bash
version=$(curl -sX GET https://api.github.com/repos/gurnec/Droopy/commits/master | jq -r .sha | cut -c1-7 2>/dev/null)
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
