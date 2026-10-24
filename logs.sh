#!/bin/bash

USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]
then
echo "Please run under root user!!"
exit 1
else 
echo "Running with root user!!"
fi

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER 

VALIDATE(){
    if [ $1 -eq 0 ]
    then
    echo "Installing $2 is success" &>>$LOG_FILE
    else
    echo "Installing $2 is failure" &>>$LOG_FILE
    exit 1
    fi
}

dnf list installed mysql &>>$LOG_FILE
if [ $? -ne 0 ]
then
echo "Going to install mysql" &>>$LOG_FILE
dnf install mysql -y &>>$LOG_FILE

VALIDATE $? mysql

else
echo "Already installed mysql" &>>$LOG_FILE
fi

dnf list installed nginx &>>$LOG_FILE
if [ $? -ne 0 ]
then
echo "Going to install nginx" &>>$LOG_FILE
dnf install nginx -y &>>$LOG_FILE

VALIDATE $? nginx

else
echo "Already installed nginx" &>>$LOG_FILE
fi