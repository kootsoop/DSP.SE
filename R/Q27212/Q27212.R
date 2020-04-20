    #27212
    
    N <- 1000
    acc <- rnorm(N)/5
    
    Nspikes <- 10
    spike_indices <- runif(Nspikes,1,N)
    spike_values <- runif(Nspikes,-10,10)
    
    acc[spike_indices] <- spike_values
    
    decimationFactor <- 50
    idx <- 1
    mx <- rep(0,length(seq(1,length(acc),decimationFactor)))
    mn <- rep(0,length(seq(1,length(acc),decimationFactor)))
    
    for (k in seq(1,length(acc),decimationFactor))
    {
      idxs = seq(max(1,k), min(length(acc), k+decimationFactor-1),1)
      mx[idx] = max(acc[idxs])
      mn[idx] = min(acc[idxs])
      idx <- idx + 1
    }
    
    par(mfrow=c(1,1))
    plot(acc)
    points(seq(1,length(acc),decimationFactor),mx,lwd=5,col="green")
    points(seq(1,length(acc),decimationFactor),mn,lwd=5,col="red")