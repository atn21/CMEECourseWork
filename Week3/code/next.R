# Author: An (an.nguyen21@imperial.ac.uk)
# Script: next.R
# Created: Oct 2021
# Desc: How to use next.

rm(list=ls())

for (i in 1:10) {
  if ((i %% 2) == 0) # check if the number is odd
    next # pass to next iteration of loop 
  print(i)
}