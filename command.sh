#!/bin/bash
PERSON=$1
echo "Hello $PERSON, good day!"
echo "All variables passed are $@"
echo "Current working directory: $PWD"
echo "Current user is: $USER"
echo "Script name is: $0"
echo "PID of current script: $$"
sleep 40 &
echo "PID of last script: $!"
echo "PID of exit status: $?"

