    #31956
    
    Fs <- 8000
    dt <- 1/Fs
    f1 <- 100
    tdelay <- 0.625e-03
    t3 <- seq(0,1-dt,dt)
    
    ns <- rnorm(Fs,0,0.1)*0
    
    x3 <- cos(2*pi*f1*t3) + ns
    x4 <- cos(2*pi*f1*(t3-tdelay)) + c(rep(0,5),ns[1:(Fs-5)])
    
    xcorr_31956 <- function(x,y,normalize = FALSE)
    {
      xfft <- fft(x, 4*length(x))
      yfft <- fft(y, 4*length(x))
      
      R <- xfft*Conj(yfft);
      if (normalize)
      {
        R <- R/abs(R)
      }
      c <- fft(R, inverse=TRUE);
      
      return(c)
    }
    
    xc <- xcorr_31956(x3,x4, FALSE)
    xc_phat <- xcorr_31956(x3,x4, TRUE)
    
    par(mfrow=c(2,1))
    plot(seq(0,length(xc)-1),abs(xc), type="l", xlim=c(0,20), col="blue", lwd=2)
    ix <- which.max(abs(xc))
    points(ix-1,abs(xc[ix]), col="red", lwd=5); 
    title('Standard CCF')
    
    plot(seq(0,length(xc)-1),abs(xc_phat), type="l", xlim=c(0,20), col="blue", lwd=2)
    ix_phat <- which.max(abs(xc_phat))
    points(ix_phat-1,abs(xc_phat[ix_phat]), col="red", lwd=5); 
    title('Generalized')
    
    print(paste("Delay is",tdelay*Fs), quote = FALSE)
    print(paste("Estiamte is",which.max(abs(xc)) - 1), quote = FALSE)
    
    
           