# 28338
T <- 10000
sigma  <- 1

A <- rnorm(T,0,sigma)
theta <- runif(T,0, 2 * pi)

fs <- 100
t <- (1:T)/fs
omega <- 2* pi * 0.0892987
Z <- A * cos(omega*t + theta)

# First diagram
hist(sin(omega*t))

# Second diagram
dA <- density(A)
dZ <- density(Z)
plot(dZ, col="red", lwd=5)
lines(dA, col="green", lwd=5)

# Third diagram
qqnorm(A)
qqline(A, col = 2)

# Fourth diagram
qqnorm(Z)
qqline(Z, col = 2)


