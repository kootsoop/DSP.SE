a = 1;
b = 2;
c = 3;
N = 1000;
fs = 10000;
omega1 = 2*pi*1234;
omega2 = exp(1)*1234;
omega3 = sqrt(2)*pi*1234;
rng(1234);
phi1 = rand(1)*2*pi;
phi2 = rand(1)*2*pi;
phi3 = rand(1)*2*pi;

t = [0:N-1]/fs;

x = a*cos(omega1*t+phi1) + b*cos(omega2*t + phi2) + c*cos(omega3*t+phi3) + 0.1*randn(1,1000);
figure(1);
clf;
subplot(211);
plot(t,x);
subplot(212);
plot(abs(fft(x)));

[omegaA, phiA, AmpA, x2] = removeSinusoid(x);
[omegaB, phiB, AmpB, x3] = removeSinusoid(x2);
[omegaC, phiC, AmpC, x4] = removeSinusoid(x3);

figure(2);
clf;
subplot(311);
plot(abs(fft(x2)));
subplot(312);
plot(abs(fft(x3)));
subplot(313);
plot(abs(fft(x4)));


