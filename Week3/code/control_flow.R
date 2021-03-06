# Author: An (an.nguyen21@imperial.ac.uk)
# Script: control_flow.R
# Created: Oct 2021
# Desc: Control flow in R.

rm(list = ls())

#if statements
a <- TRUE
if (a == TRUE){
  print ("a is TRUE")
} else {
  print ("a is FALSE")
}

#You can also write an if statement on a single line:
z <- runif(1) # Generate a uniformly distributed random number
if (z <= 0.5) {
  print ("Less than a half")
}

#for loops
for (i in 1:10){
    j <- i * i
    print(paste(i, " squared is", j ))
  }

#You can also loop over a vector of strings
for(species in c('Heliodoxa rubinoides', 
                   'Boissonneaua jardini', 
                   'Sula nebouxii')){
    print(paste('The species is', species))
  }

#for loop using apre-existing vector:
v1 <- c("a","bc","def")
for (i in v1){
  print(i)
}

#while loops.If you want to perform an operation till some condition is met, 
#use a while loop:
i <- 0
while (i < 10){
  i <- i+1
  print(i^2)
}