#27517

T <- 1000

HalfPulseLength <- 20

NPulses <- 10

PulsePositions <- sort(runif(NPulses, 1,T))

PulseProfile <- exp(-(-HalfPulseLength:HalfPulseLength)^2/100)

RawSignal <- rep(0,T)
RawSignal[PulsePositions] <- 1
Signal <- convolve(c(PulseProfile, rep(0,T-length(PulseProfile))), RawSignal, type="open")


Detector <- convolve(diff(Signal), c(rev(PulseProfile), rep(0,length(diff(Signal))-length(PulseProfile))))


par(mfrow=c(1,1))
plot(Signal, ylim=c(-2,2))
lines(RawSignal, col="red", lwd=5)
lines(Detector, col="green")