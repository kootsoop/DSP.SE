    #35112
    library(signal)
    
    sinc_pjk <- function(x)
    {
      return(sin(pi * x) / (pi * x))
    }
    
    fractional_delay_filter <- function(delay, length) 
    {
      eps <- 10^-10
      t <- seq(0,length-1)
      t[t == 0 ] <- eps
      #filter <- sinc(t-delay,length)
      filter <- sinc_pjk(t-delay)
      return(filter)
    }
    
    # https://ccrma.stanford.edu/~jos/parshl/Peak_Detection_Steps_3.html
    peak_location  <- function(ykm1,yk,ykp1)
    {
      return(0.5*(ykm1 - ykp1)/(ykm1 - 2*yk + ykp1))
    }
    

    peak_location_olli  <- function(ykm1,yk,ykp1)
    {
      if (ykp1 > ykm1) {
        return((ykm1 + 3*ykp1)/(-ykm1 + 2*yk + 3*ykp1))
      } else {
        return((3*ykm1 + ykp1)/(-3*ykm1 - 2*yk + ykp1))
      }
    }   
    
    
    estimate_delay <- function(x,xd,locator)
    {
      cc <- ccf(xd,x)
      idx <- which.max(cc$acf)
      return(locator(cc$acf[idx-1], cc$acf[idx], cc$acf[idx+1]) + cc$lag[idx])
    }
    
    true_delay <- 10.1
    d5p1 <- fractional_delay_filter(true_delay,32)
    fz <- freqz(d5p1)
    #plot(fz)
    gd <- grpdelay(d5p1)
    #plot(gd)
    
    T <- 1000
    Nres <- 100
    
    results <- rep(0,Nres)
    results_olli <- rep(0,Nres)
    for (n in seq(1,Nres))
    {
      x <- rnorm(T,1)
      xd <- filter(d5p1, 1, x)
    
      #plot(x, type='l')
      #lines(xd[1:T],col='red')å
    
      results[n] <- estimate_delay(x,xd[1:T], peak_location)
      results_olli[n] <- estimate_delay(x,xd[1:T], peak_location_olli)
    }
    
    par(mfrow=c(2,1))
    plot(d5p1, type='l', col='blue')
    title('Fractional filter')
    
    plot(results,col='blue',ylim = true_delay + c(-0.2,0.2))
    points(results_olli, col='red')
    lines(c(1,Nres), c(true_delay,true_delay), col='green')
    title('Estimates and true delay')
    
    
