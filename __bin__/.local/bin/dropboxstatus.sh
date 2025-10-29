#!/usr/bin/env bash

status="$(dropbox-cli status)"
if [[ $status == "Dropbox isn't running!" ]]; then
    dropbox-cli start
    status="Starting"
fi
dunstify -t 1000 -r 8080 -u low "Dropbox" "$status"
