#30341

library("signal")

xi <- 0.5
omega_n <- 0.3

target_den <- c(1, 2*xi*omega_n, omega_n*omega_n)

target_roots <- roots(target_den)

num <- c(0, 0.5, 0.5)
den <- c(1, -2, 1)

start_roots <- roots(den)

par(pty="s")
plot(Re(start_roots),Im(start_roots),xlim=c(-5,5),ylim=c(-5,5), col="black", lwd=5)
points(Re(target_roots), Im(target_roots), col="green", lwd = 3)
for (k in seq(-100.0, 100.0, 0.1))
{
  rts <- roots(k*num + den)
  points(Re(rts), Im(rts), col="red")
}

theta <- seq(-1,1,.01)*pi
lines(sin(theta), cos(theta), col="black")