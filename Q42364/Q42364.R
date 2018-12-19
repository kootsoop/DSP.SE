    #42364
    
    T <- 1000
    k1 <- 0.006998
    k2 <- 0.0188728493
    k_true <- c(k1*rep(1,T/2), k2*rep(1,T/2))
    c_true <- c(2.90238432*rep(1,T/2), 2.90238432*rep(1,T/2) + (k1-k2)*(T/2+1))
    t <- seq(1,T)
    
    y_true <- k_true*t + c_true
    
    y_noisy <- y_true + rnorm(T)*0.1
    
    k_hat <- rep(0,T)
    
    
    window_length <- 100
    for (t_idx in t)
    {
      oldest_idx <- max(t_idx-window_length, 1)
      window_idx <- seq(oldest_idx, t_idx)
      x_bar <- sum(window_idx)/length(window_idx)
      y_bar <- sum(y_noisy[window_idx])/length(window_idx)
      
      xy <- sum((window_idx - x_bar)*(y_noisy[window_idx] - y_bar))
      xx <- sum((window_idx - x_bar)*(window_idx - x_bar))
      
      k_hat[t_idx] <- xy /xx
    }
    
    par(mfrow=c(2,1))
    plot(t, y_noisy, type='l')
    lines(t,y_true, col='red') #, lwd=3
    
    plot(t,k_hat)
    lines(t,c(k1*rep(1,T/2), k2*rep(1,T/2)), col='red')