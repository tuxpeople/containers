#!/bin/sh

ARGS=""

if [ ! -z "${PORT}" ]; then
    ARGS="${ARGS} \"${PORT}\""
fi

if [ ! -z "${DIRECTORY}" ]; then
    ARGS="${ARGS} --directory \"${DIRECTORY}\""
else
    ARGS="${ARGS} --directory \"/upload\""
fi

if [ ! -z "${MESSAGE}" ]; then
    ARGS="${ARGS} --message \"${MESSAGE}\""
else
    ARGS="${ARGS} --message \"Hi, this is Bob. You can send me a file.\""
fi

if [ ! -z "${PICTURE}" ]; then
    ARGS="${ARGS} --picture \"${PICTURE}\""
else
    ARGS="${ARGS} --picture \"/app/avatar.jpg\""
fi

if [ ! -z "${PUBLISH_FILES}" ]; then
    ARGS="${ARGS} --publish-files"
fi

if [ ! -z "${AUTH}" ]; then
    ARGS="${ARGS} --auth \"${AUTH}\""
fi

if [ ! -z "${SSL}" ]; then
    ARGS="${ARGS} --ssl \"${SSL}\""
fi

if [ ! -z "${SSLKEY}" ]; then
    ARGS="${ARGS} --sslkey \"${SSLKEY}\""
fi

if [ ! -z "${DHPARAMS}" ]; then
    ARGS="${ARGS} --dhparams \"${DHPARAMS}\""
fi

if [ ! -z "${HSTS}" ]; then
    ARGS="${ARGS} --hsts \"${HSTS}\""
fi

if [ ! -z "${CHMOD}" ]; then
    ARGS="${ARGS} --chmod \"${CHMOD}\""
fi

if [ ! -z "${SAVE_CONFIG}" ]; then
    ARGS="${ARGS} --save-config"
fi

if [ ! -z "${DELETE_CONFIG}" ]; then
    ARGS="${ARGS} --delete-config"
fi

if [ ! -z "${CONFIG_FILE}" ]; then
    ARGS="${ARGS} --config-file \"${CONFIG_FILE}\""
fi

echo "${ARGS}"

python3 /app/droopy ${ARGS}
