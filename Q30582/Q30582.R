    #30582
    
    wrapPhase <- function(phi)
    {
      return(phi %% 2*pi)
    }
    
    # https://en.wikipedia.org/wiki/Piano_key_frequencies
    cs <- c(32.7032, 65.4064, 130.813, 261.626, 523.251, 1046.50, 2093.00, 4186.01)
    c1 <- cs[1]
    c8 <- cs[8]
    
    fs <- 44100
    
    phs <- rep(0,T + 1)
    phs_incr <- c8 / fs * 2 * pi
    
    T <- 1000
    
    sample <- rep(0,T)
    sqr_wave <- rep(0,T)
    
    for (t in seq(1,T))
    {  
      sample[t] <- sin(wrapPhase(phs[t]))
        
      if (sample[t] > 0)
      {
        sqr_wave[t] <- 1
      }
      else 
      {
          sqr_wave[t] = -1;
      }
      
      print(sample[t])
      
      phs[t+1] <- phs[t] +  phs_incr
      #phs[t+1] <- wrapPhase(phs[t+1]);
    }
    
    phi <- seq(-pi, pi, 0.001*pi)
    phi_wrap <- rep(0, length(phi))
    
    for (k in 1:length(phi))
    {
      phi_wrap[k] <- wrapPhase(phi[k])
    }
    
    plot(sample[1:50], col="blue", type="l")
    lines(sqr_wave[1:50], col="green")
    
