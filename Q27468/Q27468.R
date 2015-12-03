    #27468
    
    T <- 1000
    Npeaks <- 10
    
    idx_peaks <- runif(Npeaks,1,T)
    
    strain <- rnorm(T) + c(seq(1,2*T/3,1) ,seq(2*T/3+1,0,-2))/100
    
    strain[idx_peaks] <- strain[idx_peaks] + 10
    
    detrended <- 0*strain
    alpha <- 0.9
    
    for (k in 1:length(strain))
    {
      if (k>1)
      {
        detrended[k] <- alpha*detrended[k-1] + strain[k] - strain[k-1]
      }
      else
      {
        detrended[k] <- 0
      }
    }
    
    par(mfrow=c(2,1))
    plot(strain,col="blue", type="l")
    plot(detrended,col="blue", type="l")