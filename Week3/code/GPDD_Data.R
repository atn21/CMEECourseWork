rm(list=ls())

require(maps)

load("../data/GPDDFiltered.RData")

map('world')

points(gpdd$long, gpdd$lat, pch=1, col="red", cex=0.6)

#Bias: majority of data were collected from West Coast of North America and Europe. 