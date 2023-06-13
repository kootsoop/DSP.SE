f = 0.1; %cosine frequency
A = 1*10^-3; %cosine amplitude

w = 2*pi*f;
fs = 1; %sample rate in Hz
N = 1000; %number of seconds
t = (-fs*N/2:1/fs:fs*N/2)-10^-6; %full time vector

%time domain signal
timeshift = 0; %set time shift to 250 as in original (unedited question)----------------------------
x = A*sin(w*(t-timeshift))./(w*(t-timeshift));
%Uncomment the next two lines if you apply a 250 s time shift.
%x = x(N/2+1:end);
%t = 0:1/fs:(fs*N/2); %truncated time vector

L = length(t); %length of time
df = fs/L; %frequency spacing
fAxis = (0:df:(fs-df)) - (fs-mod(L,2)*df)/2; %frequency vector

%FFT of time domain signal
%Xfft = (fft(x)/L);

nn = t;
mm = nn';
dftmtx = exp(-1j*2*pi*mm*nn/L);
Xfft = sum(x*dftmtx,1)

xifft = ifft(Xfft*L); %calculate ifft of spectrum 
% to try to recover the original sinc function

figure(3)
subplot(2,1,1)
plot(fAxis,(abs(Xfft)),'-k'); hold on
grid on
xlabel('Frequency (Hz)')
ylabel('Amplitude');

subplot(2,1,2)
plot(fAxis,(unwrap(angle(Xfft)))*180/pi,'k'); hold on
grid on
xlabel('Frequency (Hz)')
ylabel('Phase (degree)')


figure(4)
plot(t,x,'-k'); hold on
grid on
xlabel('Time (s)')
ylabel('Amplitude')