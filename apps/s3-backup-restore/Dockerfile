FROM golang:alpine AS builder
ARG VERSION
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

# hadolint ignore=DL4006,DL3018,DL3003,SC2164
RUN \
  apk add --no-cache git; \
  git clone https://github.com/bloveless/docker-images.git /upstream
WORKDIR /upstream/s3-backup-restore
RUN go build -o /bin/s3-backup-restore cmd/s3-backup-restore/main.go

FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=builder /bin/s3-backup-restore /bin/s3-backup-restore
ENTRYPOINT ["/bin/s3-backup-restore"]
CMD ["cron"]