#!/bin/bash
# Author: An an.nguyen21@imperial.ac.uk
# Script: csvtospace.sh
# Desc: substitute commas in the files with space

# Save output as .txt file
# Arguments: 1 (input .csv file for space delimited .txt output)
# Date: Oct 2021

#check if there is valid input. if yes, convert csv to space delimited file
if [ ! -z "$1" ] 
then echo "Creating a space delimited version of $1 ..."
    
    #remove .csv extension so final file is name.txt
    fbname=$(basename "$1" .csv)

    #substitute commas in the files with space
    cat $1 | tr -s "," " " >> $fbname.txt

    #move finished file to results/
    mv "$fbname.txt" ../results
    echo "Finish!"

#exit programme if there is no .csv file
else 
    echo -e "Null input\nPlease specify a .csv file"
fi
exit
