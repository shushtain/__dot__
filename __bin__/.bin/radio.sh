#!/usr/bin/env bash

fpid="/tmp/radio.pid"
fsta="/tmp/radio.sta"

notify() {
    dunstify -t 1000 -r 8080 "Radio" "$1"
}

if [[ $1 == "check" ]]; then
    if [[ -f "$fsta" ]]; then
        notify "$(cat $fsta)"
    else
        notify "off"
    fi
    exit 0
fi

sp_stop="= STOP ="
sp_rand="= RAND ="

if [[ $1 == "stop" ]]; then
    station="$sp_stop"
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
        station="$sp_rand"
    else
        station=$(
            printf "%s\n" "$sp_rand" "${!stations[@]}" "$sp_stop" | fuzzel --dmenu
        )
    fi
fi

[[ -z "$station" ]] && exit 1

if [[ -f "$fpid" ]]; then
    kill "$(cat "$fpid")" 2>/dev/null
    rm "$fpid"
    rm "$fsta"
fi

if [[ "$station" == "$sp_stop" ]]; then
    notify "off"
fi

case "$station" in
"$sp_stop") exit 0 ;;
"$sp_rand")
    keys=("${!stations[@]}")
    rand="$((RANDOM % ${#keys[@]}))"
    station="${keys[$rand]}"
    url="${stations[$station]}"
    ;;
*) url="${stations[$station]}" ;;
esac

if [[ -n "$url" ]]; then
    notify "$station"
    echo "$station" >"$fsta"
    mpv --no-video --volume=50 "$url" &
    echo "$!" >"$fpid"
    disown
else
    notify "station not found"
fi
