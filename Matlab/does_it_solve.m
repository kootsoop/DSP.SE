syms t

I1 = 0.0230164*cos(100*t + 263.54/180*pi);
I1_phasor = 2.5575*cos(100*t - 96.45/180*pi);
I1_used = I1;

LHS = 0.009*diff(I1_used, t) + I1_used;
RHS = 3.4405*cos(100*t - 54.45/180*pi);

clf
figure(1)
fplot(LHS,[0,0.1])
hold on;
fplot(RHS,[0,0.1],'r+')
fplot(RHS-LHS,[0,0.1],'g')

% fplot(RHS/LHS,[0,1],'m.')
