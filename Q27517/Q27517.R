#27517

T <- 1000

HalfPulseLength <- 20

NPulses <- 10

PulsePositions <- sort(runif(NPulses, 1,T))

PulseProfile <- exp(-(-HalfPulseLength:HalfPulseLength)^2/100)

Signal <- rep(0,T)
Signal[PulsePositions] <- 1
Signal <- convolve(Signal, c(PulseProfile, rep(0,T-length(PulseProfile))))


Detector <- convolve(diff(Signal), c(PulseProfile, rep(0,length(diff(Signal))-length(PulseProfile))))


plot(Signal)
points(PulsePositions, rep(1,length(PulsePositions)), col="red", lwd=5)
lines(Detector)