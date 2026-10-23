#!/bin/bash
var1=$1
var2=$2

USAGE(){
    echo "USAGE:: sh greetings.sh <var1><var2>"
    exit 1
}

if [ $# -lt 2 ]
then
    USAGE
fi

echo "Hello $var1, how are you??"
echo "Hello $var2, hey!! I am doing great how about you?"

echo "Along with this print the filesystem details and memoery usage"
df -h
free -m
