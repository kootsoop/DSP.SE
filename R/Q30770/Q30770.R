# Q30770

library(png)
im <- readPNG('Q30770/q30770.png')

par(pty='s', mfrow=c(2,2))
image(t(im[,,1])[,nrow(im):1], xaxt='n', yaxt='n')
title('Original')

imR <- Re(fft(Re(fft(im[,,1])), inverse = TRUE))
imI <- Re(fft(Im(fft(im[,,1])), inverse = TRUE))
imA <- abs(fft(Im(fft(im[,,1])), inverse = TRUE))

image(t(imR)[,nrow(im):1], xaxt='n', yaxt='n')
title('Inverse of real part')

image(t(imI)[,nrow(im):1], xaxt='n', yaxt='n')
title('Inverse of imaginary part')

image(t(imA)[,nrow(im):1], xaxt='n', yaxt='n')
title('Inverse of absolute value')