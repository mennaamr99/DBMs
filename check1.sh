#!/bin/bash

threshold=20
logfile="/c/Users/DELL/Desktop/project.sh/file.sh"
partition='C:'
res=$(df -H | grep -E "$partition" | awk '{sub(/%/, "", $5); print $5}')

for path in $res; do
    if [ "$path" -ge "$threshold" ]; then 
        df -H | grep "$path%" >> "$logfile"
    fi 
done

if [ -s "$logfile" ]; then
  echo "Disk usage is critical" 

fi
