#!/usr/bin/env bash

state="/tmp/__discharge"
bat_c="$(cat /sys/class/power_supply/BAT*/capacity)"
bat_s="$(cat /sys/class/power_supply/BAT*/status)"

if [[ "$bat_s" == "Charging" || "$bat_s" == "Full" ]]; then
    rm -f "$state"
    if [[ "$(hyprshade current)" == "critical" ]]; then
        hyprshade off
    fi
    exit 0
fi

if [[ "$bat_c" -le 10 ]]; then
    if [[ "$(hyprshade current)" != "critical" ]]; then
        hyprshade on critical
    fi
fi

if [[ "$bat_c" -le 20 ]]; then
    if [[ ! -f "$state" ]]; then
        touch "$state"
        dunstify -u critical -a user "$bat_c% left"
    fi
fi
