#!/usr/bin/env bash

sp_stop="= STOP ="
sp_rand="= RAND ="

if [[ $1 == "stop" ]]; then
    choice="$sp_stop"
else
    declare -A stations
    stations["0R Lofi"]="https://0nlineradio.radioho.st/0r-lo-fi?ref=radio-browser26"
    stations["Chill Lofi"]="http://rdstream-0625.dez.ovh:8000/radio.mp3"
    stations["Classic Vinyl"]="https://icecast.walmradio.com:8443/classic"
    stations["Domes FM"]="http://icecast.bidstonobservatory.org:8000/stream.m3u"
    stations["Hromadske"]="http://5.9.8.20:8000/stream"
    stations["Lofi 24/7"]="http://usa9.fastcast4u.com/proxy/jamz?mp=/1"
    stations["Afrobeats"]="https://stream.zeno.fm/34vsiqt1kaktv"
    stations["Paradise"]="http://stream-uk1.radioparadise.com/aac-320"

    if [[ $1 == "random" ]]; then
        choice="$sp_rand"
    else
        choice=$(
            printf "%s\n" "$sp_rand" "${!stations[@]}" "$sp_stop" | fuzzel --dmenu
        )
    fi
fi

[[ -z "$choice" ]] && exit 1

fpid="/tmp/radio.pid"
if [[ -f "$fpid" ]]; then
    kill "$(cat "$fpid")" 2>/dev/null
    rm "$fpid"
fi

if [[ "$choice" == "$sp_stop" ]]; then
    dunstify -t 1000 -r 8080 "Radio" "off"
fi

case "$choice" in
"$sp_stop") exit 0 ;;
"$sp_rand")
    keys=("${!stations[@]}")
    rand="$((RANDOM % ${#keys[@]}))"
    choice="${keys[$rand]}"
    station="${stations[$choice]}"
    ;;
*) station="${stations[$choice]}" ;;
esac

if [[ -n "$station" ]]; then
    dunstify -t 1000 -r 8080 "Radio" "$choice"
    mpv --no-video --volume=50 "$station" &
    echo "$!" >"$fpid"
    disown
else
    dunstify -t 1000 -r 8080 "Radio" "station not found"
fi
