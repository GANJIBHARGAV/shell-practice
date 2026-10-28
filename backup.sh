#!/bin/bash
USER_ID=$(id -u)
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

if [ $USER_ID -ne 0 ]
then
echo "Please use root account!!"
exit 1
else
echo "You are running under root under!!"
fi

mkdir -p "$LOGS_FOLDER"

USAGE(){
    echo "USAGE:: sh backup.sh <source-dir><dest-dir> -optional(days)"
}

if [ $# -lt 2 ]
then 
USAGE
exit 1
fi

if [ ! -d $SOURCE_DIR ]
then
echo "Source directory $SOURCE_DIR does not exists"
exit 1
fi

if [ ! -d $DEST_DIR ]
then
echo "Source directory $DEST_DIR does not exists"
exit 1
fi

FILES=$(find $SOURCE_DIR -name ".log" -mtime $DAYS)

if [ ! -z "$FILES" ]
then 
echo "Files to be zipped are: $FILES"
TIMESTAMP=$(date +%F-%H-%M-%S)
ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
"$FILES" | zip -@ "$ZIP_FILE"

if [ -f $ZIP_FILE ]
then
echo -e "Successfully created Zip file"
while IFS= read -r line
do 
rm -f $line
done <<< $FILES
echo "Sucessfully zip files got deleted"
else
echo "Deletion of zip files got failed"
exit 1

else 
echo "No files older than 14 days!!"
fi


