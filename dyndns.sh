#!/bin/bash

UPDATE_URL="$1"
UPDATE_SECRET="$2"
SUBDOMAIN="$3"
IP_TYPE="${4:-external}"

if [[ "$IP_TYPE" == "external" ]]; then
  MY_IP=$(curl -s https://myexternalip.com/raw)
else
  MY_IP=$(hostname -I | awk '{print $1}')
fi

curl -s -L "$UPDATE_URL?secret=$UPDATE_SECRET&domain=$SUBDOMAIN&addr=$MY_IP"
