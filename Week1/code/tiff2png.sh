#!/bin/bash
# Author: An an.nguyen21@imperial.ac.uk
# Script: tiff2png.sh
# Description: convert .tif into .png
#
# Saves the output into a .png file
# Arguments: 1 (input .tif to get .png file)
# Date: Oct 2021

if [ -z "$1" ]
then 
    echo "Please enter a .tif file"
    exit
else
    for f in *.tif; 
        do  
            echo "Converting $f"; 
            convert "$f"  "$(basename "$f" .tif).png"; 
    done
fi
mv "$(basename "$f" .tif).png" ../results
exit