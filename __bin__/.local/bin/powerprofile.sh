#!/usr/bin/env bash

new="power-saver"
sym="□"

case "$(powerprofilesctl get)" in
"power-saver")
    new="balanced"
    sym="◪"
    ;;
"balanced")
    new="performance"
    sym="■"
    ;;
*) ;;
esac

powerprofilesctl set "$new"
dunstify -t 1000 -r 8080 -u low "$sym $new"
