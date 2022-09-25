#! /usr/bin/env bash

function abcli_job() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ "$task" == "help" ] ; then
        abcli_show_usage "abcli job <job-name> completed" \
            "register that          <job-name> completed."
        abcli_show_usage "abcli job <job-name> started" \
            "register that          <job-name> started."
        abcli_show_usage "abcli job remove        <tag_1,tag_2>" \
            "remove jobs that are tagged          <tag_1,tag_2>."
        abcli_show_usage "abcli job search        <tag_1,tag_2>" \
            "search for jobs that are tagged      <tag_1,tag_2>."
        abcli_show_usage "abcli job submit        <tag_1,tag_2>        <command-line>" \
            "submit a job with tags               <tag_1,tag_2> to run <command-line>."
        return
    fi

    local tags=$2

    if [ "$task" == "remove" ] ; then
        abcli_tag set \
            $(abcli_tag search job,~started,~completed,$tags) \
            completed,removed
        return
    fi

    if [ "$task" == "search" ] ; then
        abcli_tag search \
            job,~started,~completed,$tags \
            ${@:3}
        return
    fi

    if [ "$task" == "submit" ] ; then
        local command="${@:3}"

        abcli_log "submitting job($tags): ${command}"

        local abcli_object_name_current=$abcli_object_name

        abcli_select - ~trail

        local filename=$abcli_object_folder/script.sh
        echo "#! /usr/bin/env bash" > $filename
        echo "" >> $filename
        echo "abcli_select" >> $filename
        echo "$command" >> $filename

        abcli_upload open

        abcli_tag set \
            $abcli_object_name\
            job,$tags

        abcli_select $abcli_object_name_current

        return
    fi

    local job_name=$(abcli_clarify_object $1 .)
    local task=$(abcli_unpack_keyword $2 void)

    if [ "$task" == "completed" ] ; then
        abcli_tag set \
            "$job_name" \
            completed,~started
        return
    fi
    
    if [ "$task" == "started" ] ; then
        abcli_tag set \
            "$job_name" \
            started
        return
    fi

    abcli_log_error "-abcli: job: $task: command not found."
}