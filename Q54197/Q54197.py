#!/opt/local/bin/python2.7
import numpy as np
import matplotlib.pyplot as plt
from scipy.io import wavfile


def group_delay(sig):
    b = np.fft.fft(sig)
    n_sig = np.multiply(sig, np.arange(len(sig)))
    br = np.fft.fft(n_sig)
    return np.divide(br, b + 0.01).real


rate, data = wavfile.read('bachfugue.wav')

N_w = 1024
L = np.floor(len(data)/N_w).astype(int)

full_delay = np.zeros((L, N_w))
for index in range(L):
    window = data[index:(index+N_w), 1].astype(float)
    full_delay[index][:] = group_delay(window)

plt.imshow(full_delay[0::10, 0::10], cmap=plt.get_cmap('hot'), aspect='auto')
plt.show()
