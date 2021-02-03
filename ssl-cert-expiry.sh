#!/bin/bash

unique=`date +"%Y-%m-%d-%T"`
port=443

while read line ; do

    if ! host $line | grep platform &>/dev/null; then
        echo "domain $line is not on platform lb"
        continue
    fi

    res=`echo | timeout 5 openssl s_client -connect "$line:$port" -servername $line 2>/dev/null | openssl x509 -noout -subject -dates 2>/dev/null|sed -e 's/^subject.*CN=\([a-zA-Z0-9\.\-\*]*\).*$/\1/' `

    subject=`echo $res|cut -d" " -f1`
    dateaft=`echo $res|cut -d"=" -f3`
    cert=`date --date="$dateaft" +%s`
    now=`date +%s`
    echo "$unique;$line;$port;$subject;$(((cert-now)/86400));$dateaft"

done <$1
