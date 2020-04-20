    #27349
    #install.packages("tuneR")
    library(tuneR)
    x <- readWave("Q27349/test.wav")
    
    sig <- x@left
    
    abssig <- abs(sig)
    
    N <- 100
    filtabssig <- filter(abssig, rep(1/N,N))
    
    plot(abs(filtabssig))
    
    med <- 0*filtabssig
    
    
    N2median <- 1000 # Window length is 2 * N2median + 1
    for (k in 1:length(filtabssig))
    {
      idxs = seq(max(1,k-N2median), min(length(filtabssig), k+N2median),1)
      med[k] = median(filtabssig[idxs])
    }
    
    par(mfrow=c(3,1))
    plot(filtabssig, col="red")
    lines(med200,col="blue")
    title("Median filter length of 201")
    
    plot(filtabssig, col="red")
    lines(med1000,col="blue")
    title("Median filter length of 2001")
    
    plot(filtabssig, col="red")
    lines(med2000,col="blue")
    title("Median filter length of 4001")
