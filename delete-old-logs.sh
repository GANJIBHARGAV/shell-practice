#!/bin/bash
SOURCE_DIR="/home/ec2-user/app-logs"
FILES_TO_DELETE=$(find . -name "*.log" -mtime +14)
while IFS= read -r line 
do
rm -rf $line
done <<< FILES_TO_DELETE