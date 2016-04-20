#30219

T <- 128
N <- 5

x <- rep(0, T)
x[sample(T,N)] <- rep(1,N)

X <- fft(x);
Xu <- rep(0, T)
Xu[seq(1,T,4)] <- X[seq(1,T,4)];
xu <- fft(Xu, inverse = TRUE)*4/T;

par(mfrow=c(2,2))
plot(x, type="l", lwd = 5, ylim = c(0,1.2))
lines(abs(xu), col="red")
title('Original (black) & reconstructed\n from uniform undersampling (red)')

Xr <- rep(0,T)
r_ix <- sample(T,T/4)
Xr[r_ix] <- X[r_ix]
xr <- fft(Xr, inverse = TRUE)*4/T

plot(x, type="l", lwd = 5, ylim = c(0,1.2))
lines(abs(xr), col="red")
#lines(Re(xr), col="blue")
#lines(Im(xr), col="green")
title('Original (black) & reconstructed\n from non-uniform undersampling (red)')

#soft thresh function

softThresh <- function(vals_to_threshold, lambda)
{
  ix <- which(abs(vals_to_threshold) < lambda)
  vals_to_threshold[ix] <- rep(0, length(ix))
  
  ix <- which(vals_to_threshold >= lambda)
  vals_to_threshold[ix] <- vals_to_threshold[ix] - lambda
  
  ix <- which(vals_to_threshold <= -lambda)
  vals_to_threshold[ix] <- vals_to_threshold[ix] + lambda
  
  return(vals_to_threshold)
}

# POCS
lambda <- 0.1
Xhat <- Xr
for (iteration in seq(1,100))
{
  # 1. Compute the inverse FT to get estimate
  xhat <- Re(fft(Xhat, inverse = TRUE)/T)
  # 2. Apply Softrhesh in the time domain
  xhat <- softThresh(xhat, lambda)
  # 3. Find the FFT
  Xhat <- fft(xhat)
  # 4. Enforce known values
  Xhat[r_ix] <- X[r_ix]
}

plot(x, type="l", lwd = 5, ylim = c(0,1.2))
lines(xhat, col="red")
title('Reconstructed using POCS')
