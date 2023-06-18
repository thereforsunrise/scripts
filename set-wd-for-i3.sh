#!/bin/bash

active_ws=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num' | cut -d\" -f2)
wd_file="$HOME/.config/i3/wd_$active_ws"
ws=$(pwd)

while [ -n "$ws" ]; do
  echo "$ws" > "$wd_file"
  [[ "$ws" == "rm" ]] && rm -f "$wd_file"
  exit
done
