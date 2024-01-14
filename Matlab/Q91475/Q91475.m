T = 1/100e6;
t = 0:T:0.1;
sig = sin(2*pi*20*t);

figure(1)
h = histogram(sig);
hdata = h.Values;
ch = cumsum(hdata);

T = -cos(pi*ch/sum(hdata));
hlin = T(2:end) - T(1:end-1);

trunc = 2;
hlin_trunc = hlin(1+trunc:end-trunc);
lsb = sum(hlin_trunc)/(length(hlin_trunc));
dnl = [0 hlin_trunc/lsb-1];

inl =cumsum(dnl);
figure(2)
plot(inl)