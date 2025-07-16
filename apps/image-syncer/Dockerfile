FROM golang:1.24 as builder
# UPSTREAM_VERSION can be changed, by passing `--build-arg UPSTREAM_VERSION=<new version>` during docker build
ARG UPSTREAM_VERSION=master
ENV UPSTREAM_VERSION=${UPSTREAM_VERSION}

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

LABEL stage=builder

WORKDIR /go/src/github.com/AliyunContainerService/image-syncer
#hadolint ignore=DL4006
RUN wget -nv -O - https://github.com/AliyunContainerService/image-syncer/archive/${UPSTREAM_VERSION}.tar.gz | tar -xz --strip-components=1 && \
    CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} make

FROM docker.io/library/alpine:3.22.1
WORKDIR /app/
# hadolint ignore=DL3018,DL3017
RUN apk --no-cache upgrade && \
    apk --no-cache add ca-certificates && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /etc/ssl/certs && \
    update-ca-certificates --fresh
COPY --from=builder /go/src/github.com/AliyunContainerService/image-syncer/image-syncer ./

ENTRYPOINT ["/app/image-syncer"]
CMD ["--config", "/etc/image-syncer/image-syncer.json"]
