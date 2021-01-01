#!/bin/bash
IFS=$'\n'

i3status -c /home/psz/.i3/i3status.conf | while :
do 
    read line
    
    MOCP=`mocp -Q "%artist - %song (%ct - %tt)"`
    echo "$MOCP |  $line"
done
