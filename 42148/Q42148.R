#42148

    group_delay <- 84 
    T <- 350
    
    omega <- 2*pi*0.252352890
    tau <- 0.005
    phi <- 2*pi*0.0989038
    t <- 1:T
    
    bruker_signal <- rep(0,T)
    t_index <- seq(group_delay, T)
    bruker_signal[t_index] <- exp(-(t_index-group_delay)*tau)*(sin(omega*t_index) + sin(1.5*omega*t_index + phi)) + rnorm(length(t_index),0, 0.1)

par(mfrow=c(2,2))

plot(bruker_signal, type='l')
title('Original Signal')
plot(abs(fft(bruker_signal))[1:175], type='l')
title('Original Spectrum ')

library(signal)
smile_filter <- butter(3,0.1)
smile_signal <- filter(smile_filter, bruker_signal)
plot(abs(fft(bruker_signal+2*smile_signal + 2*smile_signal*rep(c(1,-1), lenght.out=T)))[1:175], type='l')
title('Attempt at Smile Spectrum ')

frown_filter <- butter(3,0.1, 'high')
frown_signal <- filter(frown_filter, bruker_signal)
plot(abs(fft(bruker_signal+10*frown_signal))[1:175], type='l')
title('Attempt at Frown Spectrum ')
