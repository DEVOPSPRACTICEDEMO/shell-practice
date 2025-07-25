#!/bin/bash

USER_ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
SOURCE_DIR=/home/ec2-user/app-logs

# Create log directory if it doesn't exist
mkdir -p $LOGS_FOLDER

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR:: Please run this script with root access $N" | tee -a $LOG_FILE
    exit 1 
else
    echo -e "$G You are running with root access" | tee -a $LOG_FILE
fi

#VALIDATE function to check command execution
VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is ... $G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$2 is ... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    fi
}

echo -e "$Y Script started executing at: $(date) $N" | tee -a $LOG_FILE

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)

while IFS= read -r filepath
do 
    echo -e "$Y Deleting old log file: $filepath $N" | tee -a $LOG_FILE
    rm -rf $filepath
done <<< $FILES_TO_DELETE

echo -e "$G Old log files deleted successfully $N" | tee -a $LOG_FILE