# Author: An (an.nguyen21@imperial.ac.uk)
# Script: apply1.R
# Created: Oct 2021
# Desc: Use **apply** to perform function on a matrix.

rm(list = ls())

## Build a random matrix
M <- matrix(rnorm(100), 10, 10)

## Take the mean of each row
RowMeans <- apply(M, 1, mean)
print (RowMeans)

## Now the variance
RowVars <- apply(M, 1, var)
print (RowVars)

## By column
ColMeans <- apply(M, 2, mean)
print (ColMeans)