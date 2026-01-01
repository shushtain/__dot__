#!/usr/bin/env bash

dir="$HOME/.local/share/dmentia/$1"
choice=$(cat "$dir"/* | fuzzel -d)
if [ -n "$choice" ]; then
    symbol=$(echo "$choice" | awk '{print $1}')
    wl-copy -n "$symbol"
    echo -n "$symbol" | wtype -s 100 -
fi
