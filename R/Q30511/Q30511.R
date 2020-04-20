#30511

pulse <- 16 - seq(-4,4)^2
len <- length(pulse)

T <- 1000
P <- 49

ix <- seq(1,T - len, P)

data <- rep(0,T)

for (this_one in ix)
{
  data[this_one + seq(0,len-1)] <- pulse
}

data <- data #+ rnorm(T,0,1)

plot(data, type="l")

asdf <- function(data, Pmax)
{
  N <- length(data)
  asdf <- rep(0,Pmax)
  for (p in seq(1,Pmax))
  {    
    ix <- seq(p+1,N)
    asdf[p] <- sum((data[1:length(ix)] - data[ix])^2)
  }
  
  return(asdf)
}

calc <- asdf(data, 5*P)

par(mfrow=c(2,1))
plot(data, type="l")
title('Repeating pulses')

plot(1:(5*P), calc, type="l")
period <- which.min(calc)
points(P, calc[P], col="grey", lwd = 12)
points(period, calc[period], col="red", lwd = 5)
title('ASDF')