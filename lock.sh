#!/bin/bash

WEBCAM_FILE="$(date +%Y%m%d_%H%M%S)-shot.jpeg"

i3lock -i "$WALLPAPER_DIR/92i3mebsma021.png" && sleep 1
streamer -b 32 -o "$WEBCAM_DIR/$WEBCAM_FILE"
