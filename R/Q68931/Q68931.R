library(signal)

FFTsize <- 2^20;  
sig_out <- rnorm(1000)
fz <- freqz(sig_out,1,FFTsize) 
fz
