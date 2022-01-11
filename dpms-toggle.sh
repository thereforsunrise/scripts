#!/bin/bash

status=$(xset q | grep 'Monitor is' | awk '{$1=$1;print}' | cut -f3 -d" ")

if [[ "$status" == "On" ]]; then
  xset dpms force off
else
  xset dpms force on
fi
