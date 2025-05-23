#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Error:: Please run the script with root access"
    exit 1 # give other than 0 upto 127
else
    echo "You are running with root access"
fi

VALIDATE(){
     if [ $1 -eq 0 ]
    then
        echo "Installing $2 is Success"
    else
        echo "Installing $2 is Failure"
        exit 1
    fi
}

dnf list installed mysql

if [ $? -ne 0 ]
then
    echo "Mysql is not installed.... going to install it"
    dnf install mysql -y
    VALIDATE $? "MySQL"
else
    echo "Mysql is already installed.... nothing to do"
fi

dnf list installed python3

if [ $? -ne 0 ]
then
    echo "python3 is not installed.... going to install it"
    dnf install python3 -y
    VALIDATE $? "Python3"
else
    echo "python3 is already installed.... nothing to do"
fi

dnf list installed nginx

if [ $? -ne 0 ]
then
    echo "nginx is not installed.... going to install it"
    dnf install nginx -y
    VALIDATE $? "NGINX"
else
    echo "nginx is already installed.... nothing to do"
fi