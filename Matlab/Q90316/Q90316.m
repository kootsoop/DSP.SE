sine = audioread("sine.mp3");
sine_noisy = audioread("sine_noisy.mp3");
10*log10(sum(abs(sine-sine_noisy).^2)/sum(abs(sine).^2))

error = sine-sine_noisy;

semilogy(abs(fft(error)))
hold on; 
%semilogy(abs(fft(sine)),'r')
%semilogy(abs(fft(sine_noisy)),'g')
hold off;

