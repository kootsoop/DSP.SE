#42610

A <- c(1,0,0,1, 1, 1,0, 0)
dim(A) <- c(2,4)

ATA <- t(A)%*%A

library(MASS)
ATAm1 <- ginv(ATA)


