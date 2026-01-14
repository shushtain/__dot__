#!/usr/bin/env bash

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
status="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | choose 2)"
if [[ $status == "[MUTED]" ]]; then
    dunstify -t 1000 -r 8080 -u low "󰍭 off"
else
    dunstify -t 1000 -r 8080 -u low "󰍬 on"
fi
