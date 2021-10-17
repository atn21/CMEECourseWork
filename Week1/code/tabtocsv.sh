#!/bin/bash
# Author: An an.nguyen21@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 (input .txt to obtain comma delimited output)
# Date: Oct 2021

#check if there is valid input. if yes, convert .txt to .csv
if [ ! -z "$1" ] 
then echo "Creating a comma delimited version of $1 ..."
    
    #remove .txt extension so final file is name.csv
    fbname=$(basename "$1" .txt)
    
    #substitute the tabs in the files with commas
    cat ../data/$1 | tr -s "," " " >> $fbname.csv

    #move finished file to results/
    mv "$fbname.csv" ../results
    echo "Finish!"

#exit programme if there is no .txt file    
else 
    echo -e "Null input\nPlease specify a .txt file"
fi
exit
