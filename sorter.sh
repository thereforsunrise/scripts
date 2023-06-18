#!/bin/bash

docker run \
  --mount source=sorter,target=/app \
  -e FASTMAIL_EMAIL=$FASTMAIL_EMAIL \
  -e FASTMAIL_PASS=$FASTMAIL_PASS \
  zaargy/braindump-sorter:latest
