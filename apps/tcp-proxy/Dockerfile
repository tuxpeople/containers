FROM alpine:3.20.0

# hadolint ignore=DL3018
RUN apk add --no-cache bash socat

COPY ./apps/tcp-proxy/tcp-proxy.sh /usr/bin/tcp-proxy

ENTRYPOINT ["tcp-proxy"]
