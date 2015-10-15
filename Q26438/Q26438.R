# 26438

Nsigs <- 6
T<- 1024
omega <- 2*pi*0.00982734982
t <- 0:(T-1)

y <- matrix(,nrow = T, ncol = Nsigs)
phi <- c(0, 1*pi/6, 2*pi/6, 3*pi/6, 4*pi/6, 5*pi/6 )

for (idx in 1:Nsigs)
{
  #phi[idx] <- runif(1)*2*pi
  y[,idx] <- sin(omega*t + phi[idx])  
}

mean <- rowSums(y) / Nsigs

total <- matrix(,nrow = T, ncol = Nsigs+1)
total[,1] <- mean
total[,2:(Nsigs+1)] = y

pearson <- cor(total,use="complete.obs", method="pearson")

par(mfrow=c(2,1),pty="m")
plot(t,mean, type="l")
title("Mean value")

plot(1:6, pearson[1,2:7], pch=19, col="blue")
title("Pearson coefficient")
