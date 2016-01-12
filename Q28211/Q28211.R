    #28211
    
    x1 <- 10
    y1 <- 10
    
    
    x2 <- 90
    y2 <- 90
    
    z1 <- matrix(0,100,100)
    z2 <- z1
    ztot <- z1
    
    for (x in 1:100)
    {
      for (y in 1:100)
      {
        z1[x,y] <- sin(sqrt(((x-x1)^2 + (y-y1)^2))) 
        z2[x,y] <- sin(sqrt(((x-x2)^2 + (y-y2)^2)))
        ztot[x,y] <- z1[x,y] + z2[x,y]
      }
    }
    
    par(pty="s", mfrow=c(3,1))
    image(1:100,1:100,z1)
    points(x1,y1,lwd=10,col="green")
    points(x2,y2,lwd=10,col="blue")
    image(1:100,1:100,z2)
    points(x1,y1,lwd=10,col="green")
    points(x2,y2,lwd=10,col="blue")
    image(1:100,1:100,ztot)
    points(x1,y1,lwd=10,col="green")
    points(x2,y2,lwd=10,col="blue")