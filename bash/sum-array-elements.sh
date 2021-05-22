#!/bin/bash

######################################################################
# Script Name    : sum-array-elements.sh
# Description    : Used to sum elements passed by arguments
# Args           : Ex: 1 5 9
# Execute        : ./sum-array-elements.sh 1 2 3 
######################################################################

sum=0
array=("$@")
for i in ${array[@]}; do
	let sum+=$i
done
echo "$sum"
