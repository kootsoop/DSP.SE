%% Chirped waveform
clearvars
close all

fs = 1e3;
t = 0:1/fs:0.5;
L = length(t);
y = chirp(t,0,0.5,500);

[d,f,t] = wvd(y,fs);

%% Fractional Fourier Transform
fft_y = fftshift(fft(y));
fr_y = frft2(y,1);
fr2_y = frft2(y,0.5);

[d2,f2,t2] = wvd(fr2_y,fs);