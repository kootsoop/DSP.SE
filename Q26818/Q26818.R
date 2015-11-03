      # 26818
      T <- 128;
      dt <- 0.01
      
      t <- seq(0,T-1)*dt
      
      xkm1km1 <- matrix(c(0, 0, 0),3,1)
      Pkm1km1 <- matrix(c(1000,0,0 ,0,1000,0, 0,0,1000),3,3)
      #H = [1 0 0
      #     0 1 0];
      H <- matrix(c(1,0,0,1,0,0),c(2,3)) 
      
      #F = [ 1 dt dt^2/2
      #      0  1 dt
      #      0  0 1];
      A <- t(matrix(c(1,dt,dt^2/2,0,1,dt,0,0,0),3,3))
      B <- matrix(c(0,0,1),c(3,1))
      
      true_acceleration <- rnorm(T,0,1)
      measurement <- t(matrix(rep(0,T*2),c(2,T)))
      x <- t(matrix(rep(0,T*3),c(3,T)))
      
      position_noise <- rnorm(T,0,0.001)
      velocity_noise <- rnorm(T,0,20)
      
      v <- t(array(c(position_noise, velocity_noise),c(T,2)))
      
      Q <- matrix(c(0,0,0,0,0,0,0,0,1),3,3)
      R <- matrix(c(0.001,0,0,20),2,2)
      
      
      # Generate the data using the signal model
      for (k in 2:T)
      {
        x[k,] = A %*% x[k-1,] + B * true_acceleration[k-1]
        measurement[k,] = H %*% x[k,] + v[,k]
      }
      
      library("MASS") # For pseudo inverse ginv()
      
      zhat <- matrix(rep(0,2*T),c(T,2))
      
      for (k in 1:T)
      {
        xkkm1 <- A %*% xkm1km1
        Pkkm1 <- A %*% Pkm1km1 %*% t(A) + Q
        K <- Pkkm1 %*% t(H) %*% ginv( H %*% Pkkm1 %*% t(H) + R)
        z <- matrix(c(measurement[k,]), 2, 1)
        xkm1km1 <- xkkm1 + K %*% (z - H %*% xkkm1)
        Pkm1km1 <- (matrix(c(1,0,0,0,1,0,0,0,1),3,3) - K %*% H) %*% Pkkm1  
        zhat[k,] <- as.numeric(H %*% xkkm1)
      }
      
      par(mfrow=c(2,1))
      plot(t, measurement[,1], type="b", pch=19)
      lines(t, x[,1], col="red",  lwd=10)
      lines(t, zhat[,1], col="blue", lwd=5)
      
      plot(t, measurement[,2], type="b", pch=19, ylim=c(-1,1))
      lines(t, x[,2], col="red",  lwd=10)
      lines(t, zhat[,2], col="blue", lwd=5)
      
      
      errs <- c(sum((signal - zhat)^2), sum((signal - lpf)^2))
      print(errs)
