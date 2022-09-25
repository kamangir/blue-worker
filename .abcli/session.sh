#! /usr/bin/env bash

function blue_worker_session() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ "$task" == "start" ] ; then
        abcli_log "blue-worker: session started."

        local work_name
        for work_name in $abcli_path_git/blue-worker/.abcli/works/*.sh ; do
            source $work_name
        done

        abcli_log "blue-worker: session ended."

        return
    fi

    abcli_log_error "-blue-worker: session: $task: command not found."
}