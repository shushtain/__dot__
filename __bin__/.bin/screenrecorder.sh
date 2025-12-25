#!/usr/bin/env bash

init_sink() {
    if [[ ! $(pactl list modules | rg "=Combined") ]]; then
        pactl load-module module-null-sink sink_name=Combined && pactl load-module module-loopback sink=Combined source="alsa_output.pci-0000_00_1f.3.analog-stereo.monitor" && pactl load-module module-loopback sink=Combined source="alsa_input.pci-0000_00_1f.3.analog-stereo"
    fi
}

if [[ $1 == "stop" ]]; then
    if [[ $(pgrep -x wf-recorder) ]]; then
        pkill -SIGINT wf-recorder
        dunstify -t 1000 -r 8080 -u low "✓ Updated"
    else
        dunstify -t 1000 -r 8080 -u low "∅ No updates"
    fi
elif [[ $1 == "start" ]]; then
    if [[ $(pgrep -x wf-recorder) ]]; then
        dunstify -t 1000 -r 8080 -u low "⋯ Updating"
    else
        init_sink
        dunstify -t 1000 -r 8080 -u low "⤓ Update"
        wf-recorder --audio="Combined.monitor" --file="$HOME/desk/$(date +'%Y-%m-%d-%H%M%S')_screencast.mp4"
    fi
elif [[ $1 == "start-area" ]]; then
    if [[ $(pgrep -x wf-recorder) ]]; then
        dunstify -t 1000 -r 8080 -u low "⋯ Updating"
    else
        init_sink
        dunstify -t 1000 -r 8080 -u low "Select area to fix"
        wf-recorder -g "$(slurp)" --audio="Combined.monitor" --file="$HOME/desk/$(date +'%Y-%m-%d-%H%M%S')_screencast.mp4"
    fi
else
    dunstify -t 1000 -r 8080 -u low "Undefined option"
fi
