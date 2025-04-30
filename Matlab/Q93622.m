% https://dsp.stackexchange.com/questions/93622/how-can-i-calculate-how-much-of-my-signal-at-the-beginning-and-end-will-be-affec

[b,a]=butter(2,[.15,.3]);

figure(1);
freqz(b,a);

figure(2);
impulse_response = filter(b,a,[1,zeros(1,100)]);
impulse_response = impulse_response/(max(abs(impulse_response)))

plot(20*log10(abs(impulse_response)))
xlabel('Time Index')
ylabel('Magnitude in dB')
