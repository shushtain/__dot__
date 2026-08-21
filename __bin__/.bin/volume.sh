#!/usr/bin/env bash

mode="$1"

status="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
is_muted="$(echo "$status" | choose 2)"

case "$mode" in
"up")
    if [[ "$is_muted" == "[MUTED]" ]]; then
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    fi
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 4%+
    ;;
"down")
    if [[ "$is_muted" == "[MUTED]" ]]; then
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    fi
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 4%-
    ;;
"mute")
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    ;;
*)
    dunstify -u critical "volume.sh" "[$mode] is not supported as mode."
    exit 1
    ;;
esac

status="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
volume="$(echo "$status" | awk '{print $2 * 100}')"
is_muted="$(echo "$status" | choose 2)"
if [[ "$is_muted" == "[MUTED]" ]]; then
    dunstify -t 1000 -r 8080 -u low "#--"
else
    dunstify -t 1000 -r 8080 -u low "#$volume"
fi
