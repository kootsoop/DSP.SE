#Q42498
library('tuneR')
library(e1071)   

clean <- readWave('3500-clean.wav')
vibes <- readWave('3500-vibes.wav')

t_index <- seq(10000,11000)

par(mfrow=c(2,3))
plot(clean@left[t_index], type='l', col='blue', lwd=3)
lines(vibes@left[t_index], col='red')
title('Time doman 10000:11000')

plot(log(abs(fft(clean@left[t_index]))[1:500]), type='l', col='blue', ylim = c(8,15))
lines(log(abs(fft(vibes@left[t_index]))[1:500]), col='red')
title('Frequency domain 10000:11000')

library(signal)
bpf <- butter(10,c(0.4,0.8), type='pass')

clean_f <- filter(bpf, clean@left[t_index])
vibes_f <- filter(bpf, vibes@left[t_index])
plot(abs(fft(clean_f))[1:500], type='l', col='blue', lwd=3)
lines(abs(fft(vibes_f))[1:500], col='red')
title('Band Pass Filtered 10000:11000')

vibes_pdf <- density(vibes@left[t_index])
clean_pdf <- density(clean@left[t_index])
plot(clean_pdf$y/sum(clean_pdf$y), type='l', col='blue', lwd=3)
lines(vibes_pdf$y/sum(vibes_pdf$y), col='red')
title('PDF Estimate (Original)')

vibes_f_pdf <- density(vibes_f)
clean_f_pdf <- density(clean_f)
plot(clean_f_pdf$y/sum(clean_f_pdf$y), type='l', col='blue', lwd=3)
lines(vibes_f_pdf$y/sum(vibes_f_pdf$y), col='red')
title('PDF Estimate (filtered)')

maf <- rep(1,100)

clean_e <- filter(maf, 1, (clean@left[t_index])^2)
vibes_e <- filter(maf, 1, (vibes@left[t_index])^2)
plot(clean_e, type='l', col='blue', lwd=3, ylim=c(min(clean_e,vibes_e), max(clean_e,vibes_e)))
lines(vibes_e, col='red')
title('100 sample energy')

par(mfrow=c(1,1))
clean_e <- filter(maf, 1, (clean_f)^2)
vibes_e <- filter(maf, 1, (vibes_f)^2)
plot(clean_e, type='l', col='blue', lwd=3, ylim=c(min(clean_e,vibes_e), max(clean_e,vibes_e)))
lines(vibes_e, col='red')
title('100 sample energy (filtered)')
