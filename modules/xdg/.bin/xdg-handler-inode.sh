#!/usr/bin/env bash

path=${1#file://}
alacritty -e yazi "$path"
