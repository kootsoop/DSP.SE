    #30406
    
    require("EBImage")
    
    image_url <- "http://www.lhup.edu/~dsimanek/3d/stereo/sailboats.jpg"
    image_file <- basename(image_url)
    
    if (!file.exists(image_file))
    {
      download.file(image_url,image_file)
    }
    
    library(jpeg)
    image <- readJPEG(image_file)
    dims <- dim(image)
    
    i1 <- flip(t(image[,1:(dims[2]/2),1]))
    i2 <- flip(t(image[,(dims[2]/2 + 1):dims[2],1]))
    
    I1 <- fft(i1)
    I2 <- fft(i2)
    
    I3 <- abs(I1) * exp(1i*Arg(I2))
    i3 <- abs(fft(I3, inverse = TRUE) / length(I3))
    
    par(mfrow=c(2,2))
    image(i1, col  = gray((0:32)/32), axes = FALSE)
    title("Image 1")
    image(i2, col  = gray((0:32)/32), axes = FALSE)
    title("Image 2")
    image(i3, col  = gray((0:32)/32), axes = FALSE)
    title("1's amplitude, 2's phase")
