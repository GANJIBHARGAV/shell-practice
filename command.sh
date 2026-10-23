#!/bin/bash
echo "Current working directory: $PWD"
echo "Current user is: $USER"
echo "Script name is: $0"
echo "PID of current script: $$"
echo "PID of last script: $!"
echo "PID of exit status: $?"

PERSON=$1
echo "Hello $PERSON"