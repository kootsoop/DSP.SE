# 26403

#install.packages('rwirelesscom')

#library("rwirelesscom")

#M=4
#Nsymbols=10
#Nbits=log2(M)*Nsymbols
#bits <- sample(0:1,Nbits, replace=TRUE)
#s <- fqpskmod(bits)

rm(inphase)
rm(quadrature)
Nsps <- 16
fc <- 0.1
t <- 0:(Nsps-1) - (Nsps-1)/2
inphase <- matrix(,nrow = 1, ncol = Nsps)
quadrature <- matrix(,nrow = 1, ncol = Nsps)
for (n in 1)
{
  inphase[n,] <- cos(2*pi*fc*t)
  quadrature[n,] <- sin(2*pi*fc*t)
}

#par(mfrow=c(2,2))
#plot(inphase[1,], quadrature[1,])
#points(inphase[2,],quadrature[2,], type="l", col="blue")
plot(inphase[1,]*inphase[1,],quadrature[1,]*quadrature[1,], xlim=c(-1,1),ylim=c(-1,1), pch=17, main=paste("Constellation diagram for " , toString(Nsps), " samples per symbol"))
points(inphase[1,]*inphase[1,],-quadrature[1,]*quadrature[1,], col="blue", pch=0)
points(-inphase[1,]*inphase[1,],quadrature[1,]*quadrature[1,], col="green", pch=1)
points(-inphase[1,]*inphase[1,],-quadrature[1,]*quadrature[1,], col="red", pch=2)