function [omegaHat, phihat, Amphat, xremoved] = removeSinusoid(x)

N = length(x);
omegaHat = qnf(x');
DFT = sum(x.*exp(-1j*omegaHat*[0:N-1]));
phihat = angle(DFT);
Amphat = abs(DFT)/N*2;

xremoved = x - Amphat*cos(omegaHat*[0:N-1]+phihat);
end