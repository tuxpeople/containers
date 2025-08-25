#!/usr/bin/env bash

# Get latest stable Kubernetes version
version=$(curl -L -s https://dl.k8s.io/release/stable.txt 2>/dev/null)

# Fallback if API call fails
if [[ -z "$version" || "$version" == "null" ]]; then
  # renovate: fallback-version=kubernetes/kubernetes
  version="v1.32.0"  # Last known good version
fi

version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
