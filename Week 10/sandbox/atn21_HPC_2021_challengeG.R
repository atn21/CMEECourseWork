# CMEE 2021 HPC excercises R code challenge G pro forma

rm(list=ls()) # nothing written elsewhere should be needed to make this work

# please edit these data to show your information.
name <- "An Nguyen"
preferred_name <- "An"
email <- "an.nguyen21@imperial.ac.uk"
username <- "atn21"

# don't worry about comments for this challenge - the number of characters used will be counted starting from here

frame();f=function(s,d,l,i){
  o=c(l*cos(d)+s[1],l*sin(d)+s[2]);segments(s[1],s[2],o[1],o[2]);
  (l>.013)?(f(o,d-i*(pi/4),l*.38,i)&&f(o,d,l*.87,i));f(c(0,0),pi/3,.1,1)}