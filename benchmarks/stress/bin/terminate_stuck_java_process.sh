#!/bin/bash

#Check if Java Process Exists. Continue only if affirmative. 
if [ `pgrep java` ]
then 

  ps -o uid,pid,lstart -p $(pgrep java) |
    tail -n+2 |
    while read PROC_UID PROC_PID PROC_LSTART; do
        SECONDS=$[$(date +%s) - $(date -d"$PROC_LSTART" +%s)]
        if [ $PROC_UID -eq 0 -a $SECONDS -gt 600 ]; then
            echo $PROC_PID
	    kill $PROC_PID
        fi
     done  
     
fi