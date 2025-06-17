FROM ghcr.io/tuxpeople/baseimage-alpine-light:v3.22

RUN \
  apk add --no-cache --upgrade \
  yq jq

COPY --chown=abc:abc --chmod=774 ./apps/tooler/root/ /

USER abc
