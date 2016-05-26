import numpy.fft

a = [7000 for i in xrange(100000)]

fft_a = numpy.fft.fft(a)

print(fft_a)
