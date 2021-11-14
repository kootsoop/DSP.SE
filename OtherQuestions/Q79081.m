N = 128;
x = ones(1,N);
X = fft(x,N*10);
omega = [0:10*N-1]/(10*N)*2*pi*(N-1)/2;
subplot(211)
plot(real(X.*exp(1i*omega)))
subplot(212)
plot(imag(X.*exp(1i*omega)))