    #26547
    
    Npulses <- 100
    Tmax <- 1000
    
    Tperiod <- runif(1,9,10)
    Tstart <- runif(1,0,1)
    
    #pulseTimes <- sort(runif(Npulses,0,Tmax))
    pulseTimes <- Tstart + (0:Npulses)*Tperiod
    
    # install.packages("Hmisc")
    library(Hmisc)
    
    xc_times = acf(pulseTimes, plot = FALSE)
    
    times <- 0:.1:Tmax
    
    pulses <- times*0
    
    for (pulseNo in 1:length(pulseTimes))
    {
      idx <- which.min(abs(pulseTimes[pulseNo] - times))
      pulses[idx] = 1
    }
    
    xc_pulses <- acf(pulses, plot = FALSE)
    
    histogram <-  hist(diff(pulseTimes), breaks=xc_pulses$lag, plot=FALSE)
    
    plot(xc_times$lag,xc_times$acf, type="l", ylim=c(-0.1,1))
    lines(xc_pulses$lag, xc_pulses$acf, col="red")
    lines(histogram$mids, histogram$counts / max(histogram$counts), col="green")
    
    legend(12, 1.0, c("ACF of times", "ACF of pulses", "Histogram of inter-pulse times"), lwd=c(2.5,2.5, 2.5),col=c("black","red", "green"))