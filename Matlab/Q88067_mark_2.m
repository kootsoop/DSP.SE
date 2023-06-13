syms w t

N = 1000; %number of discrete frequencies to digitize the continuous spectrum
a = 1.2566; %constant
b = 0.00078956; %constant

%The spectrum
G = a./sqrt(b*w);

g = ifourier(G,w, t);
