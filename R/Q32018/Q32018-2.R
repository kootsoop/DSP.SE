# 32018
# Non-Bayer 2D interpolation

# Model pixels as:
# P(x,y) = (a_0 + a_1 * x + a_2 * x^2) * (b_0 + b_1 * y + b_2 * y^2)
#        = [a_0 a_1 a_2 b_0 b_1 b_2] * [1 x x^2 1 y y^2]^T 
# And so we need to find the a_i and b_i from specific pixel and coordinate values.
#
# install.packages('ptw')

require(ptw)

pad <- function(x,N)
{
  p1 <- ptw::padzeros(x,N,side="right")
  p2 <- t(ptw::padzeros(t(p1),N,side="right"))
  
  return(p2)
}

Npoints <- 8
xy <- array(c(c(1,1), c(1,5), c(2,3), c(3,6), c(4,2), c(4,4), c(5,6), c(6,3)), c(2,Npoints))
xy_norm <- (xy - min(xy))/(max(xy) - min(xy))
#Pxy <- array(runif(N, 0, 255), c(1,Npoints))

ImageSize <- max(xy)

Ired <- array(100000,c(ImageSize, ImageSize))

for (idx in 1:Npoints)
{
  Ired[xy[1,idx], xy[2,idx]] = Pxy[idx]
}

Ihatred <-array(0,c(ImageSize,ImageSize))
Ihatred2 <- Ired
count <- 0

while (sum(abs(Ihatred - Ihatred2)) > 1)
{
  Ihatred <- Ihatred2
  
  Fred <- fft(pad(Ihatred, 2*ImageSize))
  
  Fredsize <- dim(Fred)[1]
  cutoff1 <- Fredsize / 8
  cutoff2 <- 7 * Fredsize / 8
  
  Fred[4:16,] <- 0
  Fred[,4:16] <- 0
  
  IFred <- fft(Fred, inverse=TRUE) / Fredsize / Fredsize
  
  Ihatred2 <- Re(IFred[1:ImageSize, 1:ImageSize])
  
  for (idx in 1:Npoints)
  {
    Ihatred2[xy[1,idx], xy[2,idx]] = Pxy[idx]
  }
  
  count <- count + 1  
  if (count > 100)
  {
    break
  }  
}

    par(mfrow=c(1,2))
    image(Ired, col= grey(seq(0, 1, length = 256)))
    for (idx in 1:Npoints)
    {
      points(xy_norm[1,idx] , xy_norm[2,idx] , col="red", lwd=5)
    }
    title('Original with only known red pixels')
    image(Ihatred2, col= grey(seq(0, 1, length = 256)))
    title('POCS solution')
    for (idx in 1:Npoints)
    {
      points(xy_norm[1,idx] , xy_norm[2,idx] , col="red", lwd=5)
    }

