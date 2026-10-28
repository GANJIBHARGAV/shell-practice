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
then
MSG+="High disk usage on $PARTITION : $USAGE % <br>"
fi
done <<< "$DISK_USAGE"

#echo -e "$MSG"

sh mail.sh "DevOps team" "High cpu alert" "$IP" "$MSG" "Udayshwetha2001@gmail.com" "ALERT-High Disk Usage"