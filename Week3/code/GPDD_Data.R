# Author: An (an.nguyen21@imperial.ac.uk)
# Script: GPDD_Data.R
# Created: Oct 2021
# A world map which has data in GPDD superimposed on top.

rm(list = ls())

require(maps)

# load GPDD data
load("../data/GPDDFiltered.RData")

# draw the map
map('world')

#superimpose points
points(gpdd$long, gpdd$lat, pch=1, col="red", cex=0.6)

#Bias: majority of data were collected from West Coast of North America and Europe. 