      #15466
      
      x1 <- rnorm(1000)
      
      h <- c(1,3,2,1)/7
      x2 <- filter(x1,h, circular=TRUE) + rnorm(1000)/10
      
      par(mfrow=c(3,1))
      
      plot(x1,type="l",col="blue")
      lines(x2, col="green",lwd=5)
      title("Original and filtered noise signals")
      
      ccf(x1,x2)
      
      Ixy <- spectrum(cbind(x1,x2), plot=FALSE,spans=c(5,7))
      
      plot(Ixy$coh)