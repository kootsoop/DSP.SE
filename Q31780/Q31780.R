#31780
T <- 1000
x <- rnorm(T,0,1)

ix <- seq(1,T)

ix_hpts <- chull(x = ix, y= x)

plot(ix_hpts, x[ix_hpts], type='l', col='red')
points(ix, x)
