    # 30425
    
    M <- 10
    N <- 100
    theta <- seq(-pi*5,pi*5,pi/N)
    
    sinc <- sin(M*theta/2) / (theta/2)
    asinc <- sin(M*theta/2) / sin(theta/2)
    asinctheta <- sin(M*sin(theta)/2) / sin(sin(theta)/2)
    
    plot(theta, sinc, col=1, type="l", lwd = 4)
    lines(theta, asinc, col=2, lwd = 2)
    lines(theta, asinctheta, col=3, lwd = 1)
    
    legend(-10, 10, c("sinc()", "asinc","asinctheta"), col=c(1,2,3), lwd = c(4,2,1))