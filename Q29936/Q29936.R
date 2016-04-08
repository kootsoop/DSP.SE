    #29936
    
    fs <- 8000
    fbad <- 50
    phibad <- 2*pi*runif(1,0,1)
    fgood <- 101.98340234
    phigood <- 2*pi*runif(1,0,1)
    
    T <- 1000
    t <- seq(1,T)
    
    x_noisy <-  sin(2*pi*fgood/fs*t + phigood) + sin(2*pi*fbad/fs*t + phibad) 
    
    num <- c(1, -2*cos(2*pi*fbad/fs), 1)
    alpha <- 0.99
    den <- c(1, -2*alpha*cos(2*pi*fbad/fs), alpha*alpha)
    
    x_filtered <- filter(num, den, x_noisy)
    
    par(mfrow = c(2,1))
    plot(t,x_noisy, type="l")
    
    plot(t,x_filtered, type="l")
