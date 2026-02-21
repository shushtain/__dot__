#!/usr/bin/env bash

# TODO:
# mpv http://stream-uk1.radioparadise.com/aac-320 --volume=50

if ! killall mpv; then
    radio-cli -s lofi
fi
