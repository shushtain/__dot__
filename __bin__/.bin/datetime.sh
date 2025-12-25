#!/usr/bin/env bash

dunstify -t 3000 -r 8080 -u low "$(date +'%H:%M')" "$(date +'%Y-%m-%d')\n$(date +'%A')"
