#!/bin/bash
# Author: An an.nguyen21@imperial.ac.uk
# Script: variables.sh
# Description: assign values to variables 
#
# Arguments: 2 (string value or integer value as variables)
# Date: Oct 2021

# Show the use variables
MyVar='some string'
echo 'the current value of the variable is' $MyVar
echo 'Please enter a new string'
read MyVar
echo 'the current value of the variable is' $MyVar

## Reading multiple values
echo 'Enter two numbers separated by space(s)'
read a b
echo 'you entered' $a 'and' $b '. Their sum is:'
mysum=`expr $a + $b`
echo $mysum