#!/bin/bash
USER_ID=$(id -u)
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
SOURCE_DIR="/home/ec2-user/app-logs"

mkdir -p "$LOGS_FOLDER"

if [ $USER_ID -ne 0 ]
then
echo "Please login with root user"
exit 1
else
echo "You are under root user!"
fi

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)
if [ -z "$FILES_TO_DELETE" ]
then
echo "No files present or already files got deleted"
else
while IFS= read -r line
do 
echo "Deleting files: $line"
rm -rf $line
done <<< "$FILES_TO_DELETE"
fi