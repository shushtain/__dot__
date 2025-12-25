#!/usr/bin/env bash

alacritty --hold -e rqbit download --exit-on-finish -o "$XDG_DESKTOP_DIR" -- "$@"
