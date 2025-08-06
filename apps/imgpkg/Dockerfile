FROM alpine:latest AS downloader

ARG VERSION
ARG TARGETOS
ARG TARGETARCH

# hadolint ignore=DL3018
RUN apk add --no-cache curl file ca-certificates

# Download and verify imgpkg binary
RUN curl -fsSL "https://github.com/carvel-dev/imgpkg/releases/download/v${VERSION}/imgpkg-${TARGETOS}-${TARGETARCH}" -o /tmp/imgpkg && \
    # Verify the download is an executable binary
    file /tmp/imgpkg | grep -E "(executable|ELF)" && \
    # Verify the binary is not empty and has reasonable size
    [ -s /tmp/imgpkg ] && \
    [ $(stat -c%s /tmp/imgpkg) -gt 1000 ] && \
    chmod 755 /tmp/imgpkg

FROM gcr.io/distroless/static-debian12:nonroot

COPY --from=downloader /tmp/imgpkg /app/imgpkg

ENTRYPOINT ["/app/imgpkg"]
CMD ["--version"]
