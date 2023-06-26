N = 100;
omega_0 = 0.1*2*pi;
A = 0.001;
n = -N:N;
x = A*sin(omega_0*n)./(omega_0*n);
x(N+1) = A;
Xfft = fft(x);

subplot(221);
plot(n,x)
subplot(222);
plot(n/N/2, fftshift(abs(Xfft)))
subplot(223);
plot(n/N/2, fftshift(angle(Xfft)));
subplot(224);
plot(n/N/2, fftshift(unwrap(angle(Xfft))),'r:');
