clc;
clear;
close all;
%% generate the input signal
fsDataIn = 1e6;
fs_clk = 32e6;
freqInput_6db = 74.463e3;               % frequency of input signal -6db
freqInput_3db = 53.405e3;              % frequency of input signal -3db
deltaT = 1/fsDataIn;                  % time interval between two samples
amplitude = 2000;
Length = 100;
t = 0:deltaT:Length; 
sine_dataIn_6db=amplitude*sin(2*pi*freqInput_6db*t);
sine_dataIn_6db = sine_dataIn_6db(1:10000)';
sine_dataIn_3db=amplitude*sin(2*pi*freqInput_3db*t);
sine_dataIn_3db = sine_dataIn_3db(1:10000)';

%% cic parameters
R = 5;  % decimator factor
M = 1;  % differential delay
N = 3;  % number of stage
CICDecim = dsp.CICDecimator(R, M, N);
[dataOut_6db] = CICDecim(sine_dataIn_6db);
[dataOut_3db] = CICDecim(sine_dataIn_3db);
cic_out = fvtool(CICDecim);

figure('name','cic');
subplot(2,1,1);
plot(sine_dataIn_6db');
xlabel('t');
ylabel('input sinewave');
title('input sinewave in time domain');

subplot(2,1,2);
plot(dataOut_6db);
xlabel('sample');
ylabel('ideal cic output data');
title('ideal cic output in freq domain');
rms_3db = rms(dataOut_3db)
rms_6db = rms(dataOut_6db)
amplitude_3db = (max(dataOut_3db)-min(dataOut_3db))/2
amplitude_6db = (max(dataOut_6db)-min(dataOut_6db))/2