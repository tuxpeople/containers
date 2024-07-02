FROM scratch

ARG VERSION

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

ADD --chmod=755 --chown=1001 https://github.com/carvel-dev/imgpkg/releases/download/v${VERSION}/imgpkg-${TARGETOS}-${TARGETARCH} /app/imgpkg

ENTRYPOINT ["/app/imgpkg"]
CMD ["--version"]
