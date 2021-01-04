#!/bin/bash

docker run \
  --user $(id -u):$(id -g) \
  -e HOME=/home/app \
  -w /home/app \
  -v $HOME/.msmtpqueue/:/home/app/.msmtpqueue \
  -v $HOME/.msmtprc:/home/app/.msmtprc \
  zaargy/journal:12 msmtp-runqueue.sh
