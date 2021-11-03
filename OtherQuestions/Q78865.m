N = 1000;
fs = 1000;
t = [0:N-1]/fs;
omega = 2*pi*203;
phi = 2*pi*0.3459357;
x = sin(omega*t+phi);

clf
subplot(211);
title('No normalization')
plot(abs(fft(x(1:400), N)), 'linewidth', 8);
hold on;
plot(abs(fft(x(1:800), N)),'k', 'linewidth', 8);
plot(abs(fft(x, N)),'g', 'linewidth', 8);
axis([190 220 0 500])
subplot(212);
title('Normalized')
plot(abs(fft(x(1:400), N))/400, 'linewidth', 8);
hold on;
plot(abs(fft(x(1:800), N))/800,'k', 'linewidth', 8);
plot(abs(fft(x, N))/1000,'g', 'linewidth', 8);
axis([190 220 0 0.5])
