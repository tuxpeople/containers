#!/usr/bin/env bash
# Print the upstream version of an app channel for local builds (Taskfile).
# Uses the same lookup order as get_latest_version() in prepare-matrices.py.

APP="${1}"
CHANNEL="${2}"
APP_DIR="./apps/${APP}"

get_latest_py() {
    python3 -c 'import importlib.util, sys
spec = importlib.util.spec_from_file_location("latest", sys.argv[1])
latest = importlib.util.module_from_spec(spec)
spec.loader.exec_module(latest)
print(latest.get_latest(sys.argv[2]))' "${1}" "${CHANNEL}"
}

if test -f "${APP_DIR}/ci/latest.py"; then
    get_latest_py "${APP_DIR}/ci/latest.py"
elif test -f "${APP_DIR}/ci/latest.sh"; then
    bash "${APP_DIR}/ci/latest.sh" "${CHANNEL}"
elif test -f "${APP_DIR}/${CHANNEL}/latest.py"; then
    get_latest_py "${APP_DIR}/${CHANNEL}/latest.py"
elif test -f "${APP_DIR}/${CHANNEL}/latest.sh"; then
    bash "${APP_DIR}/${CHANNEL}/latest.sh" "${CHANNEL}"
fi
