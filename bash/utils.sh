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

# TODO: apply stats for each one bash function
.stats() {
    # usage: .stats $FUNCNAME
    FUNC="$1"
    # TODO: update existing
    # http://stackoverflow.com/questions/2464760/modify-config-file-using-bash-script
    echo "$FUNC" >> "$STATS_PATH"

}

.std.error() {
    # usage: .std.error some error description
    # uses: redirection to stderr
    >&2 echo "$*"
}
