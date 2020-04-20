#30443

N <- 10

Ln_minus_1 <- rep(1,N*N)
dim(Ln_minus_1) <- c(N,N)

for (j in seq(1,N))
{
  for (k in seq(1,N))
  {
    Ln_minus_1[j,k] = (j + k) %% 2 
  }
}

Ln <- rep(1,N*N/4)
dim(Ln) <- c(N/2,N/2)

Ln2 <- rep(1,N*N/4)
dim(Ln2) <- c(N/2,N/2)

Ln3 <- rep(1,N*N/4)
dim(Ln3) <- c(N/2,N/2)

for (j in seq(1,N/2))
{
  for (k in seq(1,N/2))
  {
    Ln[j,k] = Ln_minus_1[2*j,2*k]
    Ln2[j,k] = Ln_minus_1[2*j-1,2*k]
    Ln3[j,k] = (Ln_minus_1[2*j,2*k] + Ln_minus_1[2*j-1,2*k-1] + Ln_minus_1[2*j,2*k-1] +Ln_minus_1[2*j-1,2*k] )/4
  }
}

par(mfrow=c(2,2), pty='s')
image(Ln_minus_1)
title('Ln_minus_1')

Ln[1,1] <- 0
Ln[N/2,N/2] <- 1
image(Ln) 
title('Ln no averaging v 1')

Ln2[1,1] <- 0
Ln2[N/2,N/2] <- 1
image(Ln2)
title('Ln no averaging v 2')

Ln3[1,1] <- 0
Ln3[N/2,N/2] <- 1
image(Ln3)
title('Ln with averaging')

