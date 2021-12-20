# CMEE 2021 HPC excercises R code main pro forma
# you don't HAVE to use this but it will be very helpful.  If you opt to write everything yourself from scratch please ensure you use EXACTLY the same function and parameter names and beware that you may loose marks if it doesn't work properly because of not using the proforma.

name <- "An Nguyen"
preferred_name <- "An"
email <- "an.nguyen21@imperial.ac.uk"
username <- "atn21"

# please remember *not* to clear the workspace here, or anywhere in this file. If you do, it'll wipe out your username information that you entered just above, and when you use this file as a 'toolbox' as intended it'll also wipe away everything you're doing outside of the toolbox.  For example, it would wipe away any automarking code that may be running and that would be annoying!

# Question 1
species_richness <- function(community){
  #count unique occurrence
  return (length(unique(community)))
}
# species_richness(c(1,4,4,5,1,6,1))

# Question 2
init_community_max <- function(size){
  #print vector with length equals to size, increment of 1 
  return (seq(size))
}
# init_community_max(7)

# Question 3
init_community_min <- function(size){
  #print out 1 "size" number of times 
  get_num <- seq(size)
  ini_state <- replace(get_num, get_num != 1, 1)
  return(ini_state)
}
#init_community_min(4)

# Question 4
choose_two <- function(max_value){
  #return 2 random values
  sample(1:max_value, 2, replace = FALSE)
}
#choose_two(4)

# Question 5
neutral_step <- function(community){
  #replace a value with another value in the same vector
  index <- choose_two(length(community))
  community[index[1]] <- community[index[2]]
  return (community)
}
#neutral_step(c(10,5,13))

# Question 6
neutral_generation <- function(community){
  rate <- round(length(community)/2) #how many generations
  for (i in 1:rate){
    community <- neutral_step(community) #change community after each generation
  }
  return(community)
}
#neutral_generation(c(10,5,13))

# Question 7
neutral_time_series <- function(community,duration)  {
  #return species richness at each generation of the simulation run
  #starting with the initial condition species richness
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
  #a time series graph of the neutral model simulation from an initial condition 
  #of maximal diversity in a system size of 100 individuals
  graphics.off() # clear any existing graphs and plot your graph within the R window
  y <- neutral_time_series (community = init_community_max(100) , duration = 200) 
  x <- c(1:201)
  plot(x,y, main="Species richness over time", ylab="Species Richness", xlab="Generations")
  return("Given enough time, the system converges into mondominance 
         i.e only one species is found")
}

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
  #performs a step of a neutral model with speciation. In each time step, 
  #speciation will replace a dead individual with a new species 
  #(with probability speciation_rate), otherwise the dead individual is replaced
  #with the offspring of another individual as before in neutral_step. 
  probability <- runif(1)
  index <- choose_two(length(community))
  if (probability <= speciation_rate){ #new species introduced
    new <- max(community) + 1
    community[index[1]] <- new
  }
  else{
    community[index[1]] <- community[index[2]] #offspring of another individual
  }
  return (community) 
}
#neutral_step_speciation(c(4,7,13,8), 0.2)

# Question 10
neutral_generation_speciation <- function(community,speciation_rate)  {
  #perform neutral_step and return the state of the community at the end of the generation
  rate <- round(length(community)/2)
  for (i in 1:rate){
    community <- neutral_step_speciation(community,speciation_rate)
  }
  return(community)
}
#neutral_generation_speciation(c(4,7,13,8), 0.2)

# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
  #perform species richness over time with speciation rate
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
  #perform a neutral theory simulation with speciation and 
  #plot species richness against time. Use a speciation rate of 0.1, a
  #community size of 100 and run your simulation for 200 generations. 
  #Plot two time series on the same axes in different colours showing 
  #how the simulation progresses from two different initial states given by 
  #init_community_max and init_community_min. 
  
  graphics.off() # clear any existing graphs and plot your graph within the R window
  min <- neutral_time_series_speciation(init_community_min(100), 0.1, 200)
  max <- neutral_time_series_speciation(init_community_max(100), 0.1, 200)
  x <- c(1:201)
  par(mar=c(5.1, 4.1, 4.1, 8.1), xpd=TRUE)
  plot(x,max, main="Species richness over time", 
       ylab="Species Richness", xlab="Generations", 
       col = "blue")
  par(new = TRUE)
  plot(x,min, main="Species richness over time", 
       ylab="", xlab="", xaxt = "n", yaxt = "n", 
       col = "red")
  legend("topright", inset=c(-0.2,0), legend = c("Max", "Min"), col = c("blue","red"), pch=1, cex=0.8)
  return("Starting with minimum initial conditions results in higher species richnes than when starting with maximum initial condition. However, because the same speciation rate and generation length were used for both initial startign conditions, they both have similar patterns.")
}

