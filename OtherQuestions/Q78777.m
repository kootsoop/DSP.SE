syms s;
R = 10;
C = 1* 10^-6;
H = R/(R*C*s + 1);
[Hnum,Hden] = numden(H);
Htf = tf(sym2poly(Hnum), sym2poly(Hden));
Hinv = inv(H);
% https://stackoverflow.com/a/20539050/12570
proper_derivative = s/(1 + 0.0001*s);
Hinv2 = subs(Hinv,{s},{proper_derivative});
[Hinv2_num,Hinv2_den] = numden(Hinv2);
Hinv2tf = tf(sym2poly(Hinv2_num),sym2poly(Hinv2_den));

t = [0:999]*0.01;
i_in = cumsum(randn(1,1000));
v_out = lsim(Htf, i_in, t);

i_est = lsim(Hinv2tf, v_out, t);

clf
plot(v_out, 'k');
hold on;
plot(i_est, 'go');
plot(i_in, 'm');
