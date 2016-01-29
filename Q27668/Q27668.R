#27668

# Plot the data generated
plot_track <- function (xx,zz)
{
  plot(xx[,1],xx[,2], type="l")
  
  for (t in 1:T)
  {
    points(zz[t,1], zz[t,2], col="red", pch=18)
    points(zz[t,3], zz[t,4], col="green", pch=18)
    points(zz[t,5], zz[t,6], col="yellow", pch=18)
    points(zz[t,7], zz[t,8], col="blue", pch=18)
  }
  
  points(xx[1,1],xx[1,2],col="magenta",lwd=20, pch=5)
  points(xx[T,1],xx[T,2],col="orange",lwd=20)
}

# From a single x-y track, create all the locations for all the LED location measurements.
# Note that this just takes account of YAW, not pitch and roll.
create_measurements <- function(x,y,radius,yaw)
{
  measurements <- c(x,y+radius,x,y-radius,x+radius,y,x-radius,y)
  dim(measurements) <- c(2,4)
  
  yaw <- c(cos(yaw), -sin(yaw), sin(yaw), cos(yaw))
  dim(yaw) <- c(2,2)
  
  measurements <- yaw %*% measurements
  
  # Reshape for later use in rbind
  dim(measurements) <- c(1,8)
  
  return(measurements)
}

# GIven the true (x,y) tracks in x, create the locations of the four LEDs
create_all_tracks <- function(tracks, radius)
{
   led_tracks <- data.frame(x1 = numeric(0), y1 = numeric(0), x2 = numeric(0), y2 = numeric(0), x3 = numeric(0), y3 = numeric(0), x4 = numeric(0), y4 = numeric(0))
  for (t in 1:T)
  {
    led_tracks[t,] <- create_measurements(tracks[t,1], tracks[t,2], radius, tracks[t,3]);
  }
  
  return(led_tracks)
}

# Generation of the original data, Don't do it if z exists.
#if (FALSE == exists("led_tracks_true"))
{
  radius <- 0.1 # Radius of each LED ring
  
  Nstate <- 3 # States are X,Y, RYaw Angle
  x0 <- rep(0,Nstate) #The state vector starts at all zeros
  
  sigmas <- c(0.1,0.1,0.001)
  Q <- diag(sigmas)
  
  T <- 1000
  x_true <- rep(0,Nstate*T) # The true states
  dim(x_true) <- c(T,Nstate)
  
  #A = [ 1 dt dt^2/2 0 
  #      0  1     dt 0 
  #      0  0      1 0
  #      0  0      0 1];
  dt <- 0.1
  A <- matrix(c(1,0,0,0,dt,1,0,0,dt^2/2,dt,1,0,0,0,0,1),4,4)
  B <- matrix(c(0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1),4,4)
  
  true_acceleration <- rnorm(T,0,1)  
  
  for (t in 1:(T-1))
  {
    for (n in 1:Nstate)
    {
      x_true[t+1,n] <- x_true[t,n] + rnorm(1,0, sigmas[n])
    }
  }
  
  led_tracks_true <- create_all_tracks(x_true,radius)
  
  plot_track(x_true,led_tracks_true)
}

# Generate the measurements by adding some noise to the true led tracks
n_measurements <- 8
measurement_sigmas <- rep(0.1,n_measurements)
R <- diag(measurement_sigmas)

led_tracks_measured <-  rep(0,n_measurements*T) 
dim(led_tracks_measured) <- c(T,n_measurements)

for (t in 1:(T-1))
{
  for (n in 1:n_measurements)
  {
    led_tracks_measured[t+1,n] <- led_tracks_true[t,n] + rnorm(1,0, measurement_sigmas[n])
  }
}

# Pick some times where we have an occluded LED
n_occlusions <- 50
occlusion_times <- sample(1:T, n_occlusions)
occlusion_leds <-  sample(1:4,T, replace = TRUE)

led_tracks_measured[occlusion_times, occlusion_leds] <- NA

# Attempt #1 : Just average the locations of the four LED tracks.
# When an LED is occluded, just ignore that measurement and average
# the remaining three LED locations.
est_avg <- rep(0,2*T) 
dim(est_avg) <- c(T,2)

for (t in 1:T)
{
  est_avg[t,1] <- mean(led_tracks_measured[t,c(1,3,5,7)], na.rm = TRUE)
  est_avg[t,2] <- mean(led_tracks_measured[t,c(2,4,6,8)], na.rm = TRUE)
}

#plot(est_avg - x_true[,1:2])

# Attempt #2 : An EKF approach?



