#!/usr/bin/env bash

hyprctl dispatch movetoworkspace "$1"
new="$(hyprctl -j activeworkspace | jq -r .name)"
dunstify -t 1000 -r 8080 -u low "⋅$new⋅"
