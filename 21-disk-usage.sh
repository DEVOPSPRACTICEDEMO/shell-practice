#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)
DISK_THRESHOLD=1  # in projects it will be 75

while IFS=read line
do 
    USAGE=$(echo $line | awk '{print $6F}' | cut -d "%" -f1)
    PARTITION=$(echo $line |awk '{print $7F}')
    echo "$PARTITION usage is $USAGE%"
done <<< $DISK_USAGE