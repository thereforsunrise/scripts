#!/bin/bash

(
  cd "$SCREENSHOT_DIR" || exit
  scrot "%Y-%m-%d-%s_screenshot_\$wx\$h.jpg"
)
