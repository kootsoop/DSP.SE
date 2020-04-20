#29899

library("signal")

N <- 125

f1 <- remez(N - 1, c(0, 0.3, 0.4, 1), c(1, 1, 0, 0))
#    plot(f1,type="l")
#    dev.copy(png, 'Q29899-ImpulseResponse.png')
#    dev.off()

freq <- seq(-pi,pi,pi/200/N)

Nf <- length(freq)

#    complex_magnitude <- polyval(f1[c((N+1)/2:N,1:(N-1)/2)], exp(-1i*freq))
complex_magnitude <- polyval(f1, exp(-1i*freq))

plot(freq, unwrap(Arg(complex_magnitude)), type="l");
dev.copy(png, 'Q29899-UnwrappedPhase.png')
dev.off()

plot(freq[60000:100000],Arg(complex_magnitude[60000:100000]), type="l")
lines(freq[c(60000,100000)],c(pi/2,pi/2), col="red")
lines(freq[c(60000,100000)],c(-pi/2,-pi/2), col="red")
title('Stop band phase detail')
dev.copy(png, 'Q29899-PhaseDetailWrapped.png')
dev.off()

plot(freq[1:10000],Arg(complex_magnitude[1:10000]), type="l")
lines(freq[c(1,10000)],c(pi/2,pi/2), col="red")
lines(freq[c(1,10000)],c(-pi/2,-pi/2), col="red")
title('Pass band phase detail')
dev.copy(png, 'Q29899-PhaseDetailWrappedPassband.png')
dev.off()
