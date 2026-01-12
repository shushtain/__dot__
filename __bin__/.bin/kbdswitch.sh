#!/usr/bin/env bash

device="at-translated-set-2-keyboard"
index="${1:-next}"

hyprctl switchxkblayout $device "$index"
if [[ $2 != "silent" ]]; then
    layout=$(hyprctl devices -j | jq -r ".keyboards[] | select(.name == \"$device\") | .active_keymap")
    layout="${layout% (Shush)}" # (*
    dunstify -t 500 -r 8080 -u low "⌨ $layout"
fi
