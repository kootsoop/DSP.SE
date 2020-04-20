    #30846
    
    A <- 1
    omega_0 <- 2*pi*0.0143298579849
    d_0 <- 2*pi*0.39238798235
    
    B <- 1 
    omega_2 <- 2*pi*0.363209429
    d_2 <- 2*pi*0.1835934324
    
    T <- 1000
    t <- seq(0,T-1)
    
    x <- A*cos(omega_0*t + d_0) + B*cos(omega_2*t + d_2)
    
    analytic <- function(x)
    {
      hilb <- c(1, rep(2, T-2), rep(0,T+1))
      ana <- fft(hilb*fft(c(x, rep(0,T))), inverse=TRUE)/T/2
      return (ana[1:T])
    }
    
    z <- analytic(x)
    exponential <- exp(-1i*omega_0*t)
    
    coeff <- rep(0,T)
    for (time in t)
    {
      coeff[time] <- 2*sum(exponential[1:time]*x[1:time])/time
    }
    
    par(mfrow=c(2,2))
    plot(x,type="l", lwd=5)
    #lines(Re(z), col="red")
    title('Original signal ')
    
    plot(abs(fft(x)), type="l")
    title("FFT of signal")
    
    plot(Arg(coeff))
    lines(c(0,T), c(d_0,d_0), col="green", lwd=5)
    title("d_0 estimate as a funciton of time")
    
    plot(abs(coeff))
    lines(c(0,T), c(A,A), col="green", lwd=5);
    title("A estimate as a function of time")
