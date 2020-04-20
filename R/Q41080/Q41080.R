# 41080
p <- c(1, 10,88,256,0)
plot(roots(p))
lines(c(-4,0), c(5.06,5.06), col="red")
lines(c(-4,0), c(-5.06,-5.06), col="red")
Kvalues <-  seq(-10000,10000,10)

pv <- rep(0, length(Kvalues)*4)
dim(pv) <- c(length(Kvalues), 4)
idx <- 1

for (k in Kvalues) 
{ 
  p[5] = k; 
  pv[idx,] <- roots(p)
  points(pv[idx,]); 
  idx <- idx + 1
}

