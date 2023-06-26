N = 10; %number of discrete frequencies to digitize the continuous spectrum
a = 1.2566; %constant
b = 0.00078956; %constant

w = 10.^linspace(0,-4,N); %get logarithmically spaced frequencies omega

%The spectrum
G = a./sqrt(b*w);


M = 100; %length of time series
fs = 1; %assuming a 1 Hz sample rate

t = linspace(0,fs*M,M)';

%the time series is computed as a "dumb" Fourier transform which assumes
%that each discrete frequency is a delta spike respresenting a time-domain
%sinusoid. Just sum it all together:
g = sum(G.*exp(1i*2*pi*w.*t),2); 


%Now perform fft on the time series you just made
pad = 10000;
xt = cat(1,ones(pad,1).*g(1),g,ones(pad,1).*g(end)); %add some padding cells to the time series
X = fft(xt); 

%Calculate frequency bins
df = fs/length(xt);
fAxis = (0:df:(fs-df)) - (fs-mod(M,2)*df)/2;

w_flip = flip(w);
G_flip = flip(G);
h_firls = firls(length(g),w_flip, G_flip);
H_firls = fft(h_firls, length(xt));

%Plotting
clf
subplot(2,1,1) %Plot spectrum
loglog(w,G,'*r'); hold on; grid on
loglog(fAxis,abs(X),'-k'); 
loglog(fAxis,abs(H_firls),'g'); 
xlabel('Frequency (Hz)');
ylabel('G(\omega)')
set(gca,'FontSize',14)
title('Spectrum G(\omega)')
legend('"True" Spectrum','FFT of Time Series')

subplot(2,1,2); %Plot time series
plot(t/3600,real(g)); 
hold on;
plot(t/3600, h_firls,'g')
xlabel('Time (hours)')
ylabel('g(t)'); grid on
set(gca,'FontSize',14)
title('Inverse "Fourier Transform" of Spectrum')