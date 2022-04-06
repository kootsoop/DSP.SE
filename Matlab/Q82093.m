clc
clear
syms z n
H1=(z*(z-1))/((z+1/5)*(z+1/3))
pretty(H1);
f=iztrans(H1,n);
pretty(f)
H2=ztrans(f)
% pretty(H1-H2)