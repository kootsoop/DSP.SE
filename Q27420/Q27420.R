# Q27420
h_ref <- c(-1/16, 0, 1, 0, -1, 0, 1/16)
d2 <- c(0.5,0,-0.5)
d3 <- c(-3/16, 31/32,0, -31/32, 3/16)


H_ref <- abs(fft(c(h_ref,rep(0,1000))))
f2 <- abs(fft(c(d2,rep(0,1000))))
f3 <- abs(fft(c(d3,rep(0,1000))))

w1 <- seq(0,length(H_ref)-1,1)/(length(H_ref)-1)
w2 <- seq(0,length(f2)-1,1)/(length(f2)-1)
w3 <- seq(0,length(f3)-1,1)/(length(f3)-1)

n1 <- length(w1)/2
n2 <- length(w2)/2
n3 <- length(w3)/2

plot(w3[1:n3],f3[1:n3]/1.2, col="blue", lwd=5,type="l", lty=2)
lines(w1[1:n1],H_ref[1:n1]/1.63,col="black", lwd=5)
lines(w2[1:n2],f2[1:n2], col="green", lwd=5)

legend(0.0, 1.5, c("Proposed","Reference", "Difference"),
       col=c("blue","black","green"), lty=c(2,1,1), lwd=c(5,5,5));