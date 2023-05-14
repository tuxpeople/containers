#!/usr/bin/env bash
version=$(curl -sX GET https://api.github.com/repos/pryorda/vmware_exporter/releases/latest | jq --raw-output '. | .tag_name' 2>/dev/null)
version="${version#*v}"
version="${version#*release-}"
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
git clone https://github.com/pryorda/vmware_exporter.git . >/dev/null 2>&1
git checkout tags/v${version} >/dev/null 2>&1
printf "%s" "${version}"