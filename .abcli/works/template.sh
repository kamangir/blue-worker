#! /usr/bin/env bash

function blue_worker_template() {
    abcli_log "blue_worker: template: started ..."

    local some_work="abc"

    if [ -z "$some_work" ] ; then
        abcli_log "blue_worker: template: found no work."
    else
        abcli_log "blue_worker: template: starting $some_work ..."

        $command

        abcli_log "blue_worker: template: completed."
    fi
}

# blue_worker_template