    #26866
    
    f <- 20
    fs <- 100
    phi <- 2*pi*0.12987892374
    
    T <- 100
    t <- 0:(T-1)
    
    signal <- sin(2*pi*f/fs*t+phi)
    noise <-  rnorm(T,0,1)
    noisy_signal <- signal + noise
    
    alpha <- 0.9
    
    num <- c(1, -2*cos(2*pi*f/fs), 1)
    den <- c(1, -2*alpha*cos(2*pi*f/fs), alpha*alpha)
    
    
    filtered <- signal::filter(num,den,noisy_signal)
    
    par(mfrow=c(2,1))
    plot(noisy_signal, type="l", col="red",  lwd=10)
    lines(signal, type="l", col="blue", lwd = 3)
    title("Noiseless signal (blue) and noisy signal (red)")
    
    
    plot(filtered, col="blue", lwd = 4)
    lines(noise, col="red",  lwd=3)
    title("Filtered signal (blue) and original noise signal (red)")
