FROM alpine AS builder

# renovate: datasource=docker depName=library/busybox
ARG BUSYBOX_VERSION=1.37.0-musl

# Originally from https://github.com/moparisthebest/static-curl/blob/master/build.sh
COPY ./apps/busycurl/build.sh /build.sh
# Daniel Stenberg's GPG key used for signing/verifying curl releases: https://daniel.haxx.se/address.html
COPY ./apps/busycurl/mykey.asc /mykey.asc
RUN /build.sh

FROM busybox:${BUSYBOX_VERSION}
COPY --from=builder /tmp/release/curl /usr/local/bin/curl
