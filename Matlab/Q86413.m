N = 8388608/2;

filter = 0.01*ones(1,N);

filter([1:N]/44100*100 < 100) = 2.1;
filter([1:N]/44100*100 > 8000) = 2.1;

full_filter = [filter, flip(filter(2:N))];


plot(abs(ifft(full_filter, N*4)))