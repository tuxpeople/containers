#!/usr/bin/env bash

HOST=${TARGET_HOST:-$1}
PORT=${TARGET_PORT:-$2}
LISTEN_PORT=${LISTEN_PORT:-$PORT}

if [ -z ${HOST} ]; then
    echo "Missing environment variables or command line options: target host"
    exit 1
fi
if [ -z ${PORT} ]; then
    echo "Missing environment variables or command line options: target port"
    exit 1
fi
if [ -z ${LISTEN_PORT} ]; then
    echo "Missing environment variables or command line options: listen port"
    exit 1
fi

echo "relay TCP/IP connections on :${LISTEN_PORT} to ${HOST}:${PORT}"
exec socat TCP-LISTEN:${LISTEN_PORT},fork,reuseaddr TCP:${HOST}:${PORT}
