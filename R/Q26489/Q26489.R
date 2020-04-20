    # 26489
    T <- 128;
    t <- 0:(T-1)/T*70
    
    signal <- 4.4 + sin(0.06*pi*t - 0.1) + sin(0.14*pi*t + 0.07) + sin(0.2*pi*t + 0.4)
    noise <- sin(0.06 + 0.5*pi*t) + sin(0.1 - 0.68*pi*t) - sin(0.04 - 0.74*pi*t) + sin(0.03 - 0.93*pi*t)
    
    measurement <- signal + noise
    
    
    xkm1km1 <- matrix(c(4.4, 0),2,1)
    Pkm1km1 <- matrix(c(1,0,0,1),2,2)
    H <- matrix(c(1,0),1,2) 
    A <- matrix(c(1,1,0,1),2,2)
    Q <- 10^-6 * matrix(c(1.6,2.4,2.4,4.8),2,2)
    R <- 10^-6 * matrix(c(2.35),1,1)
    
    library("MASS") # For pseudo inverse ginv()
    
    zhat <- t*0
    
    for (k in 1:T)
    {
      xkkm1 <- A %*% xkm1km1
      Pkkm1 <- A %*% Pkm1km1 %*% t(A) + Q
      K <- Pkkm1 %*% t(H) %*% ginv( H %*% Pkkm1 %*% t(H) + R)
      z <- matrix(c(measurement[k]), 1, 1)
      xkm1km1 <- xkkm1 + K %*% (z - H %*% xkkm1)
      Pkm1km1 <- (matrix(c(1,0,0,1),2,2) - K %*% H) %*% Pkkm1  
      zhat[k] <- as.numeric(H %*% xkkm1)
    }
    
    plot(t, measurement, type="b", pch=19)
    lines(t, signal, col="red",  lwd=10)
    lines(t, zhat, col="blue", lwd=5)
    
    lpf <-  filter(measurement, c(0.2,0.2,0.2,0.2,0.2), circular = TRUE)
    lines(t,lpf, col="green", lwd=4)
    
    errs <- c(sum((signal - zhat)^2), sum((signal - lpf)^2))
    print(errs)
