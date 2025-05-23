#!/bin/bash

# -gt --> Greater Than
# -lt --> Less than
# -eq --> equal
# -ne --> Not equal

Number = $1

if [ $Number -lt 10 ]
then
    echo "Given number $Number is less than 10"
else
    echo "Given number $Number is not less than 10"
fi