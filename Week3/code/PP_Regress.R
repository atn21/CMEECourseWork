rm(list = ls())

require(ggplot2)
require(tidyverse)

MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")

MyDF <- MyDF %>% mutate(Prey.mass = case_when(Prey.mass.unit == "mg" ~ Prey.mass / 1000, TRUE ~ Prey.mass))%>% mutate(Prey.mass.unit = case_when(Prey.mass.unit == "mg" ~ "g", TRUE ~ Prey.mass.unit))

p3 <- ggplot(MyDF, aes(x=Prey.mass, y=Predator.mass, color = Predator.lifestage)) + 
  geom_point(shape = 3) + geom_smooth(method="lm",fullrange = TRUE) + facet_grid(Type.of.feeding.interaction ~ .) +
  scale_x_continuous(trans="log10") + scale_y_continuous(trans = "log10") + xlab("Prey mass in grams") + ylab("Predator mass in grams")

#Calculate the regression results corresponding to the lines fitted in the figure.
#The regression results should include the following with appropriate headers: 
#regression slope, regression intercept, R, F-statistic value, and p-value of the overall regression

savedata <- MyDF %>% 
  group_by(Type.of.feeding.interaction, Predator.lifestage) %>%
  # lm calculation and store calculations to a dataframe
  do(mod = lm(log(Predator.mass) ~ log(Prey.mass), data = .)) %>% 
  mutate(
    Slope = summary(mod)$coeff[2],
    Intercept = summary(mod)$coeff[1],
    R.squared = summary(mod)$r.square,
    F.statistic = list(summary(mod)$fstatistic[1]),
    p.value = summary(mod)$coeff[8]) %>%
  dplyr::select(-mod)

savedata$F.statistic[sapply(savedata$F.statistic, is.null)] <- NaN
savel <- unlist(savedata$F.statistic, use.names = FALSE)
savedata$F.statistic <- savel

#save results to a csv delimited table called (PP_Regress_Results.csv), in the results directory
write.csv(savedata, "../results/PP_Regress_Results.csv", row.names = FALSE)