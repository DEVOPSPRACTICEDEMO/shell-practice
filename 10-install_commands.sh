#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "Error:: Please run the script with root access"
    exit 1 # give other than 0 upto 127
else
    echo "You are running with root access"
fi

dnf list installed mysql

if[ $? -nq 0]
then
    echo "Mysql is not installed.... going to installit"
    dnf install mysql -y
    if [ $? -eq 0 ]
    then
        echo "Installing MySQL is Success"
    else
        echo "Installing MySQL is Failure"
        exit 1
    fi
else
    echo "Mysql is already installed.... nothing to do"
fi

# dnf install mysql -y

# if [ $? -eq 0 ]
# then
#     echo "Installing MySQL is Success"
# else
#     echo "Installing MySQL is Failure"
#     exit 1
# fi
