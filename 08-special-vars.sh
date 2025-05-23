#!/bin/bash

echo "All Variables Passed: $@"
echo "Number of variables: $#"
echo "Scropt Name: $0"
echo "Current Directory: $PWD"
echo "User running this script: $USER"
echo "Home Directory of user: $HOME"
echo "PID of the script: $$"
sleep 10 &
echo "PID of last command in background: $!"


