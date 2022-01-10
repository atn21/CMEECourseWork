#clear workspace
rm(list=ls())

#load data
load("../data/KeyWestAnnualMeanTemperature.RData")

#correlation coefficient of temperature between successive years
ce <- cor(ats$Temp[1:99],ats$Temp[2:100])

#calculate possible combination of years and temperature
#100 samples, 4950 possible combinations
sampletime <- 100 * (100 -1)/2

#shuffle temperature, each time randomly 
#re-assigning temperatures to year
set.seed(18)
shuffle_cor <- function(x) {
  x <- sample(x)
  return (cor(x[1:99], x[2:100]))
}

#repeat the shuffling 19900 times
calfraction <- sapply(1:sampletime, function(i) shuffle_cor(ats$Temp))

# histogram to compare coefficient correlations
pdf("../results/TAutoCorrplot.pdf")
hist(calfraction, 
     xlim = c(-0.6, 0.6),
     xlab = "Correlation coefficients of random sample",
     main = NULL)
abline(v = ce, col="blue", lwd=3, lty=2)
text(0.19, 800, "Original correlation coefficient 
     \n of temperature between succesive years: 0.326", cex = 0.65, col="blue")
dev.off()

#calculate approximate, asymptotic p-value (what fraction of 
#the random correlation coefficients were greater than the observed one 
p <- sum(calfraction > ce)/length(calfraction)