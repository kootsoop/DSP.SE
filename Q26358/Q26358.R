    # Q26358
    
    one_mode <- rnorm(100, 0, 1)
    two_mode <- c(rnorm(50, -2, 1), rnorm(50, +2, 1))
    
    plot(1:100,one_mode,pch=16, col="green")
    lines(1:100,two_mode, pch=16, col="red")
    
    library(mixtools)
    
    par(mfrow=c(2,2))
    plot(1:100,one_mode,pch=16, col="green")
    plot(1:100,two_mode, pch=16, col="red")
    
    
    mixmdl = normalmixEM(one_mode)
    plot(mixmdl,which=2)
    lines(density(one_mode), lty=2, lwd=2)
    
    mixmdl_two = normalmixEM(two_mode)
    plot(mixmdl_two,which=2)
    lines(density(two_mode), lty=2, lwd=2)
    
    library(diptest)
    dip.test(one_mode)
    dip.test(two_mode)