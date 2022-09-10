#! /usr/bin/env bash

function blue_worker_session() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ "$task" == "start" ] ; then
        return
    fi

    abcli_log_error "-blue-plugin: session: $task: command not found."
}