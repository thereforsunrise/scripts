#!/bin/bash

# TODO: change this script to accept params of monitor and calculate values
# HDMI-1 connected primary 2560x1440+0+0 (normal left inverted right x axis y axis) 708mm x 399mm

COMMAND=$1
DISPLAY=${2:-HDMI-1}

WIDTH_PX=${3:-1280}
WIDTH_MM=${4:-354}
WIDTH_MM_2=${5:-355}

if [[ "$COMMAND" == "add" ]]; then
  xrandr \
    --setmonitor "$DISPLAY-1" \
    "$WIDTH_PX/${WIDTH_MM}x${WIDTH_PX}/1+0+0" \
    "$DISPLAY"
    
  xrandr \
    --setmonitor "$DISPLAY-2" \
    "$WIDTH_PX/${WIDTH_MM_2}x${WIDTH_PX}/1+${${WIDTH_PX}}+0" \
    none
else
  xrandr --delmonitor "$DISPLAY-1"
  xrandr --delmonitor "$DISPLAY-2"
fi
