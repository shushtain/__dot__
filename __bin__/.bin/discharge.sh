#!/usr/bin/env bash

state="/tmp/__discharge"
bat_c="$(cat /sys/class/power_supply/BAT*/capacity)"
bat_s="$(cat /sys/class/power_supply/BAT*/status)"

if [[ "$bat_s" == "Charging" ]]; then
    rm -f "$state"
    if [[ "$(hyprshade current)" == "radical" ]]; then
        hyprshade off
    fi
    exit 0
fi

if [[ "$bat_c" -le 10 && "$bat_s" != "Charging" ]]; then
    if [[ "$(hyprshade current)" != "radical" ]]; then
        hyprshade on radical
    fi
fi

if [[ "$bat_c" -le 20 && "$bat_s" != "Charging" ]]; then
    if [[ ! -f "$state" ]]; then
        touch "$state"
        dunstify -u critical -a user "$bat_c% left"
    fi
fi
