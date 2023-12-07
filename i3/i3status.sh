#!/bin/bash
IFS=$'\n'

i3status -c /home/psz/.i3/i3status.conf | while :
do 
    read line
    WEATH=`cat /tmp/weath.txt`
    GMAIL=`cat /tmp/gmail.txt`
    USEDMEM=`free -m | grep Mem | awk '{printf "%.2f", ($3+$5)/1000}'`
    PRCTMEM=`free -m | grep Mem | awk '{printf "%.1f", (($3+$5)/$2)*100}'`
    HDD1=`df -h | grep -m1 '/dev/mapper' | awk -F' ' '{print $4'}`
    HDD2=`df -h | grep "/mnt/hdd" | awk -F' ' '{print $4'}`
    TEMP=$(sensors | grep -m1 "0:" | cut -d" " -f5)
    RPM=$(sensors | grep "Processor Fan:" | awk -F' ' '{print $3" "$4'})
    AP=''
    STS=$(cmus-remote -Q | grep "status" | cut -d" " -f2)
    if [ "$STS" == "playing" ]; then
        ARTIST=$(cmus-remote -Q | 
            grep --text '^tag artist' | 
            awk '{gsub("tag artist ", ""); print}')
        TITLE=$(cmus-remote -Q |
            grep --text '^tag title' |
            awk '{gsub("tag title ", ""); print}')
        AP="| $ARTIST – $TITLE "
    fi
    echo "$GMAIL $AP| $WEATH | $TEMP ($RPM) | $USEDMEM GiB ($PRCTMEM%) | (/) $HDD1 | (/mnt/sda1) $HDD2 | $line"
done

