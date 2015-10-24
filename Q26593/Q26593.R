    # 26593
    # install.packages("png")
    # install.packages("EBImage") --- Didn't work.
    # ## try http if https is not available
    # source("http://bioconductor.org/biocLite.R")
    # biocLite("EBImage")
    
    #file <- "Q26593_original.png"
    file <- "Q26593_original_2.png"
    
    library(png)
    library(EBImage)
    
    img <- readPNG(file)
    
    d <- dim(img)
    
    #xx <- (0:(d[2]-1) - d[2]/2)/d[2]
    #yy <- (0:(d[1]-1) - d[1]/2)/d[1]
    #sigma <- 0.2
    
    #w <-  exp(-yy*yy/sigma) %*%  t(exp(-xx*xx/sigma)) 
    #w1 <- exp(-yy*yy/sigma) %*% t(rep(1,d[2]))
    
    f <- makeBrush(11, shape='disc', step=FALSE)
    imgf <- filter2(img, f)
    imgf <- imgf/max(imgf)
    
    par(mfrow=c(3,1))
    plot(1:2, type='n', main="Filtered Image", xlab="x", ylab="y")
    lim <- par()
    rasterImage(img, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4])
    
    #plot(1:2, type='n', main="Window Function", xlab="x", ylab="y")
    #lim <- par()
    #rasterImage(w1, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4])
    
    plot(colSums(img[,,1]), type="l", main="Column sum of UNfiltered image")

    plot(filter(colSums(img[,,1]), rep(1,11)), type="l", main="Column sum of UNfiltered image, filtered")
    