%% Init
clear all;close all;clc;

f1 = 500e3;%signal frequency
phi = 58.25*pi/180;%signal phase
T = 1e-3;%signal duration

fs = 4e6;%sampling frequency
t = 0:1/fs:T-1/fs;%time vector
nfft = 2*2^nextpow2(fs*T);%fft points
f = 0:fs/nfft:fs/2-fs/nfft;%frequency vector
Samples = round(fs*T);%number of samples
NumSigs = 200;%number of signals
Win = hanning(Samples);%window function
WinMat = repmat(Win, 1, NumSigs);%window matrix for fft
DataTime = zeros(Samples,NumSigs);%time samples of signals

sigmaN = 0.02;%rms noise amplitude
A = logspace(-2,0,15);%signal amplitudes
nAmps = length(A);%number of signal amplitudes

for a = 1:nAmps%for all signal amplitudes
    %% Signal generation
    for i = 1:NumSigs
        DataTime(:,i) = A(a)*cos(2*pi*f1.*t + phi) + sigmaN*randn(Samples,1)';%generate signals   
    end

    %% FFT
    DataTimeWin = WinMat.*DataTime;%apply window
    DataSpec = (1/sum(Win))*fft(DataTimeWin, nfft, 1);%fft
    DataPow = (2*abs(DataSpec)/sqrt(2)).^2  / (50*1e-3);%power in mW, 50 Ohm system
    DataPhase = atan2(imag(DataSpec),real(DataSpec));%phase

%     figure('units','normalized','outerposition',[0 0 1 1]);%plot
%     subplot(2,1,1)
%     plot(10*log10(DataPow(1:nfft/2,:)));%plot all signals
%     grid on; grid minor; 
%     subplot(2,1,2)
%     plot(DataPhase(1:nfft/2,:));%plot phase values
%     grid on; grid minor;  

    %% Signal Peak Search
    for j = 1:NumSigs
        [~, locs(j)] = findpeaks(DataPow(:,j),'SortStr', 'descend', 'NPeaks', 1);%find signal peak
        PeakPhase(j) = DataPhase(locs(j),j);%get phase value
    end

    %% CRLB frequency
    SNR(a) = 10*log10( (A(a)/sqrt(2))^2 ) - 10*log10( (sigmaN^2) );%calculate SNR

    SIGMAp(a) = std(PeakPhase-phi);%standard deviation of phase

    CRLBp(a) = (2*(2*Samples-1))/(10^(SNR(a)/10)*Samples*(Samples+1));%CRLB for phase

end

%% Plot
figure('units','normalized','outerposition',[0 0 1 1]);
plot(SNR,10*log10(SIGMAp),SNR,10*log10(sqrt(CRLBp)),'--');
grid on; grid minor;
xlabel('SNR (dB)');
ylabel('Standard deviation (dBrad)');
title('Phase Est.');
legend('SD. Phase', 'CRLB Phase');