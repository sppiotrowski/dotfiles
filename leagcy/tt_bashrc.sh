export TT_ROOT="$HOME/tt_projects"
export TT_HOME="$HOME/.tt"
export TT_TMP='/tmp/tt'
export TT_VENV="$TT_HOME/venv"

export BROWSER=${BROWSER:-google-chrome}
export EDITOR=${EDITOR:-vim}

mkdir -p "$TT_ROOT"
mkdir -p "$TT_TMP"

_confirm() {
    MSG="${1:-'are you sure?'}"
    ANSWER="${2:-y}"
    ANSWER_LOWER=$(echo "$ANSWER" | awk '{print tolower($0)}')
    ANSWER_UPPER=$(echo "$ANSWER" | awk '{print toupper($0)}')
    OPTION="${ANSWER_LOWER}${ANSWER_UPPER}"
    OTHER_OPTION=$([ "$ANSWER_LOWER" = 'y' ] && echo 'n' || echo 'y')

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

.timestamp() {
    echo $(date +%Y.%m.%d:%H:%M:%S)
}

.date() {
    echo $(date +%Y.%m.%d)
}

.projects() {
    PRS="${TT_TMP}/projects"
    if [ -s "$PRS" ]; then 
        cat "$PRS"
    else
        "$TT_VENV"/bin/python "${TT_HOME}/github/api.py" >| "$PRS"
        cat "$PRS"
    fi
}

.project() {
    PROJ_PART="$1"
    PROJS=($(.projects | grep "$PROJ_PART"))
    if [ ${#PROJS[@]} != 1 ]; then
        >&2 echo empty or not unique project
        >&2 echo "$PROJ_PART evaluated to:"
        >&2 printf '%s\n' "${PROJS[@]}"
        return 1
    fi
    echo "$PROJS"
}

.cd() {
  PROJ_PART="$1"
  if [ -z "$PROJ_PART" ]; then
    PROJ_DIR="$TT_ROOT"
  else
    PROJ_NAME=$(.project "$PROJ_PART")
    PROJ_DIR="$TT_ROOT/$PROJ_NAME"
  fi

  if [ ! -d "$PROJ_DIR" ]; then
      if _confirm "not found, clone it?"; then
        .git.clone "$PROJ_NAME"
      else
        return 1
      fi
  fi

  cd "$PROJ_DIR"
}

.git.clone() {
    PROJ_PART="$1"
    PROJ_NAME=$(.project "$PROJ_PART")
    SSH_URL="git@github.com:paulsecret/${PROJ_NAME}.git"
    echo "$SSH_URL"
    $(cd "$TT_ROOT" && git clone "$SSH_URL")
}

.git.pull.all() {
    for PROJ in $(find $TT_ROOT -maxdepth 1 -type d); do
        echo "processing: $PROJ"
        echo $(cd "$PROJ" && [ -d '.git' ] && git pull)
    done;
}

.http() {
   URL="$1"
   nohup "$BROWSER" "$URL" &> /dev/null > /dev/null
}

.jira() {
    TASK_ID_PART="$1"
    if [[ "$TASK_ID_PART" =~ ^[0-9]+ ]]; then
        TASK_ID="TT-${TASK_ID_PART}"
    else
        TASK_ID="${TASK_ID_PART}"
    fi

   .http "https:///browse/$TASK_ID"
}

.github() {
    PROJ_NAME="$1"
    BASE_URL='https://github.com/sppiotrowski'
    if [ -z "$PROJ_NAME" ]; then
        URL="$BASE_URL"
    else
        APP_NAME=$(.project "$PROJ_NAME")
        URL="$BASE_URL/$APP_NAME"
    fi
    .http "$URL"
}


# use python with tt virtualenv
.python.venv() {
    PYTHON_SCRIPT="$*"
    "$TT_VENV/bin/python" -c "$PYTHON_SCRIPT"
}

