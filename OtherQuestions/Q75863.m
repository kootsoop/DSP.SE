N = 1024;
x = randn(1,N);

Nf = 128;
h = fir1(Nf,0.1);

h_real = ifftshift(h);

figure(1)
plot(h,'b');
hold on;
plot(h_real,'r');
title('Original (blue) and FFTSHIFT versions (red)');

y = filter(h,1,x);
y_real = filter(h_real,1,x);

figure(2)
subplot(211);
plot(abs(fft(y)));
title('FFT magnitude of white noise filtered with original');
subplot(212);
plot(abs(fft(y_real)));
title('FFT magnitude of white noise filtered with FFTSHIFT');

figure(3)
subplot(211);
plot(abs(fft(h,N)));
title('FFT of original zero padded to 1024 samples');
subplot(212);
plot(abs(fft(h_real,N)));
title('FFT of FFTSHIFT zero padded to 1024 samples');



