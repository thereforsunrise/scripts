#!/bin/bash


headphones_sink="alsa_output.usb-0c76_USB_PnP_Audio_Device-00.analog-stereo"
speakers_sink="alsa_output.pci-0000_2a_00.3.analog-stereo"

new_sink=""
current_sink=$(pactl info | grep -i 'Default Sink:' | awk '{ print $3 }')

if [[ "$current_sink" == "$headphones_sink" ]]; then
  new_sink="$speakers_sink"
else
  new_sink="$headphones_sink"
fi

notify-send -t 2000 "Audio output" "Set to $new_sink"

pacmd set-default-sink "$new_sink"

pacmd list-sink-inputs | \
  grep index | \
  \
  while read -r line; do
    echo "Moving input: ";
    echo "$line" | cut -f2 -d' ';
    echo "to sink: $new_sink";
    pacmd move-sink-input "$(echo "$line" | cut -f2 -d' ')" "$new_sink"
  done
