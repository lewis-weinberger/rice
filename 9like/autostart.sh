#!/bin/bash
# xsetroot script

# Settings
c=grey30  # background colour
t=1       # status refresh interval (seconds)

# Background
xsetroot -solid $c

# Status bar
while true; do
    WIFI="$(iw wlp6s0 station dump | awk '/signal:/{ print $2"dBm" }')"
    CPU="$(mpstat $t 1 | awk '/Average/{ printf("%.1f%"), 100 - $12 }')"
    TIME="$(date +"%H:%M:%S")"
    DATE="$(date +"%d/%m/%Y")"
    MEM="$(free | awk '/Mem/{ printf("%.1f%"), (1.0 - $7/$2) * 100.0 }')"
    BAT="$(acpitool | awk '/Battery/{ print $4" "$5 }')"
    xsetroot -name "cpu $CPU | mem $MEM | net $WIFI | bat $BAT | $TIME | $DATE"
done &
