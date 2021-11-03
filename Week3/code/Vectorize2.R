# Author: An an.nguyen21@imperial.ac.uk
# Script: Vectorize2.R
# Desc: Runs the stochastic Ricker equation with gaussian fluctuations
# Arguments: 5 (p0: initial pop density
#               r: intrinsic growth rate
#               K: carrying capacity
#               sigma: stochasticity
#               numyears: number of years)
# Date: Oct 2021

#clear workspace
rm(list = ls())

stochrick <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{

  N <- matrix(NA, numyears, length(p0))  #initialize empty matrix

  N[1, ] <- p0

  for (pop in 1:length(p0)) { #loop through the populations

    for (yr in 2:numyears){ #for each pop, loop through the years

      N[yr, pop] <- N[yr-1, pop] * exp(r * (1 - N[yr - 1, pop] / K) + rnorm(1, 0, sigma)) # add one fluctuation from normal distribution
    
     }
  
  }
 return(N)

}

print("Stochastic Ricker takes:")
print(system.time(res<-stochrick()))

# Now write another function called stochrickvect that vectorizes the above to
# the extent possible, with improved performance: 
stochrickvect <- function(p0 = runif(1000, .5, 1.5), r = 1.2, K = 1, sigma = 0.2,numyears = 100)
{

  N <- matrix(NA, numyears, length(p0))  #initialize empty matrix

  N[1, ] <- p0 #p0 is initial pop density
  
  for (yr in 2:numyears) #for each pop, loop through the years
    { 

      N[yr, ] <- N[yr-1, ] * exp(r * (1 - N[yr - 1, ] / K) + rnorm(1, 0, sigma)) # add one fluctuation from normal distribution
    
    }
}

print("Vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrickvect()))