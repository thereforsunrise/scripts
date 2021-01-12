#!/bin/bash

[ "$1" == "up" ] && amixer -D pulse sset Master 1%+
[ "$1" == "down" ] && amixer -D pulse sset Master 1%-
