#!/bin/bash
USER_ID=$(id -u)
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
APP_LOGS="app-logs"
mkdir -p "$APP_LOGS"
touch -d 20240897 payment.log
touch -d 20201212 user.log
touch -d 20201010 shipping.log
touch -d 20200906 cart.log
touch -d 20200102 catalogue.log
touch  report.log

SOURCE_DIR="/home/ec2-user/$APP_LOGS"


if [ $USER_ID -ne 0 ]
then
echo "Please login with root user" | tee -a $LOG_FILE
exit 1
else
echo "You are under root user!" | tee -a $LOG_FILE
fi

mkdir -p "$LOGS_FOLDER"
FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)
if [ -z "$FILES_TO_DELETE" ]
then
echo "No files present or already files got deleted" | tee -a $LOG_FILE
else
while IFS= read -r line
do 
echo "Deleting files: $line" | tee -a $LOG_FILE
rm -rf $line
done <<< "$FILES_TO_DELETE"
fi