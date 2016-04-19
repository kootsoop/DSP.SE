#30103

# First, construct the signal model and generate the data.
T <- 1000

sigma_n <- 0.1
n_k <- array(rnorm(T*3,0, sigma_n), c(3,T))

sigma_m <- 0.01
m_k <- array(rnorm(T*3,0, sigma_m), c(3,T))

F <- array(c(1,0,0, 0, 1, 0, 0, 0,1),c(3,3))

x_0 <- array(0,c(3,1))
x <- array(0,c(3,T))
x[,1] <- x_0

z <- array(0,c(3,T))


for (k in 2:T)
{
  x[,k] <- F %*% x[,k-1] + n_k[,k]
  z[,k] <- `^`(x[,k],2) + m_k[,k]
}


# Next, form the EKF
H <- 2* array(c(1,0,0, 0, 1, 0, 0, 0,1),c(3,3))

Q <- sigma_m^2*array(c(1,0,0, 0, 1, 0, 0, 0,1),c(3,3))
R <- sigma_n^2*array(c(1,0,0, 0, 1, 0, 0, 0,1),c(3,3))

library("MASS") # For pseudo inverse ginv()

xkm1km1 <- matrix(rep(0,3*T+3),3,T+1)
xkm1km1[,1] <- x_0

xkkm1 <- matrix(rep(0,3*T),3,T)
K <- array(rep(0,3*3*T),c(3,3,T))
Pkm1km1 <- array(0,c(3,3,T+1))
Pkm1km1[,,1] <- array(c(1000,0,0 ,0,1000,0, 0,0,1000), c(3,3))
                  
zhat <- matrix(rep(0,3*T),c(3,T))
err <-  matrix(rep(0,3*T),c(3,T))

for (k in 2:T)
{  
  xkkm1[,k] <- F %*% xkm1km1[,k-1]
  Pkkm1 <- F %*% Pkm1km1[,,k-1] %*% t(F) + Q
  
  #H <- 2*diag(xkkm1[,k])
  
  K[,,k] <- Pkkm1 %*% t(H) %*% ginv( H %*% Pkkm1 %*% t(H) + R)
  err[,k] <- z[,k] - H %*% xkkm1[,k]
  xkm1km1[,k] <- xkkm1[,k] + K[,,k] %*% err[,k]
  Pkm1km1[,,k] <- (matrix(c(1,0,0,0,1,0,0,0,1),3,3) - K[,,k] %*% H) %*% Pkkm1  
  zhat[,k] <- as.numeric(H %*% xkkm1[,k])
}

par(mfrow = c(3,1), pty="m")
plot(x[1,], col="grey",ylim=c(-10,20))
lines(xkm1km1[1,], col="red")
plot(x[2,], col="grey",ylim=c(-10,20))
lines(xkm1km1[2,], col="red")
plot(x[3,], col="grey",ylim=c(-10,20))
lines(xkm1km1[3,], col="red")

