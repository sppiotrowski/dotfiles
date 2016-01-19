export STATS_PATH="$HOME/stats.txt"

.confirm() {
    local ANSWER="${1:-y}"
    local MSG="${2:-'are you sure?'}"
    local ANSWER_LOWER=$(echo "$ANSWER" | awk '{print tolower($0)}')
    local ANSWER_UPPER=$(echo "$ANSWER" | awk '{print toupper($0)}')
    local OPTION="${ANSWER_LOWER}${ANSWER_UPPER}"
    local OTHER_OPTION=$([ "$ANSWER_LOWER" == 'y' ] && echo 'n' || echo 'y')

    read -r -p "$MSG [$ANSWER_UPPER/$OTHER_OPTION] " RESPONSE
    case "$RESPONSE" in
        ["$OTHER_OPTION"])
            return 1
            ;;
        *)
            return 0
            ;;
    esac
}

.stats() {
    # add information about sigle usage to 'stats' file
    # usage: .stats $FUNCNAME
    FUNC="$1"
    if [ -n "$FUNC" ]; then
        # add if not exist
        if [ -z "$(grep "$FUNC" "$STATS_PATH")" ]; then
            echo "${FUNC} 1" >> "$STATS_PATH"
        else
            sed -ri 's/^('"$FUNC"') ([0-9]+)/echo "\1 $((\2 + 1))"/ge' "$STATS_PATH"
        fi
    else
        "$EDITOR" "$STATS_PATH"
    fi

}

.std.error() {
    # usage: .std.error some error description
    # uses: redirection to stderr
    >&2 echo "$*"
}
