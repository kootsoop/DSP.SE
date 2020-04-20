# 26463

# Taken from: http://stackoverflow.com/a/16444047/12570
interleave <- function(a, b) { 
  
  shorter <- if (length(a) < length(b)) a else b
  longer  <- if (length(a) >= length(b)) a else b
  
  slen <- length(shorter)
  llen <- length(longer)  
  
  index.short <- (1:slen) + llen
  names(index.short) <- (1:slen)
  
  lindex <- (1:llen) + slen
  names(lindex) <- 1:llen
  
  
  sindex <- 1:slen
  names(sindex) <- 1:slen
  
  index <- c(sindex, lindex)
  index <- index[order(names(index))]
  
  return(c(a, b)[index])
  
}

Rx <- filter(rnorm(1000, 0, 1), rep(1,10), circular=TRUE)
Ix <- filter(rnorm(1000, 0, 1), rep(1,10), circular=TRUE)
x <-  Rx + 1i*Ix

zeroes <- matrix(0,1,1000)

xup <- as.vector(interleave(x,zeroes))
xupf <- filter(Re(xup), rep(1,2), circular=TRUE) + 1i*filter(Im(xup), rep(1,2), circular=TRUE)

rup <- as.vector(interleave(Rx,zeroes))
rupf <- filter(rup, rep(1,2), circular=TRUE) 


X <- fft(x)
XRx <- fft(Rx)

par(mfrow=c(4,1),pty="m")
plot(Mod(X), type="l")
title('FFT of analytic signal')
plot(Mod(XRx), type="l")
title('FFT of real part of analytic signal')
plot(Mod(fft(xupf)), type="l")
title('FFT of upsampled signal')
plot(Mod(fft(rupf)), type="l")
title('FFT of upsampled real-valued signal')

