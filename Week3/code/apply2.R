# Author: An (an.nguyen21@imperial.ac.uk)
# Script: apply2.R
# Created: Oct 2021
# Desc: Return input times 100 if sum of input is greater than 0.

rm(list = ls())

SomeOperation <- function(v){ #return v*100 if sum of v > 0
  if (sum(v) > 0){ #note that sum(v) is a single (scalar) value
    return (v * 100)
  }
  return (v)
}

M <- matrix(rnorm(100), 10, 10)
print (apply(M, 1, SomeOperation))