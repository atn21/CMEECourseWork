#!/bin/bash
# Author: An an.nguyen21@imperial.ac.uk
# Script: boilerplate.sh
# Desc: combine two files into one
# Arguments: 2 (enter 2 files for merging)
# Date: Oct 2021


if [ -z "$1" ] || [ -z "$2" ] 
then 
    echo 'Missing inputs please enter 2 file names'
    exit 0 
fi

touch plzwork 
cat $1 > plzwork
cat $2 >> plzwork

echo "Merged file saved as plzwork in results/ and is shown below"
cat plzwork
mv plzwork ../results

exit