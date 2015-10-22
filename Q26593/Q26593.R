    # 26593
    # install.packages("png")
    
    file <- "Q26593_original.png"
    
    library(png)
    
    img <- readPNG(file)
    
    d <- dim(img)
    
    par(mfrow=c(2,1))
    plot(1:2, type='n', main="Plotting Over an Image", xlab="x", ylab="y")
    lim <- par()
    rasterImage(img, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4])
    
    plot(colSums(img[,,1]), type="l")