# Question 13
species_abundance <- function(community)  {
  #count number of times a value is present in the vector
  good <- as.numeric(sort(table(community),decreasing = TRUE))
  return(good)
}
#species_abundance(c(1,5,3,6,5,6,1,1))

# Question 14
octaves <- function(abundance_vector) {
  #sort species abundance into bin 
  abundance <- log2(abundance_vector) #log2 as a rough approximation to the natural logarithm
  floor <- floor(abundance) + 1
  class <- tabulate(floor)
  return(class)
}
#octaves(c(100,64,63,5,4,3,2,2,1,1,1,1)) 

# Question 15
sum_vect <- function(x, y) {
  # accepts two vectors as inputs, x and y, and returns their sum, 
  #after filling whichever of the vectors that is shorter with zeros 
  #to bring it up to the correct length
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
  #run a neutral model simulation using the same parameters as in question 12 
  #for a ‘burn in’ period of 200 generations. Next record the species abundance octave vector. 
  #Then repeatedly continue the simulation from where you left off for a further 
  #2000 generations, and record the species abundance octave vector every 20 generations. 
  #Your function should produce a bar chart plot of the mean species abundance distribution (as octaves).
 
  graphics.off()# clear any existing graphs and plot your graph within the R window
  max <- init_community_max(100)
  min <- init_community_min(100)
  for (i in 1:200){ #burn in period of 200 generations
    max <- neutral_generation_speciation(max, 0.1) 
    min <- neutral_generation_speciation(min, 0.1)
  }
  bin_max <- octaves(species_abundance(max))
  bin_min <- octaves(species_abundance(min))
  for (i in 1:2000){ #run 2000 simulations after burn in
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
            at minimum possible number of species", cex.main=0.8, col="red")

 barplot(mean_max,
          main = "Mean species abundance distribution 
                  at maximum possible number of species", cex.main=0.8, col="blue")
  return("type your written answer here")
}

# Question 17
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, 
                        interval_oct, burn_in_generations, output_file_name)  {
    community <- init_community_min(size)
    ab <- c() #time_series
    oc <- list() #octaves
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
#cluster_run(speciation_rate = 0.1, size=100, wall_time=0.001, interval_rich=1,
#interval_oct=10, burn_in_generations=200,output_file_name="my_test_file_1.rda")

# Questions 18 and 19 involve writing code elsewhere to run your simulations on the cluster

# Question 20 
process_cluster_results <- function()  {
  mydir <- "~/Documents/CMEECourseWork/HPC/RDA"
  myfiles <- list.files(path=mydir, pattern="*.rda", full.names=TRUE)
  all_oc <- c()
  oc_500 <- c()
  oc_1000 <- c()
  oc_2500 <- c()
  oc_5000 <- c()
  c_500 <- 0
  c_1000 <- 0
  c_2500 <- 0
  c_5000 <- 0
  suppressWarnings(for (f in myfiles){
    load(f)
    burn_in <- burn_in_generations/interval_oct
    for (o in length(oc)){
      all_oc <- sum_vect(all_oc, oc[[o > burn_in]])
      oc_len <- length(all_oc)
    }
    if (size == 500){
      oc_500 <- sum_vect(oc_500, all_oc)
      c_500 <- c_500 + oc_len
    }
    else if (size == 1000){
      oc_1000 <- sum_vect(oc_1000, all_oc)
      c_1000 <- c_1000 + oc_len
    }
    else if (size == 2500){
      oc_2500 <- sum_vect(oc_2500, all_oc)
      c_2500 <- c_2500 + oc_len
    }
    else if (size == 5000){
      oc_5000 <- sum_vect(oc_5000, all_oc)
      c_5000 <- c_5000 + oc_len
    }
  })
  final_oc_500 <- oc_500/c_500
  final_oc_1000 <- oc_1000/c_1000
  final_oc_2500 <- oc_2500/c_2500
  final_oc_5000 <- oc_5000/c_5000
}

plot_cluster_results <- function()  {
    # clear any existing graphs and plot your graph within the R window
    # load combined_results from your rda file
    # plot the graphs
  graphics.off()
  par(mfrow = c(2,2))
  barplot(final_oc_500, main = "Community size 500",
          xlab = "Species abundance octaves",
          ylab = "Species  richness",
          col = "#009E73")
  barplot(final_oc_1000, main = "Community size 1000",
          xlab = "Species abundance octaves",
          ylab = "Species  richness",
          col = "#E69F00")
  barplot(final_oc_2500, main = "Community size 2500",
          xlab = "Species abundance octaves",
          ylab = "Species  richness",
          col = "#D55E00")
  barplot(final_oc_5000, main = "Community size 5000",
          xlab = "Species abundance octaves",
          ylab = "Species  richness",
          col = "#56B4E9")
  combined_results <- list(final_oc_500,
                           final_oc_1000,
                           final_oc_2500,
                           final_oc_5000) #list output for octaves of each community size
  save(combined_results, file = "atn21_cluster_2021_results.rda")
  return(combined_results)
}

# Question 21
question_21 <- function()  {
  D <- log(8)/log(3)
  return("8 self-similar pieces, each piece is 1/3 the size of the original piece")
}

# Question 22
question_22 <- function()  {
  D <- log(20)/log(3)
  return("type your written answer here")
}

# Question 23
chaos_game <- function()  {
  # clear any existing graphs and plot your graph within the R window
  pt <- data.frame(A=c(0,0),B=c(3,4),C=c(4,1))
  x <- c(0,0)
  plot(x, type = "n", ylab = "", xlab = "", xlim = c(0,5), ylim = c(0,5))
  points(0,0,cex = 0.1)
  for (i in 1:5000){
    rd <- pt[, sample(ncol(pt), size=1)]
    x[1] <- x[1] + (rd[1]-x[1])/2
    x[2] <- x[2] + (rd[2]-x[2])/2
    points(x[1],x[2])
  }
  return("Sierpiński triangle")
}

# Question 24
turtle <- function(start_position, direction, length)  {
  #plot(0, 0, ylab = "", xlab = "", xlim = c(0,5), ylim = c(0,5)) 
  sp1 <- start_position[1]
  sp2 <- start_position[2]
  np1 <- length * cos(direction) + sp1
  np2 <- length * sin(direction) + sp2
  segments(sp1, sp2, np1, np2, col = "#009E73")
  return(c(np1,np2))# you should return your endpoint here.
}
#turtle(start_position = c(0,0), direction = (pi/3), length = 5)

# Question 25
elbow <- function(start_position, direction, length)  {
  sec_line_start <- turtle(start_position, direction, length)
  sec_line_dir <- direction - (pi/4) 
  sec_line_len <- length * 0.95
  sec_line <- turtle(sec_line_start, sec_line_dir, sec_line_len)
  return(sec_line)
}
#elbow(start_position = c(0,0), direction = (pi/3), length = 5)

# Question 26
spiral <- function(start_position, direction, length)  {
  line_start <- turtle(start_position, direction, length)
  line_dir <- direction - (pi/4) 
  line_len <- length * 0.95
  if (line_len > 0.01){
    spiral(line_start, line_dir, line_len) 
  }
}

#Question 27
draw_spiral <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  empty_pt <- c()
  plot(empty_pt, ylab = "", xlab = "", xlim = c(0,15), ylim = c(-6,8))
  spiral(start_position = c(0,0), direction = (pi/3), length = 5)
  print("Too much recursion, encountered Error: C stack usage  7971092 is too close to the limit")
}

# Question 28
tree <- function(start_position, direction, length)  {
  line_start <- turtle(start_position, direction, length)
  line_dir_right <- direction - (pi/4) 
  line_dir_left <- direction + (pi/4)
  line_len <- length * 0.65
  if (line_len > 0.1){
    tree(line_start, line_dir_right, line_len) 
    tree(line_start, line_dir_left, line_len)
  }
}

draw_tree <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  empty_pt <- c()
  plot(empty_pt, ylab = "", xlab = "", xlim = c(-4,15), ylim = c(-4,15))
  tree(start_position = c(0,0), direction = (pi/3), length = 5)
}

