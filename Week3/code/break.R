# Author: An (an.nguyen21@imperial.ac.uk)
# Script: break.R
# Created: Oct 2021
# Desc: How to break out of a loop.

rm(list=ls())

i <- 0 #Initialize i
while(i < Inf) {
  if (i == 10) {
    break 
  } # Break out of the while loop! 
  else { 
    cat("i equals " , i , " \n")
    i <- i + 1 # Update i
  }
}