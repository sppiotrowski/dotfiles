#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
case "$(uname -s)" in
    Linux*)     os=linux;;
    Darwin*)    os=osx;;
    *)          os="UNKNOWN"
esac
export OS="$os"
export EDITOR=vim
export BROWSER=chrome
export DOTFILES="$HOME/projects/dotfiles"
export CLI_HOME="$DIR"
SRC="$CLI_HOME/src"

if [ "$OS" == 'linux' ]; then
  alias clip_copy='xclip -selection clipboard'
  alias clip_paste='xclip -o'
elif [ "$OS" == 'osx' ]; then
  alias clip_copy='pbcopy'
  alias clip_paste='pbpaste'
fi

# shellcheck source=src/utils.sh
. "$SRC"/utils.sh
# shellcheck source=src/note.sh
. "$SRC"/note.sh
# shellcheck source=src/git.sh
. "$SRC"/git.sh
# shellcheck source=src/project.sh
. "$SRC"/project.sh
# shellcheck source=src/candidate.sh
. "$SRC"/candidate.sh

.cli.backup() {
  cd "$DOTFILES" && \
  echo "git add"
  git add .
  git commit -m "backup: $(.util.date)" 
  git push origin master
}

.cli.todo() {
  _note.inline "$CLI_HOME/cli.sh" "todo" "$@"
}

NOTES_FILE="$CLI_HOME"/notes.txt
.note() {
  _note.get "$NOTES_FILE" "$@"
}
alias .n=.note

_note_titles() {
  local part="$1"
  grep -e "^## $part*" "$NOTES_FILE" | sed 's/## //' | sort
}

_note_complete() {
  local cmd="${1##*/}"
  local word=${COMP_WORDS[COMP_CWORD]}
  # local line=${COMP_LINE}
  mapfile -t COMPREPLY < <(_note_titles "$word")
}
complete -F _note_complete .note
complete -F _note_complete .n

.note.edit() {
  _note.edit "$NOTES_FILE" "$@"
}

.note.add() {
  _note.add "$NOTES_FILE" "$@"
}
alias .na=.note.add

.note.todo() {
  _note.inline "$CLI_HOME/note.sh" "todo" "$@"
}
