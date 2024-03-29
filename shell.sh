#!/bin/bash

active_ws=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num' | cut -d\" -f2)
wd_file="$HOME/.config/i3/wd_$active_ws"

wd="$HOME"

if [ -f "$wd_file" ]; then
  wd=$(cat "$wd_file")
fi

xfce4-terminal --working-directory="$wd"
