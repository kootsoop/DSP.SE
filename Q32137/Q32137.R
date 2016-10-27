# Q32137
setwd('/Users/kootsookosp/Documents/Professional/DSP.SE/R')
setwd('Q32137')

data <- read.csv('data.csv')

par(mfrow=c(2,1))
plot(data$Time, data$Value)
title('Time data')
plot(abs(fft(data$Value-mean(data$Value))), type="l")
title('Mean-removed FFT without using time index')