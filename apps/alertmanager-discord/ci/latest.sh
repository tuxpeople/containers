#!/usr/bin/env bash
# version=$(curl -sX GET https://api.github.com/repos/benjojo/alertmanager-discord/releases/latest | jq --raw-output '. | .tag_name' 2>/dev/null)
# version="${version#*v}"
# version="${version#*release-}"
version="git"
printf "%s" "${version}"
