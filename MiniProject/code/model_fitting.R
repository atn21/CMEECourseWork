# Author: An (an.nguyen21@imperial.ac.uk)
# Script: model_fitting.R
# Created: Dec 2021
# Desc: Fit models and perform analysis.

#read file
df <- read.csv("../data/test_data.csv")

#import mods
require(minpack.lm)
require(dplyr)
require(qpcR)
require(ggplot2)
require(reshape2)

#define classic logistic model
logistic_model <- function(t, r_max, K, N_0){
 return(N_0 * K * exp(r_max * t)/(K + N_0 * (exp(r_max * t) - 1)))
}

#define Modified gompertz growth model (Zwietering 1990)
gompertz_model <- function(t, r_max, K, N_0, t_lag){ 
 Nt = N_0 * (K/N_0) ^ (exp(-exp((exp(1) * r_max * (t_lag - t)) / log(K/N_0) + 1)))
 return(Nt)
}  

#define baranyi model
baranyi_model <- function(t, r_max, K, N_0, t_lag){
 h0 <- r_max * t_lag
 At <- t + 1/r_max * log(exp(-r_max * t) + exp(-h0) - exp(-r_max * t - h0))
 Nt <- N_0 + r_max * At - log(1 + (exp(r_max * At) - 1) / exp(K - N_0))
 return(Nt)
}

#find starting values
new_df <- data.frame(ID = numeric(0), N_0_start = numeric(0),    # Create empty data frame
                   K_start = numeric(0),
                   t_lag_start = numeric(0), r_max = numeric(0))
for (t in unique(df$ID)) {
  d<-subset(df, ID==t)
  N_0_start = min(d$Log_PopBio) # lowest population size, note log scale
  K_start = max(d$Log_PopBio) # highest population size, note log scale
  t_lag_start = d$Time[which.max(diff(diff(d$Log_PopBio)))] # find last timepoint of lag phase
  r_max = summary(lm(d$Log_PopBio ~ d$Time, d))$coeff[2]
  new_df[nrow(new_df)+1,] <- c(t,N_0_start, K_start,t_lag_start,r_max)
}

#remove any negative rmax and t_lag
new_df <- new_df[new_df$r_max >= 0,]
new_df <- new_df[new_df$t_lag_start >= 0,] 

#fit model
aic_results <- data.frame(matrix(ncol = 4, nrow = length(new_df)))
colnames(aic_results) <- c("Linear", "Logistic", "Gompertz", "Baranyi")
set.seed(1)
pdf("../results/Fit.pdf") #open pdf
for (r in new_df$ID) {
  ss <- subset(df, ID == r)
tryCatch({
  r_max_start=new_df[r,5]
  N_0_start = new_df[r,2]
  K_start = new_df[r,3]
  t_lag_start = new_df[r,4]
  timepoints <- seq(min(df$Time),max(df$Time))
    
  plot(ss$Log_PopBio ~ ss$Time, main=r, xlab="Time (hours)", ylab="Log(Population Bio)")
  legend("bottom",xpd=TRUE,horiz=TRUE,inset=c(-0.2,-0.2), bty="n",
         legend = c("Linear","Logistic","Gompertz","Baranyi"),
         col=c("brown","blue", "red","orange"), lty=c(1,1,2,1), lwd=3, cex=0.8)
  
  fit_lm <- lm(ss$Log_PopBio ~ ss$Time)
  LM_AIC <- AIC(fit_lm)
  aic_results[r,1] <- LM_AIC
  lines(ss$Time, predict(fit_lm), col = 'brown', lwd=3)
    
  fit_logistic <- nlsLM(Log_PopBio ~ logistic_model(t = Time, r_max, K, N_0), ss,
                      list(r_max=r_max_start, N_0 = N_0_start, K = K_start),
                        control = list(maxiter = 1000))
  Logistic_AIC <- AIC(fit_logistic)
  aic_results[r,2] <- Logistic_AIC
  summary_logistic <- summary(fit_logistic)
  logistic_points <- logistic_model(t = timepoints, 
                                    r_max = summary_logistic$coeff[1,1], 
                                    K = summary_logistic$coeff[3,1], 
                                    N_0 = summary_logistic$coeff[2,1])
  lines(logistic_points~timepoints, col="blue", lwd=3)
    
  suppressWarnings(fit_gompertz <- nlsLM(Log_PopBio ~ gompertz_model(t = Time, r_max, K, N_0, t_lag), ss,
                list(r_max=r_max_start, N_0 = N_0_start, K = K_start, t_lag = t_lag_start),
                control = list(maxiter = 500)))
  Gompertz_AIC <- AIC(fit_gompertz)
  aic_results[r,3] <- Gompertz_AIC
  summary_gompertz <- summary(fit_gompertz)
  gompertz_points <- gompertz_model(t = timepoints, 
                                  r_max = summary_gompertz$coeff[1,1], 
                                  K = summary_gompertz$coeff[3,1], 
                                  N_0 = summary_gompertz$coeff[2,1],
                                  t_lag = summary_gompertz$coeff[4,1])
  lines(gompertz_points~timepoints, col="red", lty=2, lwd=3) 
    
  suppressWarnings(fit_baranyi <- nlsLM(Log_PopBio ~ baranyi_model(t = Time, r_max, K, N_0, t_lag), ss,
                list(r_max=r_max_start, N_0 = N_0_start, K = K_start, t_lag = t_lag_start),
                control = list(maxiter = 500)))
  baranyi_AIC <- AIC(fit_baranyi)
  aic_results[r,4] <- baranyi_AIC
  summary_baranyi <- summary(fit_baranyi)
  baranyi_points <- baranyi_model(t = timepoints, 
                                  r_max = summary_baranyi$coeff[1,1], 
                                  K = summary_baranyi$coeff[3,1], 
                                  N_0 = summary_baranyi$coeff[2,1],
                                  t_lag = summary_baranyi$coeff[4,1])
  lines(baranyi_points~timepoints, col="orange", lwd=2)
}, error=function(x){})
    }
