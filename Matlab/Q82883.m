
T = 1024;
N = 128;
x = randn(1,T);

X = fft(x);

XX = zeros(1,N);

for k=0:(N-1)
    for t=0:(T-1)
        XX(k+1) = x(t+1)*exp(-1j*2*pi*t*k/N) + XX(k+1);
    end
end

plot([0:T-1]/T,abs(X));
hold on;
plot([0:N-1]/N,abs(XX),'r.')
