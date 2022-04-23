N = 10000;
M=4;BT = 0.5; Tb = 2;
a = randi([0,1],N,1);
ak = 2*a-1; 
ak_rect = kron(ak,ones(M,1)); 
h_g = gaussfir (BT,Tb,M);
ov_f = conv(h_g,ak_rect,'full');
ov_f = ov_f/max(abs(ov_f));
phi_f = filter(1,[1,-1],ov_f);
phi = phi_f *0.5*pi/Tb;  % phase of the signal
I = cos(phi);
Q = sin(phi);
s_e = I - 1i*Q; % My signal: complex numbers