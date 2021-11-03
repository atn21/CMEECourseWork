# Author: An an.nguyen21@imperial.ac.uk
# Script: Florida.R
# Desc: Your goal is to write an R script that will help answer the question: 
#       Is Florida getting warmer? To answer the question, you need to calculate 
#       the correlation coefficients between temperature and time. 
#       However, you can’t use the standard p-value calculated for a correlation coefficient, 
#       because measurements of climatic variables in successive time-points in a time series 
#       (successive seconds, minutes, hours, months, years, etc.) are not independent. 
#       Therefore you will use a permutation analysis instead, by generating a distribution of 
#       random correlation coefficients and compare your observed coefficient with this random distribution.
# Arguments: 1 (data file)
# Output: approximate, asymptotic p-value
# Date: Oct 2021

#clear workspace
rm(list=ls())

#load data
load("../data/KeyWestAnnualMeanTemperature.RData")

#correlation coefficient between years and temperature
ce <- cor(ats$Year, ats$Temp)

#calculate possible combination of years and temperature
#200 samples, 19900 possible combinations
numdata <- nrow(ats) * ncol(ats)
sampletime <- numdata * (numdata -1)/2

#shuffle temperature, each time randomly 
#re-assigning temperatures to year
shuffle_cor <- function(x) {
    x[,2] <- sample(x[,2])
    return (cor(x[,1], x[,2]))
}

#repeat the shuffling 19900 times
calfraction <- sapply(1:sampletime, function(i) shuffle_cor(ats))

#calculate approximate, asymptotic p-value (what fraction of 
#the random correlation coefficients were greater than the observed one 
p <- sum(calfraction > ce)/length(calfraction)

