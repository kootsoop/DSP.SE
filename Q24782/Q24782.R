    # 24782
    # install.packages('signal')
    
    T <- 1024
    t <- 0:(T-1)
    
    fs <- 1000
    omega <- 2*pi*30/1000
    phi <- 0.9279835
    
    x <- sin(omega*t + phi)
    
    changed <- sample(1:T, 10)
    
    y <- x
    y[changed] <- y[changed] + 3
    
    alpha <- 0.9
    num <- c(1, -2*cos(omega), 1)
    den <- c(1, -2*alpha*cos(omega), alpha*alpha)
    
    yf <- signal::filter(num, den, y)
    
    plot(t,y, type="l", lwd=10)
    lines(t,yf, col="red", lwd=4)
    
    legend(850, 4, c("Original", "Filtered"), lwd=c(2.5,2.5),col=c("black","red"))