#30451

signalLength <- 256
numberOfSignals <- 5000

database <- array(0,c(signalLength,numberOfSignals))

for (signal in seq(1,numberOfSignals-1,2))
{
  ix <- sample(signalLength,runif(1,min = 10, max = 15))
  database[ix,signal] <- runif(length(ix),min = 400, max = 600)
  ix2 <- sample(ix,10)
  database[ix2,signal+1] <- database[ix2,signal]
}

plot(colSums(database[,1]*database))
points(1,database[,1] %*% database[,1], col="green", lwd=5)
points(1,database[,2] %*% database[,2], col="red", lwd=5)