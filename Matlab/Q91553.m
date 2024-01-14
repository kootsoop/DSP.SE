% 91553
m = 2.333;
c = 1.1180;
N = 1000;
n = 0:N-1;

y = m*n + c + randn(1,N)/2;
z = filter(ones(1,10)/10,1,y);

coefs = polyfit(n, y, 1);
yy = detrend(y);
z2 = filter(ones(1,10)/10,1,[flip(yy),yy,flip(yy)]);
zz = z2(N + n) + coefs(2) +coefs(1)*n;

subplot(211)
plot(n,y)
hold on;
plot(n,z);
plot(n,zz);
hold off;

subplot(212);
plot(n,y-z);
hold on;
plot(n,y-zz,'r.');
hold off;