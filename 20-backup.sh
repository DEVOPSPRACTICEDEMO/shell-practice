#!/bin/bash

# This script is used to backup files from SOURCE_DIR to DEST_DIR
# It will delete files older than DAYS days from the backup directory
USER_ID=$(id -u)
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # Default to 14 days, if not provided the days argument

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m" 
N="\e[0m"

# Function to validate command execution
VALIDATE() {
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is ... $G SUCCESS $N" | tee -a $LOG_FILE
    else
        echo -e "$2 is ... $R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    fi
} 

check_root() {
    if [ $USER_ID -ne 0 ]
    then
        echo -e "$R ERROR:: Please run this script with root access $N" | tee -a $LOG_FILE
        exit 1 
    else
        echo -e "$G You are running with root access $N" | tee -a $LOG_FILE
    fi
}

check_root
mkdir -p $LOGS_FOLDER

USAGE(){
    echo -e "$R USAGE:: $N sh 20-backup.sh <source-dir> <dest-dir> <days(optional)>"
}  

if [ $# -lt 2 ]
then
    echo -e "$R ERROR:: Please provide source and destination directories $N" | tee -a $LOG_FILE
    USAGE
    exit 1
fi

if [ ! -d $SOURCE_DIR ] 
then 
    echo -e "$R ERROR:: Source directory $SOURCE_DIR does not exist $N" | tee -a $LOG_FILE
    exit 1
fi

if [ ! -d $DEST_DIR ]
then
    echo -e "$R destination directory $DEST_DIR does not exist $N" | tee -a $LOG_FILE
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ -z "$FILES" ]
then
    echo -e "$Y No old log files found to backup $N" | tee -a $LOG_FILE
else
    echo -e "$Y Backing up old log files to $DEST_DIR $N" | tee -a $LOG_FILE
    while IFS= read -r filepath
    do 
        cp $filepath $DEST_DIR &>>$LOG_FILE
        VALIDATE $? "Backing up file: $filepath"
        rm -rf $filepath &>>$LOG_FILE
        VALIDATE $? "Deleting file: $filepath"
    done <<< "$FILES"
fi

