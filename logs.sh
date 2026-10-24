#!/bin/bash

USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]
then
echo "Please run under root user!!" | tee -a $LOG_FILE
exit 1
else 
echo "Running with root user!!" | tee -a $LOG_FILE
fi

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER 

VALIDATE(){
    if [ $1 -eq 0 ]
    then
    echo "Installing $2 is success"  | tee -a $LOG_FILE
    else
    echo "Installing $2 is failure" | tee -a $LOG_FILE
    exit 1
    fi
}

dnf list installed mysql &>>$LOG_FILE
if [ $? -ne 0 ]
then
echo "Going to install mysql" | tee -a $LOG_FILE
dnf install mysql -y &>>$LOG_FILE

VALIDATE $? mysql

else
echo "Already installed mysql" | tee -a $LOG_FILE
fi

dnf list installed nginx &>>$LOG_FILE
if [ $? -ne 0 ]
then
echo "Going to install nginx" | tee -a $LOG_FILE
dnf install nginx -y &>>$LOG_FILE

VALIDATE $? nginx

else
echo "Already installed nginx" | tee -a $LOG_FILE
fi