# 43563

N <- 1024

fs <- c(20000, 10000, 1000) #, 100
res <- c(0,0,0,0)
idx <- 1

par(mfrow=c(4,2))
for (freq in fs)
{
  res[idx] <- freq / N
  idx <- idx + 1
  t <- seq(0,N-1) / freq
  x <- sin(2*pi*t + 0.892340923)
  plot(x, type='l')
  title(paste('time domain for ', freq))
  x_fft <- abs(fft(x))
  plot(x_fft[1:100], type='l')
  title(paste('100 bins in frequency domain for ', freq))
}

