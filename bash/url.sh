export BROWSER='google-chrome'

.url() {
    # uses linux process control toolset: jobs, bg, fg, ps, kill
    # uses subshell to hide bg output: $()
    $($BROWSER "$*" </dev/null &>/dev/null &)
}

.url.status() {
    local URL="$1"
    curl -I -s "$URL" | head -n1 | awk {'print $2'}
}

.url.doc.grails() {
   .url "site:https://grails.github.io/grails-doc/2.3.x/ $@"
}
