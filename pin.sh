#!/bin/bash

echo "Enter your pin"
read -s pin
echo "Your number is $pin"

date=$(date)
echo "Script executed at $date"

MOVIES=( "Eshwar", "Fauzi", "Spirit", "Billa")
echo "${MOVIES[2]}"