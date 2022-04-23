T = 48000;
x = randn(1,T);
gen_lpf  = firpm(1024,[0 900/48000 1100/48000 1], [1 1 0 0]);
x = filter(gen_lpf, 1, x);

plot(abs(fft(x)))

t = [0:T-1];

c6 = cos(2*pi*t/(48000/6000));
s6 = -sin(2*pi*t/(48000/6000));

c5 = cos(2*pi*t/(48000/500));
s5 = sin(2*pi*t/(48000/500));

Nlp = 122;
Nhp = 122;

lpf = firpm(Nlp,[0 450/48000 550/48000 1], [1 1 0 0]);
hpf = firpm(Nhp,[0 2.5/48000 7.5/48000 1], [0 0 1 1]);

inphase = c6.*x;
quadrature = s6.*x;

lpfin = filter(lpf, 1, inphase);
lpfqd = filter(lpf, 1, quadrature);

hlin = filter(hpf,1,lpfin);
hlqd = filter(hpf,1,lpfqd);

plot(abs(fft(hlin)))

