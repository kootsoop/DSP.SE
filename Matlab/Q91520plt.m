%% Plot
figure('units','normalized','outerposition',[0 0 1 1]);
plot(SNR,10*log10(SIGMAp),SNR,-3+10*log10(sqrt(CRLBp)),'--');
grid on; grid minor;
xlabel('SNR (dB)');
ylabel('Standard deviation (dBrad)');
title('Phase Est.');
legend('SD. Phase', 'CRLB Phase');