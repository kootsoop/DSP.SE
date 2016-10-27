    #35112
    library(signal)
    
    fractional_delay_filter <- function(delay, length) 
    {
      eps <- 10^-10
      t <- seq(0,length-1)
      t[t == 0 ] <- eps
      filter <- sinc(t-delay,length)
      return(filter)
    }
    
    # https://ccrma.stanford.edu/~jos/parshl/Peak_Detection_Steps_3.html
    peak_location  <- function(ykm1,yk,ykp1)
    {
      return(0.5*(ykm1 - ykp1)/(ykm1 - 2*yk + ykp1))
    }
    
    
    estimate_delay <- function(x,xd)
    {
      cc <- ccf(xd,x)
      idx <- which.max(cc$acf)
      return(peak_location(cc$acf[idx-1], cc$acf[idx], cc$acf[idx+1]) + cc$lag[idx])
    }
    
    true_delay <- 10.5
    d5p1 <- fractional_delay_filter(true_delay,32)
    fz <- freqz(d5p1)
    #plot(fz)
    gd <- grpdelay(d5p1)
    #plot(gd)
    
    T <- 1000
    Nres <- 100
    
    results <- rep(0,Nres)
    for (n in seq(1,Nres))
    {
      x <- rnorm(T,1)
      xd <- filter(d5p1, 1, x)
    
      #plot(x, type='l')
      #lines(xd[1:T],col='red')å
    
      results[n] <- estimate_delay(x,xd[1:T])
    }
    
    par(mfrow=c(2,1))
    plot(d5p1, type='l', col='blue')
    title('Fractional filter')
    
    plot(results,col='blue')
    lines(c(1,Nres), c(true_delay,true_delay), col='green')
    title('Estimates and true delay')
    
    
