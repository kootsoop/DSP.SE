    #41046
    
    require(signal)
    N <- 128
    
    r <- rep(1,N)
    h <- hamming(N)
    b <- bartlett(N)
    
    r <- r/sqrt(sum(r*r))
    h <- h/sqrt(sum(h*h))
    b <- b/sqrt(sum(b*b))
    
    #r <- r/sum(r)
    #h <- h/sum(h)
    #b <- b/sum(b)
    
    rd <- rep(0,N)
    hd <- rep(0,N)
    bd <- rep(0,N)
    
    for (idx in seq(1,N))
    {
      if (idx != 1)
      {
        rd[idx] <- rd[idx-1] + r[idx]*r[idx]
        hd[idx] <- hd[idx-1] + h[idx]*h[idx]
        bd[idx] <- bd[idx-1] + b[idx]*b[idx]
      }
      else
      {
        rd[idx] <- r[idx]*r[idx]
        hd[idx] <- h[idx]*h[idx]
        bd[idx] <- b[idx]*b[idx]
      }
    }
    
    plot(rd, col="blue", type ="l", ylab="delay", ylim=c(0,max(c(rd,hd,bd))))
    lines(hd, col="red")
    lines(bd, col="black")
    
    legend(0, 1.0, c("rectangular", "hamming", "bartlett"), col = c("blue", "red", "black"), lty = c(1, 1, 1))