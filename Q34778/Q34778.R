#34778
#install.packages('SynchWave')
require(SynchWave)

with_mean_ccf <- function(f,g)
{
  length <- length(f) + length(g) - 1
  
  ff <- c(f, rep(0,length - length(f) + 1))
  gg <- c(f, rep(0,length - length(g) + 1))
  
  FF <- fft(ff)
  GG <- fft(gg)
  
  ccf <- fft(FF * Conj(GG), inverse = TRUE)
  
  return(fftshift(Re(ccf)))
}

T <- 1000
mu_f <- 1
mu_g <- 2

f <- rnorm(T,1) + mu_f
g <- rnorm(T,1) + mu_g


with_mean <- with_mean_ccf(f,g)
no_mean <- with_mean_ccf(f-mean(f), g-mean(g))
plot(with_mean)
points(no_mean, col='red')
title('Sample crosscorrelation with (red) and without (black) mean subtraction')


a <- rnorm(T,1) + seq(1,T)/3
b <- rnorm(T,1) + seq(1,T)/2

with_mean_and_trend <- with_mean_ccf(a,b)
no_mean_and_trend <- with_mean_ccf(a-mean(a),b-mean(b))

plot(with_mean_and_trend, ylim=c(min(with_mean_and_trend,no_mean_and_trend), max(with_mean_and_trend,no_mean_and_trend)) )
points(no_mean_and_trend, col="red")
title('Sample cross-correlation of two linear trend signals')

