#! /usr/bin/env bash

function bp() {
    blue-plugin $@
}

function blue_worker() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ] ; then
        abcli_help_line "abct task_1" \
            "run abct task_1."

        if [ "$(abcli_keyword_is $2 verbose)" == true ] ; then
            python3 -m blue_worker --help
        fi

        return
    fi

    if [[ $(type -t blue_worker_$task) == "function" ]] ; then
        blue_worker_$task ${@:2}
    fi

    if [ "$task" == "task_1" ] ; then
        python3 -m blue_worker \
            task_1 \
            ${@:2}
        return
    fi

    abcli_log_error "-blue_worker: $task: command not found."
}