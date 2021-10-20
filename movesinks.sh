#!/bin/bash

sink="${1:-headphones}"

case "$1" in
  headphones)
    sink="alsa_output.usb-0c76_USB_PnP_Audio_Device-00.analog-stereo"
    ;;
  speakers)
    sink="alsa_output.pci-0000_2a_00.3.analog-stereo"
    ;;
esac

echo "Setting default sink to: $1"

pacmd set-default-sink "$sink"

pacmd list-sink-inputs | \
  grep index | \
  \
  while read -r line; do
    echo "Moving input: ";
    echo "$line" | cut -f2 -d' ';
    echo "to sink: $sink";
    pacmd move-sink-input "$(echo "$line" | cut -f2 -d' ')" "$sink"
  done
