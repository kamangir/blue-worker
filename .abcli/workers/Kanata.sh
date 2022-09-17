#! /usr/bin/env bash

function blue_worker_Kanata() {
    abcli_log "blue_worker: Kanata: started ..."

    local cw_version=$(abcli_Kanata_version)
    local video_id=$(abcli_job find Kanata_worker Kanata_video_id_$cw_version)

    if [ -z "$video_id" ] ; then
        abcli_log "blue_worker: Kanata: found no work."
        return
    fi

    abcli_log "Kanata-worker: $video_id started."

    abcli_job $video_id started Kanata_worker
    abcli_Kanata slice $video_id
    abcli_job $video_id completed Kanata_worker

    abcli_log "blue_worker: Kanata: completed."
}

if [ $(abcli_plugins is_present Kanata) == True ] ; then
    blue_worker_Kanata
fi