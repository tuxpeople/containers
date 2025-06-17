FROM alpine AS builder

# Originally from https://github.com/moparisthebest/static-curl/blob/master/build.sh
COPY ./apps/busycurl/build.sh /build.sh
RUN /build.sh

FROM busybox:1.37.0-musl

COPY --from=builder /tmp/release/curl /usr/local/bin/curl
