# https://dsp.stackexchange.com/questions/54090/image-processing-computer-vision-how-is-separability-of-filters-implemented
sobel <- 1/8*matrix(c(-1,-2,-1,0,0,0,1,2,1),c(3,3))
sobel_x <- 1/2*matrix(c(-1,0,1), c(1,3))
sobel_y <- 1/2*matrix(c(-1,0,1), c(3,1))
sobel_y2 <- 1/2*matrix(c(1,2,1), c(3,1))

sobel_y %*% sobel_x