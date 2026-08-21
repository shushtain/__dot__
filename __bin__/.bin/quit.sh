#!/usr/bin/env bash

mode="$1"
wins="$(hyprctl -j clients | jq -c ".[]" | wc -l)"

if [[ $wins == 0 ]]; then
    busy="$(insync status | tail -1)"
    if [[ $busy == "Sync status: SYNCED" ]]; then
        case "$mode" in
        "logout") loginctl terminate-user "" ;;
        "poweroff") systemctl poweroff ;;
        "reboot") systemctl reboot ;;
        *) dunstify -u critical "quit.sh" "[$mode] is not supported as mode." ;;
        esac
    elif [[ $busy == "Insync doesn't seem to be running. Start it first." ]]; then
        dunstify -t 3000 -r 8080 -u low "Insync" "Starting."
        insync start
    else
        dunstify -t 3000 -r 8080 -u low "Insync" "$busy"
    fi
elif [[ $wins == 1 ]]; then
    dunstify -t 1000 -r 8080 -u low "Close $wins window"
else
    dunstify -t 1000 -r 8080 -u low "Close $wins windows"
fi
