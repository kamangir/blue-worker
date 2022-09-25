#! /usr/bin/env bash

function blue_worker_jobs() {
    abcli_log "blue_worker: jobs: started."

    local tags="~gpu"
    if [ "$(abcli_cookie read gpu 0)" == 1 ] ; then
        local tags="gpu"
    fi 
    local job_name=$(abcli_job search $tags --count 1 --delim , --log 0)

    if [ ! -z "$job_name" ] ; then
        abcli_log "blue-worker: jobs: started $job_name."

        local list_of_tags=$(abcli_tag get $job_name --delim , --log 0)

        abcli_job $job_name started

        abcli_select $job_name
        abcli_download

        if [ "$(abcli_list_in python "$list_of_tags")" == "True" ] ; then
            abcli_script python source
        else
            abcli_script source
        fi

        abcli_tag set \
            $abcli_object_name \
            $list_of_tags,~job,job_output

        abcli_job $job_name completed
    fi

    abcli_log "blue_worker: jobs: completed."
}

blue_worker_jobs