#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo -e "$R Error:: Please run the script with root access $N"
    exit 1 # give other than 0 upto 127
else
    echo "You are running with root access"
fi

VALIDATE(){
     if [ $1 -eq 0 ]
    then
        echo -e "Installing $2 is $G Success $N"
    else
        echo -e "Installing $2 is $R Failure $N"
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
    echo -e "nothing to do Mysql is  $Y already installed.... $N "
fi

dnf list installed python3

if [ $? -ne 0 ]
then
    echo "python3 is not installed.... going to install it"
    dnf install python3 -y
    VALIDATE $? "Python3"
else
    echo -e "nothing to do python3 is  $Y already installed.... $N "
fi

dnf list installed nginx

if [ $? -ne 0 ]
then
    echo "nginx is not installed.... going to install it"
    dnf install nginx -y
    VALIDATE $? "NGINX"
else
    echo "nothing to do nginx is $Y already installed.... $N "
fi