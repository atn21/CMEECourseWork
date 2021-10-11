#!/bin/bash
# Author: An an.nguyen21@imperial.ac.uk
# Script: CountLines.sh
# Desc: count number of lines in a file

# Arguments: 1 (input 1 file for counting lines)
# Date: Oct 2021

#check if there is a valid input
if [ -z "$1" ] 
then 
    echo 'Missing inputs please enter a file'
    exit 0 
fi

#count number of lines
NumLines=`wc -l < $1`
echo "The file $1 has $NumLines lines"
echo