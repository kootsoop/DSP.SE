a = 1;
b = 2;
N = 1000;
fs = 10000;
omega1 = 2*pi*1234;
omega2 = omega1*(1+3/N);
rng(1234);
phi1 = rand(1)*2*pi;
phi2 = rand(1)*2*pi;

t = [0:N-1]/fs;

x = a*cos(omega1*t+phi1) + b*cos(omega2*t + phi2) + 0.1*randn(1,1000);
figure(1);
clf;
subplot(221);
plot(t,x);
subplot(222);
plot(abs(fft(x)));

[omegaA, phiA, AmpA, x2] = removeSinusoid(x);
[omegaB, phiB, AmpB, x3] = removeSinusoid(x2);

subplot(223);
plot(abs(fft(x2)));
subplot(224);
plot(abs(fft(x3)));
