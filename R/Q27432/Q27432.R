#27432

T2 <- 1000

f <- rnorm(2*T2+1) * seq(-T,T,1)

par(mfrow=c(2,1))
plot(f, type="l", col="blue")
plot(abs(fft(f)), type="l", col="blue")
    
    

  