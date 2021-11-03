# Author: An an.nguyen21@imperial.ac.uk
# Script: TreeHeight.R
# Desc: This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
# height = distance * tan(radians)
# Arguments: 2 (degrees:   The angle of elevation of tree
#               distance:  The distance from base of tree (e.g., meters))
# Output: The heights of the tree, same units as "distance"
# Date: Oct 2021

#clear workspace
rm(list = ls())

#read data
readfile <- read.csv("../data/trees.csv")

#calculate tree heights
TreeHeight <- function(degrees, distance){
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    return (height)
}

#add Tree Height column to readfile 
readfile$Tree.Height.m <- TreeHeight(readfile$Angle.degrees, readfile$Distance.m)

#save all data to csv file in results/
write.csv(readfile, "../results/TreeHts.csv", row.names=FALSE)



