#!/bin/bash

scrot '%Y-%m-%d-%s_screenshot_$wx$h.jpg' -e "mv $f $SCREENSHOT_DIR"
