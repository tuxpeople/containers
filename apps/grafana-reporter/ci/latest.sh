#!/usr/bin/env bash
version=$(curl -sX GET https://api.github.com/repos/IzakMarais/reporter/git/refs/tags | jq -r .[].ref | cut -d'/' -f3 | sort --version-sort | tail -1 2>/dev/null)
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
