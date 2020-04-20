# 30465
library(signal)
N <- 10000

omega <- 2*pi*1234.5/N
phi <- 2*pi*0.9878992344

window <- hamming(seq(0,N-1),N)

x <- sin(omega*seq(0,N-1) + phi)

X <- abs(fft(c(x*window,rep(0,2*N))))
logX <- log(X)
         
plot(logX[1:N/2], type="l")