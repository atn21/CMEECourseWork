# Author: An (an.nguyen21@imperial.ac.uk)
# Script: DataWrangTidy.R
# Created: Oct 2021
#Use tidyverse for the data wrangling component in DataWrang.R.

rm(list = ls())
require(tidyverse)

#Load the dataset
# header = false because the raw data don't have real headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE))

# header = true because we do have metadata headers
MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";")

#Inspect the dataset 
head(MyData)
dim(MyData)
str(MyData)
fix(MyData) #you can also do this
fix(MyMetaData)

#Transpose 
# To get those species into columns and treatments into rows 
MyData <- t(MyData) 
head(MyData)
dim(MyData)

#Replace species absences with zeros 
MyData[MyData == ""] = 0

#Convert raw matrix to data frame 
TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data

#convert wide to long format with tidyr
MyWrangledData <- TempData %>% 
    gather(Species, Count, -Cultivation, -Block, -Plot, -Quadrat)

#set Cultivation, Block, Plot, Quadrat columns as factors and count as numeric with dplyr
MyWrangledData <- MyWrangledData %>% mutate(across(c(Cultivation, Block, Plot, Quadrat), as.factor)%>%mutate(Count = as.integer(Count)))

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

#Exploring the data 
MyWrangledData <- tibble::as_tibble(MyWrangledData)