#!/usr/bin/env bash

state="/tmp/__time"

if [ -f "$state" ]; then
    bat_c="$(cat /sys/class/power_supply/BAT*/capacity)"
    bat_s="$(cat /sys/class/power_supply/BAT*/status)"
    bat_i="○"
    if [[ "$bat_s" == "Charging" ]]; then
        bat_i="●"
    fi
    dunstify -t 2000 -r 8080 -u low "$(date +'%H:%M')" "$(date +'%y-%m-%d\n%A')\n$bat_i $bat_c%"
else
    dunstify -t 500 -r 8080 -u low "$(date +'%H:%M')"
fi

touch "$state"
(sleep 2 && rm "$state") &
