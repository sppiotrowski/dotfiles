export STATS_PATH="$HOME/stats.txt"

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
