#! /usr/bin/env bash

function blue_worker_schedule() {
    abcli_log "blue_worker: schedule: started ..."

    abcli_select

    local has_gpu=$(abcli_cookie read gpu 0)
    local command=$(python3 -m blue_worker \
        scheduled_command \
        --needs_gpu $has_gpu)

    if [ -z "$command" ] ; then
        abcli_log "blue_worker: schedule: found no work."
    else
        abcli_log "blue_worker: schedule: starting $command ..."

        $command

        abcli_log "blue_worker: schedule: completed."
    fi
}

blue_worker_schedule