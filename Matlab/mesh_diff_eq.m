syms I1

Vs = 12;
Is = 4*exp(1j*90/180*pi);
I2 = Is;

e(1) = -Vs + 4*I1  + (I1 + Is)*(5 + 1/(1j*100*0.001))==0;

sln = solve(e, I1)

I1val = double(sln)

% -Vs + 4*I1val  + (I1val + Is)*(5 + 1/(1j*100*0.001))

Vout = 5*(I1val + I2)
[abs(Vout) angle(Vout)/pi*180]