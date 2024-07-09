#!/bin/bash

URL="http://localhost"
LOG_FILE="$HOME/nginx_monitor.log"
SUCCESS_CODE=200
CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")
HTTP_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" $URL)

if [ "$HTTP_RESPONSE" -eq "$SUCCESS_CODE" ]; then
    echo "$CURRENT_TIME - Nginx is up. HTTP Response: $HTTP_RESPONSE" >> $LOG_FILE
else
    echo "$CURRENT_TIME - Nginx is down or returned an unexpected response. HTTP Response: $HTTP_RESPONSE" >> $LOG_FILE
fi
