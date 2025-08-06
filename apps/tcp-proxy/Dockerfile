FROM docker.io/library/alpine:3.22.1

# hadolint ignore=DL3018
RUN apk add --no-cache bash socat && \
    adduser -D -u 1001 appuser

COPY ./apps/tcp-proxy/tcp-proxy.sh /usr/bin/tcp-proxy

USER appuser
ENTRYPOINT ["tcp-proxy"]
