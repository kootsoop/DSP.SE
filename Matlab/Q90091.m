A = [1, -1.1, 0.6];
B = [1.5, 0, 0];
N = 200;
dt = 0.001;
T = dt * N;
fs = 1 / dt;
t = 0:dt:(N-1)*dt;
u = zeros(1, N);
u(1) = 1;
h = filter(B, A, u);
s = zeros(1, N) + 1;
st = filter(B, A, s);
f1 = 20;
f2 = 100;
x = sin(2 * pi * f1 * t) + cos(2 * pi * f2 * t);
% Output used difference eq
y1 = filter(B, A, x);
% Output used impulse
y2 = conv(x, h);
y2 = y2(1:N);
% Output used fequency
Nfft = length(H) + length(X) - 1;
H = fft(h, Nfft);
X = fft(x, Nfft);
Y = X .* H;
y3 = ifft(Y);
figure(1);
plot(y1)
hold on
plot(y2,'r+')
plot(real(y3),'g.'),
axis([0 200 -8 8])
hold off;
