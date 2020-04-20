#34799

#install.packages('tuneR', dep=TRUE)
#install.packages('Rwave', dep=TRUE)
library(tuneR)
library(Rwave)
sine_wave <- readWave('Q34799/Q34799.wav')
plot(sine_wave[1:1000])
title('First 1000 samples')

#vals <- WV(sine_wave@left[1:1000], 100)