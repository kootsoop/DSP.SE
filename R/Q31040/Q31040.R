    #Q31040
    
    
    data <- read.csv('Q31040/data.csv')
    
    par(mfrow=c(2,1))
    plot(data, type='l', col="blue")
    
    zero_padded_data <- c(data$Volts, rep(0,1000))
    
    omega <- seq(0,2*pi - 2*pi/length(zero_padded_data),2*pi/length(zero_padded_data))
    fft_data <- abs(fft(zero_padded_data))
    plot(omega, fft_data, type='l', col="blue")
    
    peak <- which.max(fft_data)
    points(omega[peak], fft_data[peak], col="red", lwd = 5)
    title(paste("Peak location is", omega[peak]))