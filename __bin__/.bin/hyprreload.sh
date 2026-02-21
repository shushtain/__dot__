#!/usr/bin/env bash

dunstify -t 5000 -r 8080 -u low "⮌⮎ Hyprland"
{
    cd "$HOME/box/__dot__/" || exit 1
    just all
}
hyprctl reload
# killall -SIGUSR2 waybar
dunstify -t 1000 -r 8080 -u low "⮎⮌ Hyprland"
dropbox-cli start
