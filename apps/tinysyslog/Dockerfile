FROM golang:alpine AS builder
ARG VERSION
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

# hadolint ignore=DL4006,DL3018,DL3003,SC2164
RUN \
  apk add --no-cache git; \
  git clone https://github.com/alexferl/tinysyslog.git /upstream \
  && if [ -n "${VERSION}" ]; then \
  ( cd /upstream/; \
  git checkout tags/v${VERSION}); \
  fi

WORKDIR /upstream

RUN go mod download; CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build ./cmd/tinysyslogd

FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=builder /upstream/tinysyslogd /tinysyslogd

EXPOSE 5140 5140/udp

ENTRYPOINT ["/tinysyslogd", "--bind-addr", "0.0.0.0:5140"]
