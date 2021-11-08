T = 1000;
fs = 44100;
t = [0:T-1]/fs;

f1 = 4000;
f2 = 12000;

x = chirp(t,f1,t(T) , f2);
xg = x.*exp(-0.005*abs([0:T-1]-(T-1)/2).^2/T);
figure(1);
clf;
subplot(311);
plot(x);
hold on;
plot(xg,'r');
subplot(312);
plot(abs(fft(x)));
hold on;
plot(abs(fft(xg)),'r');
subplot (313);
plot(xcorr(x,x));
hold on;
plot(xcorr(xg,xg),'r');
axis([950 1050 -400 600])
