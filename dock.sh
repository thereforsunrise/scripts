#!/bin/bash

mode="${1:-home}"

home() {
  xrandr \
    --output LVDS-1 --auto \
    --left-of HDMI-1 --primary
}

mainonly() {
  xrandr \
    --output LVDS-1 --off \
    --output HDMI-1 --primary
}

laptop() {
    xrandr \
    --output LVDS-1 --auto --primary \
    --output HDMI-1 --off
}

eval "$mode"

i3-msg restart
