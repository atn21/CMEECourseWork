#!/bin/bash
# Author: An an.nguyen21@imperial.ac.uk
# Script: boilerplate.sh
# Desc: combine two files into one
# Arguments: 2 (enter 2 files for merging)
# Date: Oct 2021

#check if there are two valid inputs
if [ -z "$1" ] || [ -z "$2" ] 
then 
    echo 'Missing inputs please enter 2 file names'
    exit 0 
else
    #combine two files in data/ into a new file named MERGED
    touch merged 
    cat ../data/$1 > MERGED
    cat ../data/$2 >> MERGED

    #save the merged file in results/
    mv MERGED ../results

    #print content of merged file
    echo "Merged file saved as MERGED in results/ and is shown below"
    cat ../results/MERGED

fi

exit
