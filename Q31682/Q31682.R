    # 31682
    
    # http://stackoverflow.com/a/15796694/12570
    circ<-function(x) { 
      n<-length(x)
      matrix(x[matrix(1:n,n+1,n+1,byrow=T)[c(1,n:2),1:n]],n,n)
    }
    
    original <- c(0,0,0,1,0,0,0)
    distorted <- c(0.001,0.005,0.1,0.5,0.2,0.001,0) 
    
    inverse_matrix <- ginv( circ(distorted[c(4,3,2,1,7,6,5)]) )
    
    Nruns <- 100
    
    output <- inverse_matrix %*% distorted
    
    plot(original, type="l", 
         ylim=c(min(c(original,distorted,noisy_distorted, output)),max(c(original,distorted,noisy_distorted, output))),
         xlim=c(1,length(output)), lwd=5)
    lines(noisy_distorted, col="red", lwd=5)
    
    for (runNo in 1:Nruns)
    {  
      noisy_distorted <- distorted + rnorm(length(distorted), 0, 0.01)
      output <- inverse_matrix %*% noisy_distorted
      lines(output, col="green")
    }
    
    lines(original, lwd=5)
    
    title('Original, distorted, and estimated originals (100 realizations) ')
    
    
