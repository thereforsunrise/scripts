#!/bin/bash

external_display_connected=$(xrandr | grep ^DP | grep ' connected' | awk '{ print $1 }')
external_display_primary=$(xrandr | grep ^DP | grep primary | awk '{ print $3 }')

if [[ -n "$display" ]]; then
  if [[-n "$external_display_primary" ]]; then
    echo "here"
    xrandr \
      --output eDP-1 --off \
      --output "$display" --auto --primary
    i3-msg restart
  fi
else
  xrandr \
    --output eDP-1 --auto --primary \
    --output "$display" --off
    i3-msg restart
fi
