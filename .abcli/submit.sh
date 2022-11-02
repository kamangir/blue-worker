#! /usr/bin/env bash

function abcli_submit() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ "$task" == "help" ] ; then
        abcli_show_usage "abcli submit [tags=<tag_1,tag_2>] <command-line>" \
            "submit <command-line> to worker and [tag it <tag_1,tag_2>]."
        abcli_show_usage "abcli submit wipe" \
            "wipe submitted works."
        return
    fi

    if [ "$task" == "wipe" ] ; then
        abcli_tag set $(abcli tag search work,~completed,~started --log 0) completed,wiped
        return
    fi

    local options=$1
    local tags=$(abcli_option_int "$options" tags "")

    local command="${@:2}"

    abcli_log "-abcli: submitting to worker: $command"

    local current_object=$abcli_object_name

    abcli_select

    echo "#! /usr/bin/env bash" > $abcli_object_path/script.sh
    echo "" >> $abcli_object_path/script.sh
    echo "$command" >> $abcli_object_path/script.sh

    abcli_upload open

    abcli_tag set \
        $abcli_object_name \
        work,$tags

    abcli_select $current_object
}