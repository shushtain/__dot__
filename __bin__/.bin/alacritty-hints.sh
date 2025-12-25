#!/usr/bin/env bash

wl-copy "$*"
dunstify -t 1000 -r 8080 -u low "Opening" "$*"

if [[ "$*" == "http"* ]]; then
    xdg-open "$*"
elif [[ "$*" == "file://"* ]]; then
    path="$(echo "$*" | sed 's/file:\/\///')"
    type="$(xdg-mime query filetype "$path")"

    if [[ $type == "inode/directory" ]]; then
        alacritty -e yazi "$path"
    else
        alacritty -e xdg-open "$*"
    fi
else
    alacritty -e xdg-open "$*"
fi
