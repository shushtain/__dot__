#!/usr/bin/env bash

state="/tmp/dunstify_8080"

if [ -f "$state" ]; then
    dunstify -t 2000 -r 8080 -u low "$(date +'%H:%M')" "$(date +'%y-%m-%d\n%A')"
else
    dunstify -t 500 -r 8080 -u low "$(date +'%H:%M')"
fi

touch "$state"
(sleep 2 && rm "$state") &
