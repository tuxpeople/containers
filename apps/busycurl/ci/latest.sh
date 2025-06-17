#!/usr/bin/env bash
version="0.0.$(date --date='last friday' +%Y%m%d)"
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
