#!/usr/bin/env bash

FILE="$1"

if [ -z "$FILE" ]; then
  echo "usage: ./$(basename "$0") FILE"
  exit 1
fi

# -E       > improved Ex mode
# -N       > no compatible
# -n       > no swapfile
# -s       > silent
# -u NONE  > no plugin

# EOF      > bash here-document
# :        > vim commands

vim -ENns -u NONE "$FILE" <<EOF
:1;/defineMessages(/ d
:0r !awk '/TS1/{flag=1;next}/TE1/{flag=0}flag' ./template.vim
:$ | put=''
:r !awk '/TS2/{flag=1;next}/TE2/{flag=0}flag' ./template.vim
:x
EOF
