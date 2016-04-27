    #30332
    library(signal)
    library(tseries)
    
    # Create a time series that is not just white noise
    T <- 1000
    
    do_plot <- 1
    
    #for (k in seq(1,100))
    {
      x <- rnorm(T, 0, 1)
      bf <- butter(4,0.41)
      y <- filter(bf$b, bf$a, x)
      
      # Split data in two and compare ARIMA models
      L2 <- length(y)/2
      y1 <- y[100:L2] # Start away from 1 to avoid startup transients
      y2 <- y[(L2+1):length(y)]
      
      orders <- c(3,0,3)
      
      # First half
      tryCatch(
      {arima1 <- arima(y1, order = orders)},
      warning = function(w) {  },
      error = function(e) {  },
      finally = {});
      
      all_1 <- coefficients(arima1)
      num_1 <- all_1[4:6]
      den_1 <- all_1[1:3]
      
      # Second half
      tryCatch(
      {arima2 <- arima(y2, order = orders)},
      warning = function(w) {  },
      error = function(e) {  },
      finally = {});
    
      all_2 <- coefficients(arima2)
      num_2 <- all_2[4:6]
      den_2 <- all_2[1:3]
      
      # All data
      arima_tot <- arima(y, order = orders)
      all_tot <- coefficients(arima_tot)
      num_tot <- all_tot[4:6]
      den_tot <- all_tot[1:3]
      
      # Plot  boundaries
      xs <- c(-1,1)
      ys <- xs
      
      if (do_plot == 1)
      {
        par(mfrow=c(1,1), pty='s')
        plot(roots(den_1), xlim=xs, ylim=xs, lwd = 6, pch=4, xlab="Re(z)", ylab="Im(z)")
        do_plot <- 0
      }
      else
      {
        points(roots(den_1), lwd = 6, pch=4)
      }
      points(roots(den_2), lwd = 4, col="red", pch=4)
      points(roots(den_tot), lwd = 2, col="grey", pch=4)
      
      points(roots(num_1), lwd = 6, pch=1)
      points(roots(num_2), lwd = 4, col="red", pch=1)
      points(roots(num_tot), lwd = 2, col="grey", pch=1)
    }
    
    
    par(pty="m")
    subtract_num <- conv(num_1, den_2) - conv(num_2, den_1)
    subtract_den <- conv(den_1, den_2)
    
    freqz(subtract_num, subtract_den)
    
