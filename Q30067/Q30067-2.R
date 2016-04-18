    # 30067
    
    prototype_length <- 40
    
    A <- rep(0, prototype_length)
    A[(prototype_length/4+1):(3*prototype_length/4)] <- sin(2*pi*seq(0,prototype_length/2-1)/prototype_length)
    
    
    B <- rep(0, prototype_length)
    B[(prototype_length/2+1):(prototype_length)] <- `^`(sin(2*pi*seq(0,prototype_length/2-1)/prototype_length),12)*3/8
    
    par(mfrow = c(1,3), pty="s")
    plot(A, type="l", col="blue", lwd=5)
    lines(B, col="red", lwd=5)
    title('Original Signals')
    
    k <- sample(0:10, 1)
    m <- sample(0:10, 1)
    
    data <- k*A + m*B + 0.1 * rnorm(prototype_length, 0, 0.1)
    plot(data, type="l")
    title('Scaled & Added Signals')
    
    err <- array(0,c(11,11))
    kvals <- array(0,c(11,11))
    mvals <- array(0,c(11,11))
    for (khat in 0:10)
    {
      for (mhat in 0:10)
      {
        err[khat+1,mhat+1] <- sum('^'(abs(data - khat*A - mhat*B), 2))
        kvals[khat+1,mhat+1] <- khat
        mvals[khat+1,mhat+1] <- mhat
      }
    }
    
    image(0:10,0:10,err, xlab="k hat", ylab = "m hat")
    ix <- which.min(err)
    lines(kvals[ix] + c(-0.2,0.2), mvals[ix]+ c(-0.2,0.2), col="blue", lwd = 10)
    points(k, m, col="green", lwd = 10)
    title('Error, actual values, and minimum')