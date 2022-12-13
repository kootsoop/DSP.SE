% https://dsp.stackexchange.com/questions/85043/loop-bandwidth-for-costas-loop

alpha = 0.132
beta = 0.00932

b = alpha;
a = [1 -1];

freqz(b,a, 512, 44100)