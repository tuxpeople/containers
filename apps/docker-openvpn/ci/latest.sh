#!/usr/bin/env bash
version=latest
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
