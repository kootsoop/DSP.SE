N = 1000;
ts = 0.001;
t = (0:N-1)*ts;
omega = 2*pi*23;
phi = 2*pi*0.829879;
Nsmooth = 10;
Nextra = 10*Nsmooth;

x = sin(omega*t+phi);
xx = [ fliplr(x(1:Nextra)) x fliplr(x((end-Nextra):end)) ];
y = filter(ones(1,Nsmooth)/Nsmooth, 1, x);
zz = filtfilt(ones(1,Nsmooth)/Nsmooth, 1,x);

clf;
plot(x);
hold on;
plot(y,'r');
plot(zz,'k+');