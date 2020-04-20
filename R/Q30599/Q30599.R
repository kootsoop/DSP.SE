# 30599

N <- 1024
k <- 8
d <- 16
a <- 1
b <- 5
X <- rep(0,N)
X_p <- sample(N, k)
X_v1 <- runif(k)
X_v <- a*X_v1 + b
X[X_p] <- X_v
x <- fft(X, inverse = TRUE)
x1 <- 0.1
x2 <- 0.5

X_re <- rep(0,N)

library(signal)

sss <- 4
xd <- array(0, c(sss,N/sss))
XD <- array(0, c(sss,N/sss))
for (l in seq(1,sss))
{
  re <- decimate(Re(x[seq(l,N-l+1)]), sss)
  im <- decimate(Im(x[seq(l,N-l+1)]), sss)
  
  xd[l,seq(1,length(re))] <- re + 1i*im
  XD[l,] <- fft(xd[l,])
}


