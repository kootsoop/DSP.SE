#27668

Nstate <- 5
x0 <- rep(0,Nstate) #The state vector starts at all zeros

sigmas <- c(0.1,0.1,0,0,0.001)
Q <- diag(sigmas)


create_measurements <- function(x,y,radius,roll,pitch,yaw)
{
  measurements <- c(x,y+radius,x,y-radius,x+radius,y,x-radius,y)
  dim(measurements) <- c(2,4)
  
  yaw <- c(cos(yaw), -sin(yaw), sin(yaw), cos(yaw))
  dim(yaw) <- c(2,2)
  
  measurements <- yaw %*% measurements
  
  return(measurements)
}

T <- 1000
x <- rep(0,Nstate*T)
dim(x) <- c(T,Nstate)

for (t in 1:T)
{
  for (n in 1:Nstate)
  {
    if (t<T)
    {
      x[t+1,n] <- x[t,n] + rnorm(1,0, sigmas[n])
    }
  }
}

plot(x[,1],x[,2], type="l")
points(x[1,1],x[1,2],col="green",lwd=10, pch=5)
points(x[T,1],x[T,2],col="red",lwd=10)

radius <- 0.1
for (t in 1:T)
{
  z <- create_measurements(x[t,1], x[t,2], radius, x[t,3], x[t,4], x[t,5])  
  points(z[1,1], z[2,1], col="red", pch=18)
  points(z[1,2], z[2,2], col="green", pch=18)
  points(z[1,3], z[2,3], col="yellow", pch=18)
  points(z[1,4], z[2,4], col="blue", pch=18)
}