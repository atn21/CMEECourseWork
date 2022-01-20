# CMEE 2021 HPC excercises R code HPC run code pro forma

rm(list=ls()) # good practice 
graphics.off()
#source("/rds/general/user/atn21/home/HPC/atn21_HPC_2021_main.R")
source("atn21_HPC_2021_main.R")  # source file 
iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX")) #get iter to set community size
if ((iter >= 1) & (iter <= 25)){
  size = 500
}
if ((iter > 25) & (iter <= 50)){
  size = 1000
}
if ((iter > 50) & (iter <= 75)){
  size = 2500
}
if ((iter > 75) & (iter <= 100)){
  size = 5000
}

speciation_rate <- 0.0028133 
wall_time <- 11.5*60
output_file_name <- paste("Cluster_iter_no_",iter,".rda",sep ="")
# call cluster_run function with personal speciation_rate = 0.0028133
cluster_run(speciation_rate, size, wall_time, interval_rich = 1, interval_oct = size/10, burn_in_generations = 8*size, output_file_name)