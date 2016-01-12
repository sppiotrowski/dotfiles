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

.url.translate() {
    TO_TRANS="$*"
    .url 'https://translate.google.com/#pl/en/'"$TO_TRANS"
}
alias .translate=.url.translate

.url.translate.enpl() {
    TO_TRANS="$*"
    .url 'https://translate.google.com/#en/en/'"$TO_TRANS"
}

.url.daily() {
    .url 'https://mail.google.com/mail/u/0/#inbox'
    .url 'https://outfittery.slack.com/messages/theta-team'
    .url 'https://www.facebook.com'

}
