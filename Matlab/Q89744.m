% FIR filter design using LS method with arbitrary amp. & phase resp.
% (nonlinear phase)
clc;close all;clear all

%% setups & measurement results
fs = 16e9;
fn = 31/4096*fs:125e6:2047/4096*fs;
f_norm = 2*pi*fn/fs;
fn_intp = linspace(f_norm(1),f_norm(end),512);
amp0 = [0.6100 0.6082 0.5949 0.6309 0.6582 0.6482 0.6775];
phs0 = [0.0465 0.0465 0.2740 0.8148 1.0403 1.8896 2.5158];
f_meas = [f_norm(1) f_norm(14) f_norm(20) f_norm(35) f_norm(45) f_norm(55) f_norm(end)];

% interpolation to have dense data
amp = interp1(f_meas,amp0,fn_intp,'spline');
phs = interp1(f_meas,phs0,fn_intp,'spline');
figure;plot(fn_intp,amp);figure;plot(fn_intp,phs);
% Matt's suggestion
tap_num = 31;
del = 15;
phs = phs - fn_intp * del;
%% Test with Matt. L.'s alg.
D = amp.*exp(1j*phs);% desired response
W = [ones(1,32) ones(1,448) ones(1,32)];% weighted 
% tap_num = 11;
h = lslevin(tap_num,fn_intp,D,W); % please download the lslevin function
figure;stem(h,'linewidth',2);grid on;xlabel('Index');ylabel('Amp.')

% plot to check
[A,F] = freqz(h,1,512);
figure;plot(fn_intp,amp);grid on
hold on;plot(F,abs(A));xlabel('Norm freq. (rad./sample)');ylabel('Amp.')
legend('Original','LS results')
figure;plot(fn_intp,phs);grid on
hold on;plot(F,angle(A));xlabel('Norm freq. (rad./sample)');ylabel('rad.')
legend('Original','LS results')