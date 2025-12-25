#!/usr/bin/env bash

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
status="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{print $3}')"
if [[ $status == "[MUTED]" ]]; then
    dunstify -t 1000 -r 8080 -u low "󰍭 Off"
else
    dunstify -t 1000 -r 8080 -u low "󰍬 On"
fi
