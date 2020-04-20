x1 <- c(0,0,0,0,0,0,0,1,1,1,1,1,1,1,0,0)
x21 <- c(0,1,1,1,0)
x22 <- c(0,1,1,1,0,0)
x23 <- c(0,1,1,1,0,0,0)

my_conv <- function(x,y)
{
  out_length <- length(x)+length(y)-1
  x_pad <- c(x,rep(0,out_length-length(x)))
  y_pad <- c(y,rep(0,out_length-length(y)))
  
  z <- Re(fft(fft(x_pad) * fft(y_pad),inverse=TRUE))
  
  return(z/out_length)
}

my_deconv <- function(x,y, out_length=0)
{
  if (out_length == 0)
  {
    out_length <- length(x)+length(y)-1
  }
  x_pad <- c(x,rep(0,out_length-length(x)))
  y_pad <- c(y,rep(0,out_length-length(y)))
  
  z <- Re(fft(fft(x_pad) / fft(y_pad),inverse=TRUE))
  
  return(z/out_length)
}

par(mfrow=c(5,3))
plot(x1)
plot(x1)
plot(x1)
plot(x21)
plot(x22)
plot(x23)
y1 <- my_conv(x1,x21)
plot(y1)
y2 <- my_conv(x1,x22)
plot(y2)
y3 <- my_conv(x1,x23)
plot(y3)
plot(my_deconv(y1,x1))
plot(my_deconv(y2,x1))
plot(my_deconv(y3,x1))
plot(my_deconv(y1,x1,50))
plot(my_deconv(y2,x1,50))
plot(my_deconv(y3,x1,50))