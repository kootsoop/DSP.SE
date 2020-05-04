N = 8; %total number of receivers
var = 1;
c = 3*10^5; % speed of electromagnetic waves
x = [0 8 7 1 5 9 3 1]; %xi receiver location
y = [0 1 9 9 2 5 8 4]; %yi receiver location
xs = 3; ys = 6; %real source location
xn = 6; yn = 10; %nominal source location
Sxs = xs-xn; Sys = ys-yn;
for i=1:N
    R(i) = sqrt((xs-x(i))^2*(ys-y(i))^2);
    Rn(i) = sqrt((xn-x(i))^2*(yn-y(i))^2);
    co(i) = (xn-x(i))/Rn(i); %cosai
    si(i) = (yn-y(i))/Rn(i); %sinai
    noise(i) = var*randn(1,1); %e1,e2,..
end
for i=1:N-1
    e(i) = 1/c*(co(i+1)-co(i))*Sxs+1/c*(si(i+1)-si(i))*Sys+noise(i+1)-noise(i); %linear model (6.26)
end
H = 1/c*[co(2)-co(1) si(2)-si(1);
         co(3)-co(2) si(3)-si(2);
         co(4)-co(3) si(4)-si(3);
         co(5)-co(4) si(5)-si(4);
         co(6)-co(5) si(6)-si(5);
         co(7)-co(6) si(7)-si(6);
         co(8)-co(7) si(8)-si(7)];

A = [-1 1 0 0 0 0 0 0;
     0 -1 1 0 0 0 0 0;
     0 0 -1 1 0 0 0 0;
     0 0 0 -1 1 0 0 0;
     0 0 0 0 -1 1 0 0;
     0 0 0 0 0 -1 1 0;
     0 0 0 0 0 0 -1 1];
inaaT = inv(A*transpose(A));
estTheta = inv(transpose(H)*inaaT*H)*transpose(H)*inaaT*transpose(e); % eq. 6.27