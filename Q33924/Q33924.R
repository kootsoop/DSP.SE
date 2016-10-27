    #33924
    
    N <- 256
    h_true <- c(1, 0.45, -0.2)
    
    z <- rnorm(N,0,1)
    
    hz <- filter(z,h_true)
    
    sigma_w <- 1
    
    y <- hz + rnorm(N,0,sigma_w)
    
    llh <- -N/2*log(2*pi*sigma_w*sigma_w) 
    - 1/(2*sigma_w*sigma_w)*sum((y-hz)^2)