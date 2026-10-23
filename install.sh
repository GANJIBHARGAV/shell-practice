#!/bin/bash
echo "Installing mysql"
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]
then
echo "Please run under root user!!"
exit 1
else 
echo "Running with root user!!"
fi

apt install mysql-server -y
VALIDATE(){
if [ $? -eq 0 ]
then
echo "Installing mysql is success"
else
echo "Installing mysql is failure"
exit 1
fi
}
VALIDATE
if [ $1 -ne 0 ]
then 
echo "Installing $2.."
else
echo "$2 is already installed"
fi

