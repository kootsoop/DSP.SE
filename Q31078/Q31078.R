#Q31078

#a = [7000 for i in xrange(100000)]

a <- rep(700, 100000)

#fft_a = npf.fft(a)
fft_a <- fft(a)

#for idx in range(0,100000):
#  print(str(np.real(fft_a[idx])) + "," +  str(np.imag(fft_a[idx])))

plot(log(abs(fft_a) + 10^-30),  lwd=1)

points(log(abs(vals[,1]+10^-30)), col="red")

title('FFT of constant data: black R, red Python')