#!/usr/bin/env bash

hyprctl dispatch movetoworkspacesilent "$1"
# dunstify -t 1000 -r 8080 -u low "⋅$1⋅"
