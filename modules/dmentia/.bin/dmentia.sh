#!/usr/bin/env bash

dir="$HOME/.local/share/dmentia/$1"
choice=$(cat "$dir"/* | fuzzel -d)
if [ -n "$choice" ]; then
    symbol=$(choose 0 <<<"$choice")
    wl-copy -n "$symbol"
    echo -n "$symbol" | wtype -s 100 -
fi
