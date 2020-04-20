#31044
T <- 1000
t <- 0:(T-1)
omega <- 2*pi*0.012391238
phi <- 2*pi*runif(1)
x <- sin(omega*t + phi)

par(mfrow=c(1,2))
plot(t,x, type="l", col="blue")
title("All of x")

window_function <- function(Nstart, Nup, Ntotal)
{
  return(c(rep(0,Nstart),rep(1,Nup), rep(0,Ntotal-Nup-Nstart)))
}

Nup <- 250

ffts <- array(0, dim=c(251,T))
for (Nstart in seq(0,250))
{
  x_windowed <- x * window_function(Nstart, Nup, T)
  ffts[Nstart+1,] <- abs(fft(x_windowed))
}