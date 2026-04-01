#!/usr/bin/env bash

stat=$(cat /sys/class/rfkill/rfkill2/soft)
if [[ $stat == "1" ]]; then
    stat="on"
else
    stat="off"
fi
rfkill toggle bluetooth
dunstify -t 1000 -r 8080 -u low "Bluetooth" "$stat"
