#!bin/bash

set -e

failure() {
    echo "Failed at: $1 $2"
}
trap 'failure "${LINENO}" ${BASH_COMMAND}"' ERR

echo "Hi Good Morning, Welcome to Shell Scripting Practice"
echoooooo "Let's start with the basics of Shell Scripting"
echo "This script will help you practice setting up various applications in a shell environment."
