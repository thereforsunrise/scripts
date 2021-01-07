#!/bin/bash


for e in ~/.config/i3/wd_*; do echo -en "$e\t\t"; cat $e; done
