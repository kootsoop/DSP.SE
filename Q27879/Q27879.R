    #27879
    
    T <- 100
    
    #H = [3 -3 1]
    H <- matrix(c(1,0,0),c(1,3)) 
    
    #F is just a tapped delay line
    alpha <- matrix(c(0.9,0,0,0,0.9,0,0,0,0.9),3,3)
    A <- matrix(c(3,1,0,-3,0,1,1,0,0),3,3)
    B <- matrix(c(1,0,0),c(3,1))
    
    sigma_v <- 1
    v <- rnorm(T,0,sigma_v)
    sigma_w <- 0.01
    w <- rnorm(T,0,sigma_w)
    
    x <- matrix(c(0,0,0),c(3,1))
    z <- rep(0,T)
    
    for (t in 1:T)
    {
      z[t] <- H %*% x + w[t]
      x <- A %*% x +v[t]
    }
    par(mfrow=c(1,1))
    plot(z,type="l", col="blue", lwd=5)
    
    Q <- matrix(c(0,0,0,0,0,0,0,0,sigma_v^2),3,3)
    R <- sigma_w^2
    
    
    library("MASS") # For pseudo inverse ginv()
    
    xkm1km1 <- matrix(rep(0,3*T+3),3,T+1)
    xkkm1 <- matrix(rep(0,3*T),3,T)
    K <- matrix(rep(0,3*T),3,T)
    Pkm1km1 <- matrix(c(1000,0,0 ,0,1000,0, 0,0,1000),3,3)
    zhat <- matrix(rep(0,T),c(T,1))
    
    for (k in 1:T)
    {
      xkkm1[,k] <- A %*% xkm1km1[,k]
      Pkkm1 <- A %*% Pkm1km1 %*% t(A) + Q
      K[,k] <- Pkkm1 %*% t(H) %*% ginv( H %*% Pkkm1 %*% t(H) + R)
      xkm1km1[,k+1] <- xkkm1[,k] + K[,k] %*% (z[k] - H %*% xkkm1[,k])
      Pkm1km1 <- (matrix(c(1,0,0,0,1,0,0,0,1),3,3) - K[,k] %*% H) %*% Pkkm1  
      zhat[k] <- as.numeric(H %*% xkkm1[,k])
    }
    lines(zhat, col="red")
