#!/usr/bin/env bash

wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
sink=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
status=$(choose 2 <<<"$sink")
if [[ $status == "[MUTED]" ]]; then
    dunstify -t 1000 -r 8080 -u low "#--"
else
    volume="$(awk '{print $2 * 100}' <<<"$sink")"
    dunstify -t 1000 -r 8080 -u low "#$volume"
fi
