#31352

duration <- 10

data <- array(0, c(9,duration))
for (order in 1:9)
{
  but_filt <- butter(order, 0.2512312)
  #gd <- grpdelay(but_filt)
  #data[order,] <- gd$gd
  data[order,] <- impz(but_filt, n=duration)$x
  if (order == 1)
  {
    plot(0:(duration-1),data[order,]+(order-1), ylim=c(-1, 9), type="l")
  }
  else
  {
    lines(0:(duration-1),data[order,]+(order-1))
  }
  ix <- which.max(data[order,])
  points(ix-1, data[order,ix]+(order-1), col='red', lwd=10)
}

#butter5 <- butter(5,0.5)
#butter8 <- butter(8,0.5)

#delay5 <- grpdelay(butter5)
#delay8 <- grpdelay(butter8)

#plot(delay5)
#lines(delay8)