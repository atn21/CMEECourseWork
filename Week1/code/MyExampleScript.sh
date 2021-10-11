#!/bin/bash
# Author: An an.nguyen21@imperial.ac.uk
# Script: MyExampleScript.sh
# Desc: two different ways to display variables

# Arguments: 2 (having string or command substituion as the value of variables)
# Date: Oct 2021

#assign variables
msg1="Hello"
msg2=$USER

#print variables using variable names
echo "$msg1 $msg2"

#print variables using their values
echo "Hello $USER"
echo