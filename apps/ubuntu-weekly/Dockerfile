FROM ubuntu:noble-20250619

ENV DEBIAN_FRONTEND=noninteractive

# hadolint ignore=DL3008,DL3009
RUN apt-get update && \
  apt-get upgrade -y

USER ubuntu
WORKDIR /home/ubuntu
