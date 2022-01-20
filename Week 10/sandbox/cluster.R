# CMEE 2021 HPC excercises R code main pro forma
# you don't HAVE to use this but it will be very helpful.  If you opt to write everything yourself from scratch please ensure you use EXACTLY the same function and parameter names and beware that you may loose marks if it doesn't work properly because of not using the proforma.

name <- "An Nguyen"
preferred_name <- "An"
email <- "an.nguyen21@imperial.ac.uk"
username <- "atn21"

# please remember *not* to clear the workspace here, or anywhere in this file. If you do, it'll wipe out your username information that you entered just above, and when you use this file as a 'toolbox' as intended it'll also wipe away everything you're doing outside of the toolbox.  For example, it would wipe away any automarking code that may be running and that would be annoying!

# Question 1
species_richness <- function(community){
  return (length(unique(community)))
}
# species_richness(c(1,4,4,5,1,6,1))

# Question 2
init_community_max <- function(size){
  return (seq(size))
}
# init_community_max(7)

# Question 3
init_community_min <- function(size){
  get_num <- seq(size)
  ini_state <- replace(get_num, get_num != 1, 1)
  return(ini_state)
}

#init_community_min(4)

# Question 4
choose_two <- function(max_value){
  sample(1:max_value, 2, replace = FALSE)
}
#choose_two(4)

# Question 5
neutral_step <- function(community){
  index <- choose_two(length(community))
  community[index[1]] <- community[index[2]]
  return (community)
}
#neutral_step(c(10,5,13))

# Question 6
neutral_generation <- function(community){
  rate <- round(length(community)/2)
  for (i in 1:rate){
    community <- neutral_step(community)
  }
  return(community)
}
#neutral_generation(c(10,5,13))

# Question 7
neutral_time_series <- function(community,duration)  {
  rich <- species_richness(community)
  for (i in 1:duration){
    community <- neutral_generation(community)
    rich <- c(rich,species_richness(community))
  }
  return (rich)
}
#neutral_time_series(community = init_community_max(7) , duration = 20)

# Question 8
question_8 <- function() {
  # clear any existing graphs and plot your graph within the R window
  y <- neutral_time_series (community = init_community_max(100) , duration = 200) 
  x <- c(1:201)
  plot(x,y, main="Species richness over time", ylab="Species Richness", xlab="Generations")
  return("reach equi")
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
  probability <- runif(1)
  index <- choose_two(length(community))
  if (probability <= speciation_rate){
    new <- max(community) + 1
    community[index[1]] <- new
  }
  else{
    community[index[1]] <- community[index[2]]
  }
  return (community) 
}
#neutral_step_speciation(c(4,7,13,8), 0.2)

# Question 10
neutral_generation_speciation <- function(community,speciation_rate)  {
  rate <- round(length(community)/2)
  for (i in 1:rate){
    community <- neutral_step_speciation(community,speciation_rate)
  }
  return(community)
}
#neutral_generation_speciation(c(4,7,13,8), 0.2)

# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  rich <- species_richness(community)
  for (i in 1:duration){
    community <- neutral_generation_speciation(community,speciation_rate)
    rich <- c(rich,species_richness(community))
  }
  return (rich)
}
#neutral_time_series_speciation((c(4,7,13,8), 0.2))

# Question 12
question_12 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  min <- neutral_time_series_speciation(init_community_min(100), 0.1, 200)
  max <- neutral_time_series_speciation(init_community_max(100), 0.1, 200)
  x <- c(1:201)
  plot(x,max, main="Species richness over time", 
       ylab="Species Richness", xlab="Generations", 
       col = "blue", type ="l")
  par(new = TRUE)
  plot(x,min, main="Species richness over time", 
       ylab="", xlab="", xaxt = "n", yaxt = "n", 
       col = "red",type ="l")
  return("type your written answer here")
}

# Question 13
species_abundance <- function(community)  {
  good <- as.numeric(sort(table(community),decreasing = TRUE))
  return(good)
}
#species_abundance(c(1,5,3,6,5,6,1,1))

# Question 14
octaves <- function(abundance_vector) {
  abundance <- log2(abundance_vector)
  floor <- floor(abundance) + 1
  class <- tabulate(floor)
  return(class)
}
#octaves(c(100,64,63,5,4,3,2,2,1,1,1,1)) 

# Question 15
sum_vect <- function(x, y) {
  diff <- length(x) - length(y)
  if (diff < 0){
    length(x) <- length(y)
    x[is.na(x)] <- 0
  }
  else {
    length(y) <- length(x)
    y[is.na(y)] <- 0
  }
  return(x+y)      
}
#sum_vect(c(1,3),c(1,0,5,2))

# Question 16 
question_16 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  max <- init_community_max(100)
  min <- init_community_min(100)
  for (i in 1:200){ #burn in period of 200 generations
    max <- neutral_generation_speciation(max, 0.1) 
    min <- neutral_generation_speciation(min, 0.1)
  }
  bin_max <- octaves(species_abundance(max))
  bin_min <- octaves(species_abundance(min))
  for (i in 1:2000){
    max <- neutral_generation_speciation(max, 0.1)
    min <- neutral_generation_speciation(min, 0.1)
    if ((i %% 20) == 0) {
      bin_min <- sum_vect(bin_min,octaves(species_abundance(min)))
      bin_max <- sum_vect(bin_max,octaves(species_abundance(max)))
    }
  }
  par(mfrow=c(1,2)#,mai=c(0.5,0.5,0.4,0.3)#
  )
  mean_min <- bin_min/100
  mean_max <- bin_max/100
  barplot(mean_min,
          main = "Mean species abundance distribution 
            at minimum possible number of species", cex.main=0.8)
  
  barplot(mean_max,
          main = "Mean species abundance distribution 
                  at maximum possible number of species", cex.main=0.8)
  return("type your written answer here")
}

# Question 17
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, 
                        interval_oct, burn_in_generations, output_file_name)  {
  community <- init_community_min(size)
  ab <- c()
  oc <- list()
  wall_time <- wall_time*60
  tm <- proc.time()[[3]]
  i <- 1
  while (proc.time()[[3]] - tm <= wall_time){
    community <- neutral_generation_speciation(community, speciation_rate)
    if (i %% interval_rich == 0 && i < burn_in_generations){
      ab <- c(ab, species_richness(community))
    }
    if (i %% interval_oct == 0){
      oc <- append(oc, list(octaves(species_abundance(community))))
    }
    i <- i+1
  } 
  total_time <- proc.time()[3] - tm
  save(ab, oc, community, total_time, speciation_rate, size, wall_time, 
       interval_rich, interval_oct, burn_in_generations, file = output_file_name)
}
cluster_run(speciation_rate = 0.1, size=100, wall_time=0.001, interval_rich=1,
interval_oct=10, burn_in_generations=200,output_file_name="my_test_file_1.rda")
