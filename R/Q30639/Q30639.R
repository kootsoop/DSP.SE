    # 30639
    N <- 1000
    
    s <- rnorm(N, 0, 1)
    
    sigma_a <- 0.1
    sigma_b <- 0.2
    
    na <- rnorm(N,0,sigma_a)
    nb <- rnorm(N,0,sigma_b)
    
    m <- 10
    
    a <- s + na
    b <- m*s  + nb
    
    ix <- 1
    
    test_values <- seq(0,sigma_b*4,0.001)
    mhat <- 0*test_values
    for (test_sigma_b in test_values)
    {  
      mhat[ix] <- sum(b * a)/(sum(a*a) - N*test_sigma_b*test_sigma_b)
      ix <- ix + 1
    }
    
    par(mfrow=c(3,1))
    plot(test_values, mhat, ylim=c(-10,20), type="l")
    lines(c(sigma_b, sigma_b), c(-10,20), col="red");
    title('Effect of varying sigma_b')
    
    plot(b/a,  pch=10, col="grey", ylim=c(-10,20))
    lines(c(1,N), c(m, m), type="l", col="green", lwd=10)
    #lines(c(1,N), c(mhat, mhat), type="l", col="blue", lwd=5)
    title('True m value vs b/a estimate')
    
    Nruns <- 100
    mhat_1 <- rep(0,Nruns)
    mhat_2 <- rep(0,Nruns)
    
    for (run_number in seq(1,Nruns))
    {
      s_run <- rnorm(N, 0, 1)
      a_run <- s_run + rnorm(N,0,sigma_a)
      b_run <- m * s_run + rnorm(N,0,sigma_b)
      
      mhat_1[run_number] <- sum(b_run * a_run)/sum(a_run*a_run)
      mhat_2[run_number] <- quantile(b_run/a_run)[3]
    }
    
    sds <- c(sd(mhat_1), sd(mhat_2))
    print(sds)
    
    plot(mhat_1, type="l", col="blue")
    lines(mhat_2, col="green")
    title('BLUE: rb-j estimate GREEN: middle quintile of b/a estimate')
    
    
