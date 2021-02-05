#!/bin/bash

(
  cd "$SCREENSHOT_DIR"
  scrot '%Y-%m-%d-%s_screenshot_$wx$h.jpg'
)
