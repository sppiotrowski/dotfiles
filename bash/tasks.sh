export TODO_PATH="$HOME/todo.txt"
export TASK_PATH="$HOME/task.txt"
export DIARY_PATH="$HOME/diary.txt"

.diary() {
    vim "$DIARY_PATH"
}

.todo() {
    TODO="$*"
    if [ -z "$TODO" ]; then
        vim "$TODO_PATH"
    else
        sed -i '1s/^/# '"$TODO"'\n/' "$TODO_PATH"
    fi
}

.task() {
    vim "$TASK_PATH"
}

.task.key() {
    KEY_PART="$1"
    if [ -z "$KEY_PART" ]; then
        # get a key of a last task
        grep -E 'TT-[0-9]+' $TASK_PATH | head -n 1 | sed -E 's/[# ]+//' | awk {' print $1 '}
    else
        # TODO: grep for given key
        return 1
    fi
}
alias .tkey=.task.key

.task.short() {
    # get a key and title  of a last task
    grep -E 'TT-[0-9]+' $TASK_PATH | head -n 1 | sed 's/^# //'
}
alias .tshort=.task.short

.task.entire() {
    # get the entire last task 
    # grep -E 'TT-[0-9]+' $TASK_PATH | head -n 1 | sed -E 's/[# ]+//' | awk {' print $1 '}
    .std.error 'vader dying: nooooo...'
    return 1
}
alias .tentire=.task.entire

.task.jira() {
    TASK_KEY=$(.task.key "$@")
    if [ $? -eq 0 ]; then
        .jira "$TASK_KEY"
    else
        .std.error 'task not found'
        return 1
    fi
}
alias .tjira=.task.jira

.task.last() {
    local TASK=$(.task.get $@)
    if [ ! -z "$TASK" ]; then
        # move task description to arch file
        cat "$TASK_PATH" | sed -n '/[#\s]*'"$TASK"'/,/[#\s]*TT-/p' | sed '$ d'
    else
        echo "task notkfound: $TASK"
    fi
}
alias .tlast=.task.arch
