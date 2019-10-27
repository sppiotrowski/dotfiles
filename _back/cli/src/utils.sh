#!/usr/bin/env bash

.util.date() {
  date +%Y.%m.%d # | tee /dev/tty | clip_copy
}

.util.thinker() {
  echo "🤔" # | tee /dev/tty | clip_copy
}
alias .thinker='.util.thinker'

.util.email() {
  echo "spp.$(date +%Y.%m.%d.%H.%M)@test.de" # | tee /dev/tty | clip_copy
}

.util.replace() {
  KEY="$1"; shift
  VAL="$1"; shift
  FILE="$*"
  sed -i '' -e  s/"${KEY}"/"${VAL}"/ "$FILE"
}
