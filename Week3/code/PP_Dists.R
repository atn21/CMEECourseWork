# Author: An (an.nguyen21@imperial.ac.uk)
# Script: PP_Dists.R
# Created: Oct 2021
# Desc: Draw the distributions of predator mass, prey mass, and the size ratio of 
# prey mass to predator mass by feeding interaction type. Use logarithms 
# of masses (or size ratios) for all three plots. In addition, the script calculates 
# the (log) mean and median predator mass, prey mass and predator-prey size-ratios to a csv file.

rm(list = ls())

require(plyr)
require(tidyverse)

MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")

MyDF <- MyDF %>% mutate(Prey.mass = case_when(Prey.mass.unit == "mg" ~ Prey.mass / 1000, TRUE ~ Prey.mass))%>% mutate(Prey.mass.unit = case_when(Prey.mass.unit == "mg" ~ "g", TRUE ~ Prey.mass.unit))

#test <- test %>% mutate(i1 = Col2 == 'C', 
#      Col1 = case_when(i1 ~ Col1 * 1000, TRUE ~ Col1), 
#      Col2 = case_when(i1 ~ 'D', TRUE ~ Col2), i1 = NULL)

#test <- test %>% mutate(Col1 = ifelse(Col2 == 'C',  Col1 * 1000, Col1),
#Col2 = ifelse(Col2 == 'C', "D", Col2))

pdf("../results/Pred_Subplots.pdf")
par(mfcol=c(3,2)) #initialize multi-paneled plot
for (t in unique(MyDF$Type.of.feeding.interaction)) {
  p <- subset(MyDF, Type.of.feeding.interaction == t)
  pred_mass_log <- as.numeric(log(p$Predator.mass))
  hist(pred_mass_log,
     xlab = "log10(Predator Mass (g))",
     ylab = "Count",
     main = t)
}
dev.off()

pdf("../results/Prey_Subplots.pdf")
par(mfcol=c(3,2)) #initialize multi-paneled plot
for (t in unique(MyDF$Type.of.feeding.interaction)) {
  p <- subset(MyDF, Type.of.feeding.interaction == t)
  prey_mass_log <- as.numeric(log(p$Prey.mass))
  hist(prey_mass_log,
     xlab = "log10(Prey Mass (g))",
     ylab = "Count",
     main = t)
}
dev.off()

pdf("../results/SizeRatio_Subplots.pdf")
par(mfcol=c(3,2)) #initialize multi-paneled plot
for (t in unique(MyDF$Type.of.feeding.interaction)) {
  p <- subset(MyDF, Type.of.feeding.interaction == t)
  ratio <- as.numeric(log(p$Prey.mass/p$Predator.mass))
  hist(ratio,
       xlab = "log10(Prey Mass/Predator Mass (g))",
       ylab = "Count",
       main = t)
}
dev.off()

mmpred <- ddply(MyDF, ~ Type.of.feeding.interaction, summarize,
    Predator_mass_mean = mean(log(Predator.mass)),
    Predator_mass_median = median(log(Predator.mass)),
    Prey_mass_mean = mean(log(Prey.mass)),
    Prey_mass_median = median(log(Prey.mass)),
    Preyvspred_mean = mean(log(Prey.mass/Predator.mass)),
    Preyvspred_median = median(log(Prey.mass/Predator.mass)))

write.csv(mmpred, "../results/PP_Results.csv", row.names = FALSE)