    #21675
    
    
    q_21675 <- function()
    {
      #1 
      sigma_i <- 3
      #2
      G <- 256
      p <- rep(0,G)
      for (i in 1:G)
      {
        p[i] <- 1/(sigma_i*sqrt(2*pi))*exp(-i*i/(2*sigma_i*sigma_i))
      }
      #3 
      q1 <- runif(1,0,1)
      diff <- rep(0,G)
      for (j in 1:G)
      {
        diff[j] <- q1-p[j]
      }
      j <- which.min(diff)
      #4
      q2 <- runif(1,-1,1)
      addition <- q2*j
      return(addition)
    }
    
    
    x <- rep(0,1000)
    for (t in 1:1000)
    {
      x[t] <- q_21675()
    }




