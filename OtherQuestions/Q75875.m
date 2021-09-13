fc = 20;  % Cut-off frequency
fs = 100;  % Sample frequency
order = 3;  % Filter order

[z, p, k] = butter(order, fc/(fs/2), 'low');
sos = zp2sos(z, p, k);
[h, w] = freqz(sos, 2000);
f = w*fs/(2*pi); % Convert to Hz

Hf2_matlab = abs(h).^2;
Hf2_theory = 1./(1+(f/fc).^(2*order));
plot(f, Hf2_matlab, 'k');
hold on;
plot(f, Hf2_theory)

plot([fc, fc], [0, 1], 'color', 0.5*[1, 1, 1])
plot([0, fs/2], [0.5, 0.5], 'color', 0.5*[1, 1, 1])
legend('Matlab', 'Theory')
xlabel('f (Hz)')
ylabel('|H(f)|^2')