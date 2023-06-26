syms t 

A = 10;
B = 1.1211121;
omega = 2*pi*0.0121984;

x = A*cos(omega*t + B);
y = A*sin(pi/2-(omega*t+B));

fplot(x)
hold on;
fplot(y, 'g.')