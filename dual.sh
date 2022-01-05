#!/bin/bash

# TODO: change this script to accept params of monitor and calculate values
# HDMI-1 connected primary 2560x1440+0+0 (normal left inverted right x axis y axis) 708mm x 399mm

DISPLAY=${1:-HDMI-1}

WIDTH_PX=${2:-1280}
WIDTH_MM=${3:-354}
WIDTH_MM_2=${3:-355}

xrandr \
  --setmonitor "$DISPLAY-1" \
  "$WIDTH_PX/${WIDTH_MM}x${WIDTH_PX}/1+0+0" \
  "$DISPLAY"

xrandr \
  --setmonitor "$DISPLAY-2" \
  "$WIDTH_PX/${WIDTH_MM_2}x${WIDTH_PX}/1+${${WIDTH_PX}}+0" \
  none

# xrandr --delmonitor HDMI-1-1
# xrandr --delmonitor HDMI-1-2
