#30035

library("signal")

bf <- butter(5, 0.1)
freqz(bf)
dev.copy(png, 'Q30035/Q30035-Butterworth.png')
dev.off()

k <- 2
bf2 <- bf
bf2$a <- bf$a + k*bf$b
bf2$b <- bf$a*k
freqz(bf2)
dev.copy(png, 'Q30035/Q30035-Feedback.png')
dev.off()
