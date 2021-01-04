#!/bin/bash


for e in ~/.config/i3/wd_*; do echo -n "$e: "; cat $e; done
