#!/usr/bin/env bash

grep server "$HOME/.chef/knife.rb" | awk '{ print $2 }' | sed 's/"//g'
