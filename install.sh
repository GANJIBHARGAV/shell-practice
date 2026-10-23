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

dpkg -s mysql-server
if [ $? -ne 0 ]
then
echo "Going to install mysql"
apt install mysql-server -y
if [ $? -eq 0 ]
then
echo "Installing mysql is success"
else
echo "Installing mysql is failure"
exit 1
fi

else
echo "Already installed mysql"
fi





