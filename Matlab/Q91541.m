% 91541
fs = 1000;
N = 1024;
omega = 2*pi*12.345678/fs;

period = 2*pi/omega;
periods = N/period;

T = periods*2*pi/omega;
t = 0:1/fs:(T-1/fs);

x = cos(omega*t - phi);
y = -sawtooth(omega*t-phi*2, 0.5);
plot(t, x)
hold on;

plot(t, y);
hold off;

C = cos(omega*t);
S = sin(omega*t);

phi/pi*180
phi_hat = atan2(mean(S.*x), mean(C.*x))/pi*180
tri_hat = atan2(mean(S.*y), mean(C.*y))/pi*180

