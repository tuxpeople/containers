#!/usr/bin/env bash
version="d$(date --date='last friday' +%Y%m%d)"
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
