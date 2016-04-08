#29931

library("signal")

N <- 125

f1 <- remez(N - 1, c(0, 0.3, 0.4, 1), c(1, 1, 0, 0))
#    plot(f1,type="l")

input <- c(c(array(0, c(1,200)),array(1, c(1,200))))

F1 <- fft(c(f1, array(0,c(1,1000-length(f1)))))
INPUT <- fft(c(input, array(0,c(1,1000-length(input)))))

OUTPUT <- F1*INPUT
output <- fft(OUTPUT, inverse = TRUE)

par(mfrow = c(3,1))
plot(input, type="l")
title("Input")
plot(f1, type="l")
title("Non-minimum phase filter")
plot(Re(output[1:400]), type="l")
title('Output')
