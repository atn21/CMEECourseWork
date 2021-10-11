#!/bin/bash
# Author: An an.nguyen21@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 (input .txt to obtain comma delimited output)
# Date: Oct 2021

if [ ! -z "$1" ] 
then echo "Creating a comma delimited version of $1 ..."
    fbname=$(basename "$1" .txt)
    cat $1 | tr -s "," " " >> $fbname.csv
    mv "$fbname.csv" ../results
    echo "Finish!"
else 
    echo -e "Null input\nPlease specify a .txt file"
fi
exit
