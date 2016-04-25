#30344

N <- 100
k <- 5
m_vals <- seq(-N,N)

Xm <- rep(0,2*N+1)

for (m in m_vals)
{
  Xm[m+N+1] <- sum(exp(-1i*2*pi*seq(0,N)*(m-k)/N))
}


plot(m_vals, Re(Xm), type="l", col="blue", xlab="m", ylab="X(m)")

title("Plot of X(m) vs m for m -100 to 100")