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

VALIDATE(){
    if [ $? -eq 0 ]
    then
    echo "Installing mysql is success"
    else
    echo "Installing mysql is failure"
    
    fi
}

dpkg -s mysql-server
if [ $? -ne 0 ]
then
echo "Going to install mysql"
apt install mysql-server -y

VALIDATE

else
echo "Already installed mysql"
fi





