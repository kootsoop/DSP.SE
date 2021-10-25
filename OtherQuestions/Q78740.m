% syms t tau 
a = 10;
omega = 2*pi*100;
f = symfun(a*exp(-a^2/(4.0*tau))/(2.0*sqrt(pi)*tau^(3.0/2.0)),tau);
g = symfun(exp(1i*omega*(t-tau))*exp(-0.5*(t-tau)),[t tau]);
z = int(f*g,tau,-inf,inf);
z = simplify(z);
figure(1)
ezplot(f, [0 100 -0.001 0.01])
% figure(2)
% ezplot(z)