#!/bin/bash

find "$WALLPAPER_DIR" -maxdepth 1 -type f | \
  sort -R | tail -1 | \
while read -r file; do
  echo "Setting wallpaper to $file..."
  feh --bg-fill "$WALLPAPER_DIR/polygon-mountains-minimalist-r3.jpg" &
done
