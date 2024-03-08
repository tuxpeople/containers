#!/usr/bin/env bash
version="$(date --date='last friday' +0.%Y.%m%d)"
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
