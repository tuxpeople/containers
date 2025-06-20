FROM golang:alpine AS builder
ARG VERSION
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

# hadolint ignore=DL4006,DL3018,DL3003,SC2164
RUN \
  apk add --no-cache git; \
  git clone https://github.com/IzakMarais/reporter.git /upstream \
  && if [ -n "${VERSION}" ]; then \
  ( cd /upstream/; \
  git checkout tags/v${VERSION}); \
  fi

WORKDIR /upstream

#RUN go mod init; go mod download; CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build github.com/IzakMarais/reporter/cmd/grafana-reporter

RUN go install github.com/IzakMarais/reporter/cmd/grafana-reporter@${VERSION}

FROM leplusorg/latex

#COPY --from=builder /upstream/grafana-reporter /grafana-reporter
COPY --from=builder /go/bin/grafana-reporter /grafana-reporter

ENTRYPOINT ["/grafana-reporter"]
