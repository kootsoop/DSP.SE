Fs = 44100;
fr = 490.89;
wr = 2*pi*fr/Fs;
delta_wr = 2*pi*50/Fs;
k1 = -cos(wr)
k2 = (1-tan(delta_wr/2))/(1+tan(delta_wr/2))

%TF H(z)
c = (1+k2)/2, num = [1 2*k1 1], den = [1 k1*(1+k2) k2]

freqz(c*num, den, 2e6, Fs)