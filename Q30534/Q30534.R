#30534
T <- 1000
white_noise <- rnorm(T,0,1)

K <- array(seq(1,5),c(5,1)) %*% array(1,c(1,T))
omega <- 2*pi*0.053492384
t <- array(seq(0,T-1), dim=c(1,T))
t <- array(1,c(5,1)) %*% t
harmonic <- colSums(sin(omega*K*t))

spectral_entropy <- function(signal)
{
  psd <- abs(fft(signal))^2
  psd <- psd/sum(psd)
  
  pse <- 0
  for (ix in seq(1,length(psd)))
  {
    pse <- pse - psd[ix]*log(psd[ix])
  }
  
  return(pse)
}

flatness <- function(signal)
{
  psd <- abs(fft(signal))^2
  psd <- psd/sum(psd)
  
  flatness <- 0
  for (ix in seq(1,length(psd)))
  {
    flatness <- flatness + log(psd[ix])/length(psd)
  }
  return (exp(flatness))
}

sharpness <- function (signal)
{
  psd <- abs(fft(signal))^2
  psd <- psd/sum(psd)
  
  sharpness <- 0
  for (ix in seq(1,length(psd)))
  {
    sharpness <- sharpness + psd[ix] * exp(1i*2*pi*(ix-1)/length(psd))
  }
  return (abs(sharpness))
}


P <- 100
pse <- rep(0,P)
flt <- rep(0,P)
shp <- rep(0,P)
sd <- rep(0,P)
for (alpha in seq(0,P))
{
  signal <- white_noise*(alpha/P) + (1-alpha/P)*harmonic
  pse[alpha+1] <- spectral_entropy(signal)
  flt[alpha+1] <- flatness(signal)
  shp[alpha+1] <- sharpness(signal)
  sd[alpha+1] <- sqrt(var(abs(fft(signal))^2))
}

normalize <- function(signal)
{
 return( (signal - min(signal))/(max(signal) - min(signal)))
}

layout(matrix(c(1,2,3,3), 2, 2, byrow = TRUE))
plot(abs(fft(harmonic)), type="l", col="blue")
title("Harmonic Spectrum")
plot(abs(fft(white_noise)), type="l", col="blue")
title("White Noise Spectrum")

plot(seq(0,P)/P, normalize(pse), type="l", col="blue")
lines(seq(0,P)/P, normalize(flt), type="l", col="red")
lines(seq(0,P)/P, normalize(shp), type="l", col="green")
lines(seq(0,P)/P, normalize(sd), type="l", col="grey")
title('Comparison of PSE vs Flatness vs Sharpness vs SD')

