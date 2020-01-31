library(imager)

N <- 128

noise <- array(runif(N*N*1*1),c(N,N,1,1)) #5x5 pixels, 1 frames, 1 colours. All noise
small_clumps <- as.cimg(noise)
blurry <- isoblur(small_clumps,5)

layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
plot(colSums(blurry-mean(blurry)))
plot(small_clumps)
plot(blurry)


large_clumps <- small_clumps
large_clumps[65:75, 65:75] <- 1
large_clumps[15:25, 35:45] <- 1
blurry_large <- isoblur(large_clumps,5)
# par(mfrow=c(3,1))
layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
plot(colSums(blurry_large-mean(blurry_large)))
plot(large_clumps)
plot(blurry_large)