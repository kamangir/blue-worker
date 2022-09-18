#! /usr/bin/env bash

function abcli_job() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ "$task" == "help" ] ; then
        abcli_show_usage "abcli job <job-name> completed <operation>" \
            "register that <job-name> completed <operation>."
        abcli_show_usage "abcli job count <operation> <tag_1,tag_2>" \
            "count number of jobs for <operation> given <tag_1,tag_2>."
        abcli_show_usage "abcli job find  <operation> <tag_1,tag_2>" \
            "find a job           for <operation> given <tag_1,tag_2>."
        abcli_show_usage "abcli job <job-name> started   <operation>" \
            "register that <job-name> started   <operation>."
        return
    fi

    local operation=$(abcli_clarify_input $2 processing)
    local tags=$3

    if [ "$task" == "count" ] ; then
        local tags="$tags,~started_$operation,~completed_$operation"
        abcli_tag search $tags --show_count 1
        return
    fi

    if [ "$task" == "find" ] ; then
        local tags="$tags,~started_$operation,~completed_$operation"
        abcli_tag search $tags --count 1 --raw 1
        return
    fi

    local job_name=$1
    local task=$(abcli_unpack_keyword $2 void)
    local operation=$(abcli_clarify_input $3 processing)

    if [ "$task" == "completed" ] ; then
        abcli_tag set $job_name completed_$operation,~started_$operation
        return
    fi
    
    if [ "$task" == "started" ] ; then
        abcli_tag set $job_name started_$operation
        return
    fi

    abcli_log_error "-abcli: job: $task: command not found."
}