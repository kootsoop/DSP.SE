N = 8; %total number of receivers
sigma2 = 0.00000001;
c = 3*10^5; % speed of electromagnetic waves
x = [0 8 7 1 5 9 3 1]; %xi receiver location
%x =  [0 1 2 3 4 5 6 7];
y = [0 1 9 9 2 5 8 4]; %yi receiver location
%y =  [0 0 0 0 0 0 0 0];
xs = 4; ys = 16; %real source location
xn = 6; yn = 10; %nominal source location
%xn = xs + 1; yn = ys + 1;
delta_xs = xs-xn; 
delta_ys = ys-yn;
R = zeros(1,N);
Rn = zeros(1,N);
co = zeros(1,N);
si = zeros(1,N);
epsilon = zeros(1,N);
for i=1:N
    R(i) = sqrt((xs-x(i))^2+(ys-y(i))^2);
    Rn(i) = sqrt((xn-x(i))^2+(yn-y(i))^2);
    co(i) = (xn-x(i))/Rn(i); %cosai
    si(i) = (yn-y(i))/Rn(i); %sinai
    epsilon(i) = sigma2*randn(1,1); %e1,e2,..
end
xi = zeros(N-1,1);
for i=1:N-1
    xi(i) = 1/c*(co(i+1)-co(i))*delta_xs + 1/c*(si(i+1)-si(i))*delta_ys + epsilon(i+1)-epsilon(i); %linear model (6.26)
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
 
C = sigma2*A*transpose(A);
Cinv = pinv(C);
estTheta = pinv(transpose(H)*Cinv*H)*transpose(H)*Cinv*xi; % eq. 6.27

abs(estTheta)
sigma2*pinv(transpose(H)*pinv(A*transpose(A))*H)

plot(x,y,'ro')
hold on
plot(xn,yn,'g+','LineWidth',8)
plot(xs,ys,'k+','LineWidth',8)
hold off;
