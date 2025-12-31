#!/usr/bin/env bash

hyprctl switchxkblayout at-translated-set-2-keyboard next
layout="$(hyprctl devices -j | jq -r '.keyboards[].active_keymap' | sort | tail -n1)"
layout="${layout% (Shush)}"
dunstify -t 500 -r 8080 -u low "⌨ $layout"