# Question 29
fern <- function(start_position, direction, length)  {
  line_start <- turtle(start_position, direction, length)
  line_dir_left <- direction + (pi/4) 
  line_dir_str <- direction
  line_len_left <- length * 0.38
  line_len_str <- length * 0.87
  if (line_len_left > 0.01){
    fern(line_start, line_dir_left, line_len_left) 
    fern(line_start, line_dir_str, line_len_str)
  }
}

draw_fern <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  empty_pt <- c()
  plot(empty_pt, ylab = "", xlab = "", xlim = c(-4,35), ylim = c(-4,35))
  fern(start_position = c(0,0), direction = (pi/3), length = 5)
}

# Question 30
fern2 <- function(start_position, direction, length, dir)  {
  line_start <- turtle(start_position, direction, length)
  line_dir_str <- direction
  left_right <- direction + dir * (pi/4) 
  line_len_lr <- length * 0.38
  line_len_str <- length * 0.87
  if (line_len_lr > 0.013){
    fern2(line_start, left_right, line_len_lr,dir) 
    fern2(line_start, line_dir_str, line_len_str,-dir)
  }
}

draw_fern2 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  empty_pt <- c()
  plot(empty_pt, ylab = "", xlab = "", xlim = c(-4,25), ylim = c(-4,40))
  fern2(start_position = c(0,0), direction = (pi/3), length = 5, dir = 1)
}

