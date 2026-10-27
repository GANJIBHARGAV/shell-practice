#!/bin/bash

# Check whether the user is root
USER_ID=$(id -u)

# Log configuration
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

# Application log directory
APP_LOGS="/home/ec2-user/app-logs"
SOURCE_DIR="$APP_LOGS"

# Validate root user
if [ "$USER_ID" -ne 0 ]; then
    echo "Please login with root user" | tee -a "$LOG_FILE"
    exit 1
else
    echo "You are running as root!" | tee -a "$LOG_FILE"
fi

# Create the log directory
mkdir -p "$LOGS_FOLDER"

# Create application log directory
mkdir -p "$APP_LOGS"

# Create sample log files with old timestamps
touch -d "2024-08-09" "$APP_LOGS/payment.log"
touch -d "2020-12-12" "$APP_LOGS/user.log"
touch -d "2020-10-10" "$APP_LOGS/shipping.log"
touch -d "2020-09-06" "$APP_LOGS/cart.log"
touch -d "2020-01-02" "$APP_LOGS/catalogue.log"
touch "$APP_LOGS/report.log"

echo "Searching for .log files older than 14 days..." | tee -a "$LOG_FILE"

# Find old log files
FILES_TO_DELETE=$(find "$SOURCE_DIR" -type f -name "*.log" -mtime +14)

# Check whether old log files exist
if [ -z "$FILES_TO_DELETE" ]; then
    echo "No old log files found." | tee -a "$LOG_FILE"
else
    # Delete old log files
    while IFS= read -r line; do
        echo "Deleting file: $line" | tee -a "$LOG_FILE"

        if rm -f -- "$line"; then
            echo "Successfully deleted: $line" | tee -a "$LOG_FILE"
        else
            echo "Failed to delete: $line" | tee -a "$LOG_FILE"
        fi
    done <<< "$FILES_TO_DELETE"
fi

# Record script completion
echo "Script execution completed at $(date)" | tee -a "$LOG_FILE"
