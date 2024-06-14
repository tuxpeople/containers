#!/usr/bin/env bash
version=git-$(curl -sX GET https://api.github.com/repos/bloveless/docker-images/commits/main | jq -r .sha | cut -c1-7 2>/dev/null)
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"