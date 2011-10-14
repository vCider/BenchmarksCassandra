#!/bin/bash
if [ `pgrep java` ]
then 

  ps -o uid,pid,lstart -p $(pgrep java) |
    tail -n+2 |
    while read PROC_UID PROC_PID PROC_LSTART; do
        SECONDS=$[$(date +%s) - $(date -d"$PROC_LSTART" +%s)]
        if [ $PROC_UID -eq 0 -a $SECONDS -gt 90 ]; then
            echo $PROC_PID
        fi
     done 
fi