clear all;
clc;

B=20e3;
fs=100e3;
T=10e-3;

%% LFM
t=(0:T*fs-1)*(1/fs);
true_phi = 2*pi*(-(B/2)*t+(B/(2*T))*t.^2);
lfm=exp(1i*true_phi);

%% Instantaneous frequency
[f]=instfreq(lfm)*fs;
f=[f f(end)]; %adding an element to have the same length as t

%% Signal reconstruction
est_phi=cumtrapz(t,f);
sig=exp(1i*est_phi);

plot(true_phi,'.');
hold on;
plot(est_phi,'r');
hold off;


