FROM docker.io/library/alpine:3.22.2

ARG VERSION
ENV ENV_VERSION=${VERSION}

# hadolint ignore=DL3018,DL3017
RUN apk --no-cache upgrade && \
    apk --no-cache add ca-certificates curl file && \
    adduser -D abc -u 1000

# Download and verify rtfctl binary
RUN curl -fsSL "https://anypoint.mulesoft.com/runtimefabric/api/download/rtfctl/${ENV_VERSION}" -o /tmp/rtfctl && \
    # Verify the download is an executable binary
    file /tmp/rtfctl | grep -E "(executable|ELF)" && \
    # Verify the binary is not empty and has reasonable size
    [ -s /tmp/rtfctl ] && \
    [ $(stat -c%s /tmp/rtfctl) -gt 1000 ] && \
    chmod 755 /tmp/rtfctl && \
    chown 1000:1000 /tmp/rtfctl && \
    mv /tmp/rtfctl /usr/local/bin/rtfctl && \
    apk del curl file

USER 1000
