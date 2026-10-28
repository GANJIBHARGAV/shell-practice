#!/bin/bash
DISK_USAGE=$(df -hT | grep -v Filesystem)
DISK_THRESOLD=1
MSG=""
IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

while IFS= read -r line
do
USAGE=$(echo $line | awk '{print$6F}' | cut -d "%" -f1)
PARTITION=$(echo $line | awk '{print$7F}')
if [ "$USAGE" -ge "$DISK_THRESOLD" ]
MSG+="High disk usage on $PARTITION : $USAGE % <br>"
done <<< "$DISK_USAGE"
fi

#echo -e "$MSG"

sh mail.sh "DevOps team" "High cpu alert" "$IP" "$MSG" "bhargav.ganji8@gmail.com" "ALERT-High Disk Usage"