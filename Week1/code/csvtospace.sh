#!/bin/bash
# Author: An an.nguyen21@imperial.ac.uk
# Script: csvtospace.sh
# Desc: substitute commas in the files with space

# Save output as .txt file
# Arguments: 1 (input .csv file for space delimited .txt output)
# Date: Oct 2021

if [ ! -z "$1" ] 
then echo "Creating a space delimited version of $1 ..."
    fbname=$(basename "$1" .csv)
    cat $1 | tr -s "," " " >> $fbname.txt
    mv "$fbname.txt" ../results
    echo "Finish!"
else 
    echo -e "Null input\nPlease specify a .csv file"
fi
exit
