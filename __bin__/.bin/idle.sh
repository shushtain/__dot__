#!/usr/bin/env bash

mark="$1"
mode="$2"

case "$mark" in
"dim")
    if [[ "$mode" == "in" ]]; then
        brightnessctl -s
        backlight.sh "idle"
    else
        brightnessctl -r
    fi
    ;;
"lock")
    if [[ "$mode" == "in" ]]; then
        pidof hyprlock || hyprlock
    fi
    ;;
"off")
    if [[ "$mode" == "in" ]]; then
        bat_s="$(cat /sys/class/power_supply/BAT*/status)"
        if [[ "$bat_s" != "Charging" ]]; then
            hyprctl dispatch dpms off
        fi
    fi
    ;;
"sleep")
    if [[ "$mode" == "in" ]]; then
        bat_s="$(cat /sys/class/power_supply/BAT*/status)"
        if [[ "$bat_s" != "Charging" ]]; then
            pidof hyprlock || hyprlock
            systemctl suspend-then-hibernate
        fi
    fi
    ;;
*)
    dunstify -u critical -a user "idle.sh" "[$mark] is not supported as time mark."
    exit 1
    ;;
esac
