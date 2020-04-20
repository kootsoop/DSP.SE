#install.packages('R.matlab')
library(R.matlab)

#test_data <- readMat('Q43876/test_data.mat')
#test_data_filt <- readMat('Q43876/test_data_filt.mat')


#par(mfrow=c(2,1))
#plot(test_data_filt$t.y, test_data_filt$y, col='red', type='l')
#points(test_data_filt$t.x[seq(1,1000000,50)], test_data_filt$x[seq(1,1000000,50)], type='l')

#plot(test_data$t.x[seq(1,1000000,50)], test_data$x[seq(1,1000000,50)], type='l')
#lines(test_data$t.y, test_data$y, col='red', type='l')


delayed_smoothed_step <- function(delay)
{
  N <-  10000
  C1 <- 1050
  C2 <- 850
  step_function <- c(rep(C1,N+delay), rep(C2,N-delay))
  
  alpha <- 0.999
  
  smoothed_step_function <- step_function
  
  for (t in seq(2,length(smoothed_step_function)))
  {
    smoothed_step_function[t] <- alpha*smoothed_step_function[t-1] + (1-alpha)*step_function[t-1]
  }
  
  return(smoothed_step_function)
}


dc_blocker <- function(x)
{
  alpha <- 0.1
  y <- rep(0,length(x))
  for (t in seq(2,length(x)))
  {
    y[t] <- alpha*y[t-1] + x[t] - x[t-1]
  }
  
  return(y)
}

s1 <- delayed_smoothed_step(0)
s2 <- delayed_smoothed_step(100)

n1 <- s1 + 100*rnorm(2*N)
n2 <- s2 + 100*rnorm(2*N)


ds1 <- dc_blocker(s1)
ds2 <- dc_blocker(s2)
dn1 <- dc_blocker(n1)
dn2 <- dc_blocker(n2)

par(mfrow=c(6,1))
plot(n1, col='red', type='l')
lines(s1)

plot(n2, col='red', type='l')
lines(s2)

ccf(s1[2:(2*N)]-s1[1:(2*N-1)],s2[2:(2*N)]-s2[1:(2*N-1)], lag.max=200)
ccf(ds1[2:(2*N)]-ds1[1:(2*N-1)],ds2[2:(2*N)]-ds2[1:(2*N-1)], lag.max=200)
ccf(ds1,ds2, lag.max=200)
ccf(n1[2:(2*N)]-n1[1:(2*N-1)],n2[2:(2*N)]-n2[1:(2*N-1)], lag.max=200)
#ccf(dn1[2:(2*N)]-dn1[1:(2*N-1)],dn2[2:(2*N)]-dn2[1:(2*N-1)], lag.max=200)
