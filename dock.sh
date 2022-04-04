#!/bin/bash
# just a script so i remember a bunch of xrandr commands

mode="${1:-office}"

studio() {
  xrandr \
    --output LVDS-1 --auto \
    --left-of HDMI-1 --primary
}

studiomainonly() {
  xrandr \
    --output LVDS-1 --off \
    --output HDMI-1 --primary
}

office() {
  local display=$(xrandr | grep ^DP | grep ' connected' | awk '{ print $1 }')

  xrandr \
     --output eDP-1 --off \
     --output "$display" --primary
}

officeboth() {
  local display=$(xrandr | grep ^DP | grep ' connected' | awk '{ print $1 }')

  xrandr \
     --output eDP-1 --auto \
     --below "$display" --primary
}


x230only() {
    xrandr \
    --output LVDS-1 --auto --primary \
    --output HDMI-1 --off
}

x1only() {
  xrandr \
    --output eDP-1-1 --auto --primary \
    --output HDMI-1 --off
}

eval "$mode"

i3-msg restart
