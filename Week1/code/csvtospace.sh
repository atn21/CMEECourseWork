#!/bin/bash
# Author: An an.nguyen21@imperial.ac.uk
# Script: csvtospace.sh
# Desc: substitute commas in the files with space

# Save output as .txt file
# Arguments: 1 > space delimited file
# Date: Oct 2021

if [ ! -z "$1" ] 
then echo "Creating a space delimited version of $1 ..."
    cat $1.csv | tr -s "," " " >> $1.txt
    mv "$1.txt" ../results
    echo "Finish!"
else 
    echo -e "Null input\nPlease specify a csv file"
fi
exit
