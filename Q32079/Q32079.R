# 32079

par(mfrow=c(2,2))
image <- array(0,c(20,20))
image[8:13,8:13] <- 1
image(image, col= grey(seq(0, 1, length = 256)))
title("Original")

fftimage <- fft(image)
congfft <- Conj(fftimage)
ans1 <- fftimage * congfft
ans2 <- Re(fft(ans1, inverse=TRUE))/20/20
image(ans2, col= grey(seq(0, 1, length = 256)))
title("Without zero padding")

imagePadded <- array(0,c(40,40))
imagePadded[11:30,11:30] <- image
fftimagePadded <- fft(imagePadded)
congfftPadded <- Conj(fftimagePadded)
ans1a <- fftimagePadded * congfftPadded
ans2a <- Re(fft(ans1a, inverse=TRUE))/40/40
image(ans2a/max(ans2a), col= grey(seq(0, 1, length = 256)))
title("WITH zero padding")


persp(ans2a, theta=30)
title('Mesh plot WITH zero padding')