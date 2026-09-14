#!/usr/bin/env bash

mode="$1"
name="$(date +'%Y-%m-%d-%H-%M-%S-%3N').png"
dir="$XDG_DESKTOP_DIR"

case "$mode" in
"screen")
    hyprshot --mode active --mode output -s -o "$dir" -f "$name"
    ;;
"window")
    hyprshot --mode active --mode window -s -o "$dir" -f "$name"
    ;;
"area")
    hyprshot --mode region --freeze -s -o "$dir" -f "$name"
    ;;
*)
    dunstify -u critical -a user "screenshot.sh" "[$mode] is not supported as mode."
    exit 1
    ;;
esac
