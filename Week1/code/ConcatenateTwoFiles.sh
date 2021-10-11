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
fi

#combine two files into a new file named plzwork
touch plzwork 
cat $1 > plzwork
cat $2 >> plzwork

#print content of merged file
echo "Merged file saved as plzwork in results/ and is shown below"
cat plzwork

#save the merged file in results/
mv plzwork ../results

exit