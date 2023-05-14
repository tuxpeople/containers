FROM golang:alpine AS builder
ARG VERSION

WORKDIR /build

# hadolint ignore=DL4006,DL3018,DL3003,SC2164
RUN \
  git clone https://github.com/pryorda/vmware_exporter.git \
  && if [ -n "${VERSION}" ]; then \
  ( cd ./vmware_exporter/; \
  git checkout tags/v${VERSION}); \
  fi 

FROM python:3.7-alpine

WORKDIR /opt/vmware_exporter/
COPY ./vmware_exporter/ /opt/vmware_exporter/
# hadolint ignore=DL3018,DL3017,SC2086
RUN set -x; buildDeps="gcc python3-dev musl-dev libffi-dev openssl openssl-dev rust cargo" \
 && apk add --no-cache --update $buildDeps \
 && pip install --no-cache-dir -r requirements.txt . \
 && apk del $buildDeps

EXPOSE 9272

ENV PYTHONUNBUFFERED=1

ENTRYPOINT ["/usr/local/bin/vmware_exporter"]