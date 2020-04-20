    #30271
    
    A <- 0.5
    B <- 0.5
    C <- 0
    
    K <- 5
    
    k <- seq(0,K-1)
    
    w_k <- A - B * cos(2*pi*k/(K-1)) + C * cos(4*pi*k/(K-1))
    
    print(w_k)