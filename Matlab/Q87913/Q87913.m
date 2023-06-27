load signals_samples.mat
clf

for k=1:10

    figure(k)
    clf
    subplot(211)
    plot(signals_samples{k})
    hold on
    plot(medfilt1(signals_samples{k},100),'r')
    subplot(212)
    plot(medfilt1(signals_samples{k},100))

end
