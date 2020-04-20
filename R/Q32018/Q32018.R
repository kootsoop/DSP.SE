# 32018
# Non-Bayer 2D interpolation

# Model pixels as:
# P(x,y) = (a_0 + a_1 * x + a_2 * x^2) * (b_0 + b_1 * y + b_2 * y^2)
#        = [a_0 a_1 a_2 b_0 b_1 b_2] * [1 x x^2 1 y y^2]^T 
# And so we need to find the a_i and b_i from specific pixel and coordinate values.
#

Npoints <- 8
xy <- array(c(c(1,1), c(1,5), c(2,3), c(3,6), c(4,2), c(4,4), c(5,6), c(6,3)), c(2,Npoints))

xy_norm <- (xy - min(xy))/(max(xy) - min(xy))

Pxy <- array(runif(N, 0, 255), c(1,Npoints))

coords <- array(0,c(Npoints,6))

poly_pieces <- function(x,y)
{
  c(1 , 1 - x,  0.5*(x^2 - 4*x + 2), 1, 1 - y, 0.5*(y^2 - 4*y + 2))
}

for (idx in 1:Npoints)
{
  coords[idx,] <- poly_pieces(xy_norm[1,idx], xy_norm[2,idx])
}

require(MASS) # for ginv

inv <- ginv(coords)
coeffs <- inv %*% t(Pxy)
re_Pxy <- coords %*% coeffs

par(mfrow=c(2,2))
plot(1:Npoints, Pxy, col="green", type='l', ylim=c(0,255))
lines(re_Pxy)

image <- array(NA,c(max(xy), max(xy)))
int_image <- image
re_image <- image
for (idx in 1:Npoints)
{
  image[xy[1,idx], xy[2,idx]] <- Pxy[idx]
  re_image[xy[1,idx], xy[2,idx]] <- re_Pxy[idx]
}


int_coords <- array(0, c(2, max(xy), max(xy)))
for (i in 1:max(xy))
{
  for (j in 1:max(xy))
  {
    ii <- (i - min(xy))/(max(xy) - min(xy))
    jj <- (j - min(xy))/(max(xy) - min(xy))
    int_coords[1,i,j] <- ii
    int_coords[2,i,j] <- jj
    int_image[i,j] =  poly_pieces(ii,jj) %*% coeffs
  }
}
image(image, zlim=c(0,255))
image(re_image, zlim=c(0,255))
image(int_image, zlim=c(0,255))