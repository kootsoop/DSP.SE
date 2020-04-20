import numpy as np
import numpy.fft as npf


a = [7000 for i in xrange(100000)]

fft_a = npf.fft(a)

for idx in range(0,100000):
	print(str(np.real(fft_a[idx])) + "," +  str(np.imag(fft_a[idx])))
