#!/usr/bin/env bash

hyprctl switchxkblayout at-translated-set-2-keyboard next
layout="$(hyprctl devices -j | jq -r '.keyboards[].active_keymap' | sort | tail -n1)"
dunstify -t 1000 -r 8080 -u low "⌨ $layout"
