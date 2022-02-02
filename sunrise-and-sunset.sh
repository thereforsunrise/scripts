#!/bin/bash

t=$(mktemp)

ip="$(curl -s https://ipinfo.io/ip)"

curl \
  -s "https://json.geoiplookup.io/$ip" > "$t"

longitude=$(cat "$t" | jq '.longitude')
latitude=$(cat "$t" | jq '.latitude')

curl \
  -s "https://api.sunrise-sunset.org/json?lat=$latitude&lng=$longitude&date=today" | jq '.results'
