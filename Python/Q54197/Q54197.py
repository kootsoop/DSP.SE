#!/opt/local/bin/python2.7
from scipy.signal import firwin
import numpy as np
import matplotlib.pyplot as plt


N = 100
data = firwin(N, [0.05, 0.95], width=0.05, pass_zero=False)
n_data = np.multiply(data, np.arange(len(data)))
rate = 1

B = np.fft.fft(data)
Br = np.fft.fft(n_data)
group_delay2 = np.divide(Br, B + 0.01).real

plt.figure(1)
plt.subplot(311)
plt.plot(data)
plt.subplot(312)
plt.plot(np.abs(B))
plt.subplot(313)
plt.plot(group_delay2)

plt.show()
