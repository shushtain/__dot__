#!/usr/bin/env bash

hyprctl reload
killall -SIGUSR2 waybar
dunstify -t 1000 -r 8080 -u low "⮎⮌ Hyprland"
