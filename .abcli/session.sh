#! /usr/bin/env bash

function blue_worker_session() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ "$task" == "start" ] ; then
        abcli_log "blue-worker: session started ..."

        local worker_name
        for worker_name in $abcli_path_git/blue-worker/.abcli/workers/*.sh ; do
            source $worker_name
        done

        local tags="work,~started,~completed"
        if [ "$(abcli_cookie read gpu 0)" == "1" ] ; then
            local tags="gpu,$tags"
        else
            local tags="$tags,~gpu"
        fi 

        local object=$(abcli_tag search $tags --count 1 --log 0)

        if [ ! -z "$object" ] ; then
            abcli_log "blue-worker started: $object"

            local list_of_tags=$(abcli_tag get $object)
            abcli_tag set $object started

            abcli_select $object
            abcli_download

            if [ "$(abcli_list_in python "$list_of_tags")" == "True" ] ; then
                abcli_script python source
            else
                abcli_script source
            fi

            abcli_tag set $abcli_object_name $list_of_tags,~work
            abcli_tag set $object ~started,completed

            abcli_log "blue-worker: session closed."
        fi

        abcli_select

        return
    fi

    abcli_log_error "-blue-worker: session: $task: command not found."
}