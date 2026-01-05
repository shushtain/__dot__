#!/usr/bin/env bash

wl-copy "$*"
dunstify -t 1000 -r 8080 -u low "Opening" "$*"
alacritty -e xdg-open "$*"
