T = 1024;
X = randn(T,1);
X2(1:2:2*T) = X;
h=firls(30,[0 .1 .2 .5]*2,[1 1 0 0]);
X2f = filter(h,1,X2);
