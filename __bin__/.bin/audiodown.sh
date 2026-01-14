#!/usr/bin/env bash

status="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | choose 2)"
if [[ $status == "[MUTED]" ]]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
fi

wpctl set-volume @DEFAULT_AUDIO_SINK@ 4%-
volume="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')"
dunstify -t 1000 -r 8080 -u low "#$volume"
