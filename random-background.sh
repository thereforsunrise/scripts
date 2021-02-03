#!/bin/bash

find "$WALLPAPER_DIR" -maxdepth 1 -type f | \
  sort -R | tail -1 | \
while read file; do
  echo "Setting wallpaper to $file..."
  # feh --bg-fill "$file" &
  feh --bg-fill "$WALLPAPER_DIR/abstract-fractal-desktop-b1-2560x1440.jpg" &
done
