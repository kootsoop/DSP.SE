% function [y] = Q81782(fd,x)

x = [1 ones(1,1023)]';
fd = 1/3;

%design fractional delay filter
[h,i0,bw] = designFracDelayFIR(fd);
fdf = dsp.FIRFilter(h);

y = fdf(x);

subplot(2,1,1);
stem(x(1:256));
title('Input Sequence');
xlabel('n')
subplot(2,1,2)
stem(y(1:256));
title('FIR Output Sequence');
xlabel('n')

% end