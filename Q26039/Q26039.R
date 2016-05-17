#26039

theta <- seq(-90,90) # Look directions
N <- length(theta) # Number of look directions
d <- 0.1 # Sensor separation
c <- 1 # Wave velocity
M <- 5 # Number of receivers
wmax <- 3*c*pi/d

num_w <- 2
W <- length(num_w)
y <- array(0, c(N,W))
z <- y

wk <- 2
s <- matrix(c(0.65 * exp(1i*wk), exp(1i*wk)), nrow = 2, ncol = 1)
k <- 2
doa <- c(60, -40)

ws <- wk*d*sin(pi*doa/180)/c

if (abs(max(ws)) > pi || abs(max(doa)) > 90)
{
  error("Aliasing!")
}

a <- matrix(c(t(exp(-1i*ws[1]*seq(0,M-1))), t(exp(-1i*ws[2]*seq(0,M-1)))), nrow = 2, ncol = M)

x <- Conj(t(s))  %*% a

R <- acf(x, lag.max = M-1)