# Challenge questions - these are optional, substantially harder, and a maximum of 16% is available for doing them.  

# Challenge question A
Challenge_A <- function() {
  # clear any existing graphs and plot your graph within the R window
}

# Challenge question B
Challenge_B <- function() {
  # clear any existing graphs and plot your graph within the R window

}

# Challenge question C
Challenge_C <- function() {
  # clear any existing graphs and plot your graph within the R window

}

# Challenge question D
Challenge_D <- function() {
  # clear any existing graphs and plot your graph within the R window
  
  return("type your written answer here")
}

# Challenge question E
Challenge_E <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  par(mfrow = c(1,3))
  pte <- data.frame(A=c(0,0),B=c(3,4),C=c(4,1))
  xe <- c(4,3)
  plot(xe, type = "n", ylab = "", xlab = "", xlim = c(0,5), ylim = c(0,5), 
       main = "Different initial position x", cex = 0.3)
  points(0,0, cex = 0.1)
  #first 30 steps of n
  for (i in 1:30){
    rde <- pte[, sample(ncol(pte), size=1)]
    xe[1] <- xe[1] + (rde[1]-xe[1])/2
    xe[2] <- xe[2] + (rde[2]-xe[2])/2
    points(xe[1],xe[2],col="#009E73")
  }
  #continue with 5000 more steps
  xe <- c(xe[1],xe[2])
  for (i in 1:5000){
    rde <- pte[, sample(ncol(pte), size=1)]
    xe[1] <- xe[1] + (rde[1]-xe[1])/2
    xe[2] <- xe[2] + (rde[2]-xe[2])/2
    points(xe[1],xe[2],col="#E69F00")
  }
  #starting with points as equilateral triangle
  pte1 <- data.frame(A=c(0,0),B=c(4,4),C=c(0,8))
  xe1 <- c(0,0)
  plot(xe1, type = "n", ylab = "", xlab = "", xlim = c(0,5), ylim = c(0,10),
       main = "Starting points form an equilateral triangle", cex = 0.3)
  points(0,0, cex = 0.1)
  for (i in 1:5000){
    rde1 <- pte1[, sample(ncol(pte1), size=1)]
    xe1[1] <- xe1[1] + (rde1[1]-xe1[1])/2
    xe1[2] <- xe1[2] + (rde1[2]-xe1[2])/2
    points(xe1[1],xe1[2],col="#D55E00")
  }
  #4 starting points
  pte1 <- data.frame(A=c(0,0),B=c(3,4),C=c(4,1),D=c(5,6))
  xe1 <- c(0,0)
  plot(xe1, type = "n", ylab = "", xlab = "", xlim = c(0,5), ylim = c(0,10),
       main = "4 starting points", cex = 0.3)
  points(0,0, cex = 0.1)
  for (i in 1:5000){
    rde1 <- pte1[, sample(ncol(pte1), size=1)]
    xe1[1] <- xe1[1] + (rde1[1]-xe1[1])/2
    xe1[2] <- xe1[2] + (rde1[2]-xe1[2])/2
    points(xe1[1],xe1[2],col="#56B4E9")
  }
  return("type your written answer here")
}

# Challenge question F
Challenge_F <- function() {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  x <- c(0.005, 0.013, 0.1)
  co <- c("#009E73","#E69F00","#D55E00")
  par(mfrow=c(1,3))
  for (i in 1:3){
    turtlef <- function(start_position, direction, length)  {
      sp1 <- start_position[1]
      sp2 <- start_position[2]
      np1 <- length * cos(direction) + sp1
      np2 <- length * sin(direction) + sp2
      segments(sp1, sp2, np1, np2, col=co[i])
      return(c(np1,np2))
    }
    fern2f <- function(start_position, direction, length, dir){
      line_start <- turtlef(start_position, direction, length)
      line_dir_str <- direction
      left_right <- direction + dir * (pi/4) 
      line_len_lr <- length * 0.38
      line_len_str <- length * 0.87
      if (line_len_lr > x[i]){
          fern2f(line_start, left_right, line_len_lr,dir) 
          fern2f(line_start, line_dir_str, line_len_str,-dir)
      }
    }
    draw_fern2f <- function()  {
      # clear any existing graphs and plot your graph within the R window
      empty_pt <- c()
      plot(empty_pt, ylab = "", xlab = "", xlim = c(-4,25), ylim = c(-4,40),
           main = paste("Line threshold of:",x[i]), cex.main=0.8)
      fern2f(start_position = c(0,0), direction = (pi/3), length = 5, dir = 1)
    }
    draw_fern2f() #merry christmas
  }
  return("type your written answer here")

}

# Challenge question G should be written in a separate file that has no dependencies on any functions here.


