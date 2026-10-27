#!/bin/bash
USER_ID=$(id -u)
LOGS_FOLDER="/var/log/shell-script-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
SOURCE_DIR="/home/ec2-user/app-logs"
mkdir -p $LOGS_FOLDER

if [ $USER_ID -ne 0 ]
then 
echo "Please login with root user" | tee -a $LOG_FILE
else
echo "You are under root user" | tee -a $LOG_FILE
fi

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)

while IFS= read -r line
do
echo "Deleting files: $line " | tee -a $LOG_FILE
rm -rf $line
done <<< $FILES_TO_DELETE