dev.off()

#find lowest AIC
h <- transform(aic_results, best = pmin(Linear,Logistic,Gompertz,Baranyi,na.rm=TRUE))

#identify best model for each species with delta AIC
h$best <- as.character(h$best)
h <- h %>% mutate(best = case_when(best == Linear ~ "Linear", TRUE ~ best),
                  best = case_when(best == Logistic ~ "Logistic", TRUE ~ best),
                  best = case_when(best == Gompertz ~ "Gompertz", TRUE ~ best),
                  best = case_when(best == Baranyi ~ "Baranyi", TRUE ~ best))

#count which model has the most low AIC
ct <- length(which(h$best == "Linear"))
lt <- length(which(h$best == "Logistic"))
gt <- length(which(h$best == "Gompertz"))
bt <- length(which(h$best == "Baranyi"))
lowAIC <- c(ct,lt,gt,bt)

#save lowAIC to bar chart pdf
pdf("../results/lowAIC.pdf")
barplot(lowAIC, xlab="Model name",ylab = "Count", 
        names.arg = c("Linear", "Logistic", "Gompertz", "Baranyi"))
dev.off()

#count which model fits the most data
cs <- sum(!is.na(h$Linear))
ls <- sum(!is.na(h$Logistic))
gs <- sum(!is.na(h$Gompertz))
bs <- sum(!is.na(h$Baranyi))
numfit <- c(cs,ls,gs,bs)
numfit

#save numfit to bar chart pdf
pdf("../results/numfit.pdf")
barplot(numfit, xlab="Model name",
       ylab = "Count",
       names.arg = c("Linear", "Logistic", "Gompertz", "Baranyi"))
dev.off()

#remove NA values to calculate AIC weights
noempty <- aic_results %>% filter(if_any(everything(), ~ !is.na(.)))

#add AIC weights to a new df
lol <- data.frame(matrix(ncol = 4, nrow = length(noempty)))
for (i in 1:nrow(noempty)){
    here <- akaike.weights(noempty[i,])$weights
    if (length(here) == 4){
        lol[i,1:4] <- here
    }
    else if(length(here) == 3) {
        lol[i,1:3] <- here}
    else if(length(here) == 2) {
        lol[i,1:2] <- here}
    else{
        lol[i,1] <- here}
}

#find highest AIC weights
mqa <- transform(lol, best = pmax(X1,X2,X3,X4,na.rm=TRUE))

#identify best model with highest AIC weights for each species
mqa$best <- as.character(mqa$best)
mqa <- mqa %>% mutate(best = case_when(best == X1 ~ "Linear", TRUE ~ best),
                    best = case_when(best == X2 ~ "Logistic", TRUE ~ best),
                    best = case_when(best == X3 ~ "Gompertz", TRUE ~ best),
                    best = case_when(best == X4 ~ "Baranyi", TRUE ~ best))
colnames(mqa) <- c("Linear", "Logistic", "Gompertz", "Baranyi","best")

#ratio of high AIC weights/successful fits
cw <- (length(which(mqa$best == "Linear")))/cs
lw <- (length(which(mqa$best == "Logistic")))/ls
gw <- (length(which(mqa$best == "Gompertz")))/gs
bw <- (length(which(mqa$best == "Baranyi")))/bs
ratio <- c(cw,lw,gw,bw)
ratio

#save ratio results to bar chart pdf
pdf("../results/ratio.pdf")
barplot(ratio, xlab="Model name",
       ylab = "Count",
       names.arg = c("Linear", "Logistic", "Gompertz", "Baranyi"))
dev.off()

#draw boxplot of the AIC weights
df.m <- reshape2::melt(mqa[,1:4], id.vars = NULL, na.rm = TRUE)
pdf("../results/aicw.pdf")
ggplot(df.m, aes(x = variable, y = value)) +
  labs(y ="Count", x="Model name") +
  geom_boxplot() 
dev.off()