#!/usr/bin/env bash

brightnessctl s 25%+
cur="$(brightnessctl g)"
max="$(brightnessctl m)"
value=$((cur * 100 / max))
dunstify -t 1000 -r 8080 -u low "⦁$value"
