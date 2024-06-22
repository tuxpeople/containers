#!/usr/bin/env bash
version=git-$(curl -sX GET https://api.github.com/repos/tuxpeople/containers/commits/main | jq -r .sha | cut -c1-7 2>/dev/null)
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
