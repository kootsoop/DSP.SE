#30956

N <- 5

omega <- seq(-pi,pi,0.01*pi)

sinc <- function(omega, N)
{
  eps <- 10^-56
  return( sin(omega*N/2)/(omega/2 + eps) )
}

asinc <- function(omega, N)
{
  eps <- 10^-56
  return( sin(omega*N/2)/sin(omega/2 + eps) )
}


par(mfrow=c(2,1))
plot(omega, sinc(omega,N), type="l")
lines(omega, asinc(omega,N), col="red")

plot(sinc(omega,N) / asinc(omega,N), type="l" ) 