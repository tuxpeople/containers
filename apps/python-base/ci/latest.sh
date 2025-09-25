#!/usr/bin/env bash
version="$(date --date='last friday' +%Y%m%d)"
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
