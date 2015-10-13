# 26383

img <- runif(128*128, 0, 1)
dim(img) <- c(128, 128)

img[32:96,32:96] <- 1

N <- 50

imgFFT <- fft(img)
imgFFT[N:(128-N+2),] <- 0.0000000000000
imgFFT[,N:(128-N+2)] <- 0.0000000000000
img2 <- fft(imgFFT, inverse = TRUE) / 128 / 128

img2[Mod(img2) > 1] <- 1

mx <- max(log(Mod(imgFFT + 0.00001)))
mn <- min(log(Mod(imgFFT + 0.00001)))

scaled_log_imgFFT <- (log(Mod(imgFFT + 0.00001)) - mn)/(mx - mn)

par(pty="s") # make the plit square
plot(0:256, type='n')
rasterImage(as.raster(img),0,128,128,256)
rasterImage(as.raster(scaled_log_imgFFT),128,128,256,256)
rasterImage(as.raster(Mod(img2)),128,0,256,128)
