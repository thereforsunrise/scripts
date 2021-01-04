#!/bin/bash

docker run \
  -v "$HOME/.msmtprc:/root/.msmtprc:ro" \
  -v "$HOME/.msmtpqueue:/root/.msmtpqueue" \
zaargy/msmtp msmtp-runqueue.sh

