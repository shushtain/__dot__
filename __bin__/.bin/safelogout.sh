#!/usr/bin/env bash

status="$(hyprctl -j clients | jq -c ".[]" | wc -l)"
busy="$(dropbox-cli status)"
if [[ $status == 0 ]]; then
    if [[ $busy == "Up to date" ]]; then
        loginctl terminate-user ""
    elif [[ $busy == "Dropbox isn't running!" ]]; then
        dunstify -t 3000 -r 8080 -u low "Starting Dropbox"
        dropbox-cli start
    else
        dunstify -t 3000 -r 8080 -u low "Dropbox" "$busy"
    fi
elif [[ $status == 1 ]]; then
    dunstify -t 1000 -r 8080 -u low "Close $status window"
else
    dunstify -t 1000 -r 8080 -u low "Close $status windows"
fi
