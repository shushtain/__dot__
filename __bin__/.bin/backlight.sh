#!/usr/bin/env bash

mode="$1"
max=64530
min=0
idle_p=20
eco_p=60

cur="$(brightnessctl get)"
step="$((max / 5))"
battery="$((max * eco_p / 100))"
idle="$((max * idle_p / 100))"

case "$mode" in
"up") cur="$((cur + step))" ;;
"down") cur="$((cur - step))" ;;
"max") cur="$max" ;;
"min") cur="$min" ;;
"eco") cur="$battery" ;;
"idle") cur="$idle" ;;
"battery")
    if [[ "$cur" -gt "$battery" ]]; then
        cur="$battery"
    fi
    ;;
*)
    dunstify -u critical "backlight.sh" "[$mode] is not supported as mode."
    exit 1
    ;;
esac

if [[ "$cur" -gt "$max" ]]; then
    cur="$max"
elif [[ "$cur" -lt "$min" ]]; then
    cur="$min"
fi

brightnessctl set "$cur"
value="$((cur * 100 / max))"
dunstify -t 1000 -r 8080 -u low "ω$value"
