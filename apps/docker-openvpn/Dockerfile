# Original credit: https://github.com/jpetazzo/dockvpn
# Fork from https://github.com/kylemanna/docker-openvpn

# Smallest base image
FROM alpine:3.22.1

LABEL maintainer="https://gitlab.com/domrod"

# Testing: pamtester
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
  apk add --update openvpn iptables bash easy-rsa openvpn-auth-pam google-authenticator pamtester libqrencode && \
  ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
  rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# Needed by scripts
ENV OPENVPN=/etc/openvpn
ENV EASYRSA=/usr/share/easy-rsa \
  EASYRSA_CRL_DAYS=3650 \
  EASYRSA_PKI=$OPENVPN/pki

VOLUME ["/etc/openvpn"]

# Internally uses port 1194/udp, remap using `docker run -p 443:1194/tcp`
EXPOSE 1194/udp

CMD ["ovpn_run"]

COPY ./apps/docker-openvpn/bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# Add support for OTP authentication using a PAM module
COPY ./apps/docker-openvpn/otp/openvpn /etc/pam.d/
