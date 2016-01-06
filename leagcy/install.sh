#!/usr/bin/env bash

set -e

WORK_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
TT_HOME="$HOME"'/.tt'
TT_TMP='/tmp/tt'
TIMESTAMP=$(date +%Y.%m.%d:%H:%M:%S)

init() {
    [ -d "$TT_TMP" ] && mv "$TT_TMP" "${TT_TMP}.${TIMESTAMP}"
    [ -d "$TT_HOME" ] && mv "$TT_HOME" "${TT_HOME}.${TIMESTAMP}"

    mkdir -p "$TT_HOME"
    mkdir -p "$TT_TMP"

    CMD="cp -r ${WORK_DIR}/* ${TT_HOME}/"
    bash -c "$CMD"
    return 0
}

update_bashrc() {
    CMD=". $TT_HOME/tt_bashrc.sh"
    [ -z "$(cat ${HOME}/.bashrc | grep tt_bashrc.sh)" ] && echo "$CMD" >> "$HOME/.bashrc"
    return 0
}

init && update_bashrc
for SCRIPT in $(find "$TT_HOME" -mindepth 2 -maxdepth 2 -name install.sh); do
    MODULE=$(echo "$SCRIPT" | xargs dirname | xargs basename)
    echo "installing module: $MODULE"
    echo $(cd "${MODULE}" && ./install.sh)
done
