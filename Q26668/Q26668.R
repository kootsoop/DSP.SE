    #26668
    
    x <- runif(1000,-1,1)
    
    Nfilt <- 20
    
    x_test_lpf <- c(x, filter(x,rep(1/5,5), circular = TRUE))
    x_test_hpf <- c(x, filter(x,(-1)^(0:4)/5, circular = TRUE))
    
    
    
    x_hpf_1 <- filter(x_test_lpf,(-1)^(0:(Nfilt-1))/Nfilt, circular = TRUE) # Unity gain at fs/2
    x_lpf_1 <- filter(x_test_lpf,rep(1/Nfilt,Nfilt), circular = TRUE) # Unity gain at 0
    
    
    x_hpf_2 <- filter(x_test_hpf,(-1)^(0:(Nfilt-1))/Nfilt, circular = TRUE) # Unity gain at fs/2
    x_lpf_2 <- filter(x_test_hpf,rep(1/Nfilt,Nfilt), circular = TRUE) # Unity gain at 0
                      
    
    print(paste("X:", sum(x^2), " LPF1:", sum(x_lpf_1^2), " HPF1:", sum(x_hpf_1^2), " LPF2:", sum(x_lpf_2^2), " HPF2:", sum(x_hpf_2^2)))
