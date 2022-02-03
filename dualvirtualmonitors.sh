#!/bin/bash

# TODO: change this script to accept params of monitor and calculate values
# HDMI-1 connected primary 2560x1440+0+0 (normal left inverted right x axis y axis) 708mm x 399mm

set -e

COMMAND=$1
DISPLAY=${2:-DP-2}

HEIGHT_PX="1440"
WIDTH_PX="1280"
WIDTH_MM="354"
WIDTH_MM_2="355"

if [[ "$COMMAND" == "add" ]]; then
  cat <<EOF
xrandr \
  --setmonitor "${DISPLAY}-1" \
  "$WIDTH_PX/${WIDTH_MM}x${HEIGHT_PX}/399+0+0" \
  "$DISPLAY"
xrandr \
  --setmonitor "${DISPLAY}-2" \
  "$WIDTH_PX/${WIDTH_MM_2}x${HEIGHT_PX}/399+$WIDTH_PX+0" \
  none
EOF
else
  cat <<EOF
xrandr --delmonitor "${DISPLAY}-1"
xrandr --delmonitor "${DISPLAY}-2"
EOF
fi

i3-msg restart
