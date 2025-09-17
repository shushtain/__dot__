#!/usr/bin/env bash

wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
status="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')"
if [[ $status == "[MUTED]" ]]; then
    dunstify -t 1000 -r 8080 -u low "#--"
else
    volume="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')"
    dunstify -t 1000 -r 8080 -u low "#$volume"
fi
