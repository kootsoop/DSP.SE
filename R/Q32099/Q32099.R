# Q32099

require(jpeg)
setwd('/Users/kootsookosp/Documents/Professional/DSP.SE/R')
setwd('Q32099')

im1 <- readJPEG('Q32099-1.jpg')
im2 <- readJPEG('Q32099-2.jpg')

par(mfrow=c(2,2))
image(im1[,,1])
image(im2[,,1])