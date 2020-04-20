    # 30039
    # CUSUM 
    
    N <- 30
    
    mu1 <- 0
    mu2 <- 1
    noiseless_data <- c(rep(mu1,N), seq(mu1,mu2,1/N), rep(mu2,N*4), seq(mu2,mu1,-1/N), rep(mu1,N))
    
    
    sigma <- 0.001
    data_before_diff <- noiseless_data + rnorm(length(noiseless_data),0,sigma)
    data <- diff(data_before_diff)
    mu2diff <- 0.04
    
    thresh <- 1
    
    breaks <- rep(0,N)
    num_breaks <- 0
    
    s <- rep(0,length(data))
    capS <- rep(0,length(data))
    G <- rep(0,length(data))
    for (k in 1:length(data))
    {
      s[k] = (mu2diff - mu1)/sigma*(data[k] - (mu2diff + mu1)/2)
      if (k==1)
      {
        capS[k] = s[k]
      }
      else
      {
        capS[k] = capS[k-1] + s[k]
      }
      
      G[k] <- max(0,capS[k] - min(capS[1:k]))
      
      if (abs(G[k]) > thresh)
      {
        num_breaks <- num_breaks + 1
        breaks[num_breaks] <- which.min(capS[1:k])
        tmp <- mu1
        mu1 <- mu2diff
        mu2diff <- tmp
      }
    }
    
    first_break <- min(breaks[1:num_breaks])
    last_break <- max(breaks[1:num_breaks])
    
    plot(noiseless_data,type="l")
    lines(data,col="red")
    lines(c(first_break,first_break),c(0,1),col="blue", lwd=10)
    lines(c(last_break,last_break),c(0,1),col="blue",lwd=10)
    
    
    