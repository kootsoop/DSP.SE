#28512

fs<-2205;
t <- seq(0,249/fs,1/fs);

f <- c(80, 120, 250, 560)
a <- c(4,1,0.89,0.65)
d <- c(70,50,90,80)

four_harmonics <- function(a,d,f)
{
  
  x <- array(0, c(4,length(t)))
  for (i  in seq(1,4))
  {
    x[i,]=a[i]*exp(-d[i]*t)*cos(2*pi*f[i]*t);  
  }
  
  y <- colSums(x)
  
  return(y)
}

mpencil <- function(y)
{
  N <- length(y)
  L1 <- ceiling(N/3)
  L2 <- floor(2*N/3)
  L <- ceiling((L1+L2)/2)
  
  Y <- array(0, c(N-L, L+1))
  
  for (i in seq(1,N-L))
  {
    Y[i,] <- y[i:(i+L)]
  }
  
  Y1 <- Y[,1:L]
  Y2 <- Y[,2:(L+1)]
  
  SVD <- svd(Y)
  
  m <- 0
  tol <- 0.001
  ll <- length(SVD$d) 
  for (i in seq(1,ll))
  {
    if (abs(SVD$d[i]/SVD$d[1]) > tol)
    {
      m <- m+1
    }
  }
  
  S <- diag(SVD$d)
  Ss <- S[,1:m]
  Vnew <- SVD$v[,1:m]
  a <- dim(Vnew)[1]
  
  Vs1 <- Vnew[1:(a-1),]
  Vs2 <- Vnew[2:a,]
  Y1 <- SVD$u %*% Ss %*% t(Vs1)
  Y2 <- SVD$u %*% Ss %*% t(Vs2)
  
  require(MASS)
  D_fil <- ginv(Y1) %*% Y2
  
  print(dim(D_fil))
  
  z <- eigen(D_fil)
  
  print(length(seq(1,length(z$values),2)))

##########################################   
  f <- rep(0,(length(z$values)+1)/2)    #
  d <- rep(0,(length(z$values)+1)/2)    #
  for (i in seq(1,length(z$values),2))  #
  {                                     #
    f[(i+1)/2] <- Arg(z$values[i]*fs)         #
    d[(i+1)/2] <- Re(z$values[i]*fs)          #
  }                                     #
##########################################

  val <- data.frame(f = f, d = d)
  return(val)
}


