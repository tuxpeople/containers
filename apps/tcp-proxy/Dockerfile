FROM docker.io/library/alpine:3.22.0

# hadolint ignore=DL3018
RUN apk add --no-cache bash socat

COPY ./apps/tcp-proxy/tcp-proxy.sh /usr/bin/tcp-proxy

ENTRYPOINT ["tcp-proxy"]
