    # 26617
    
    T <- 10000
    mu <- 0.768768
    k <- 613
    
    s <- filter(runif(T,-1,1), rep(10/k,k/10), circular = TRUE)
    
    
    x <- s + mu*c(rep(0,k),s[1:(T-k)])
                  
    
    par(mfrow=c(2,1))
    r_xx = acf(x, lag.max=1000, type="covariance")
    
    min_idx <- floor(k/10)
    mx <- which.max(r_xx$acf[(min_idx+1):10000])
    
    khat <- min_idx+mx-1 # R indices start from 1, not 0
    
    points(min_idx+mx,r_xx$acf[khat], col="red", pch=19)
    
    r_ss = acf(s, lag.max=1000, type="covariance")
    
    muhat <- sqrt( r_xx$acf[1] / r_ss$acf[1] - 1 )
    print(paste("k Estimate:" , khat, " vs " , k, " mu Estimate : ", muhat, " vs ", mu ))
    
    
