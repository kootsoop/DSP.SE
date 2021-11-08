% 78979

N = 1000;
fs = 8000;
t = [0:N-1]/fs;
tt = [-N:2*N-1]/fs;
ttt = [-N*2:2*N-2]/fs;
pulse = exp(-t*50);
x = [zeros(1,N) pulse zeros(1,N)];

clf
subplot(311);
plot(tt, x);
subplot(313);
plot(ttt, xcorr(x,pulse),'.');

