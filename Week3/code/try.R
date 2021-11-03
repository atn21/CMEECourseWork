# Author: An (an.nguyen21@imperial.ac.uk)
# Script: try.R
# Created: Oct 2021
# Desc: How to use try() to catch errors.

rm(list=ls())
#obtain samples
doit <- function(x){
    temp_x <- sample(x, replace = TRUE)
    if(length(unique(temp_x)) > 30) {#only take mean if sample was sufficient
         print(paste("Mean of this sample was:", as.character(mean(temp_x))))
        } 
    else {
        stop("Couldn't calculate mean: too few unique values!")
        }
    }

#generate population
popn <- rnorm(50)

#draw histogram
hist(popn)

#apply doit() to popn 15 times
lapply(1:15, function(i) doit(popn))

#with try()
result <- lapply(1:15, function(i) try(doit(popn), FALSE))

#examine result after try()
class(result)
result

#using for instead of lappy
result <- vector("list", 15) #Preallocate/Initialize
for(i in 1:15) {
    result[[i]] <- try(doit(popn), FALSE)
    }