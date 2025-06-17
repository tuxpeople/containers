FROM alpine AS builder

# Originally from https://github.com/moparisthebest/static-curl/blob/master/build.sh
COPY ./apps/busycurl/build.sh /build.sh
# Daniel Stenberg's GPG key used for signing/verifying curl releases: https://daniel.haxx.se/address.html
COPY ./apps/busycurl/mykey.asc /mykey.asc
RUN /build.sh

FROM busybox:1.37.0-musl
COPY --from=builder /tmp/release/curl /usr/local/bin/curl
