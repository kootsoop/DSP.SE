f = 1; %cosine frequency
A = 20; %cosine amplitude

w = 2*pi*f;
fs = 16; %sample rate in Hz
N = 2; %number of seconds
t = 0:1/fs:(fs*N)-1; %time vector

L = length(t); %length of time
df = fs/L; %frequency spacing
fAxis = (0:df:(fs-df)) - (fs-mod(L,2)*df)/2; %frequency vector


%time domain signal
x = A*cos(w*t);

%FFT of time domain signal
Xfft = fft(x)/L;

%DFT of time domain signal
% n=(-floor(L/2):1:floor(L/2))';
n = 1:L;
k=n';
Xdft = (1/L)*sum(x.*exp(-1i*2*pi*(n-1).*(k-1)/L),2);

figure(1)
clf
plot(fAxis,angle(Xfft)*180/pi,'-k','LineWidth',20); hold on
plot(fAxis,angle(Xdft)*180/pi,'r+');; hold on
grid on;
xlabel('Frequency (Hz)');
ylabel('Phase Angle (deg)')
legend('DFT','FFT')
set(gca,'FontSize',14)

figure(2)
clf
plot(abs(Xfft));
hold on;
plot(abs(Xdft),'r+')
