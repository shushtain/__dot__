#!/usr/bin/env bash

mode="$1"
status="$(insync status)"

if [[ $mode == "status" ]]; then
    if [[ $status == "Insync doesn't seem to be running. Start it first." ]]; then
        insync start
        status="Starting."
    fi
    dunstify -t 3000 -r 8080 -u low "Insync" "$status"
else
    dunstify -u critical "sync.sh" "[$mode] is not supported as mode."
fi
