#!/usr/bin/env bash

path=${1#file://}
exec nvim "$path"
