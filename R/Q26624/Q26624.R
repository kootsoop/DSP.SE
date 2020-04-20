#26624

Tperiod <- 0.2 #1.5 #s
Tpulse <- 0.010 # 10ms
f <- 150.2 * 10^6 # Hz

fs <- 1 * 10^6

Npulses <- 3
t <- seq(0, Tpulse, 1/fs)
pulse <- sin(2*pi*f*t )  
zeros <- rep(0,Tperiod*fs)

pulse_and_zeros <- c(pulse, zeros)

signal <- 0

for (n in 1:(Npulses-1))
{
  signal <- c(signal, pulse_and_zeros)
}