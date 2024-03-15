import numpy as np

N = 100
sum = 0
m = 50
phi = np.random.rand()*2*np.pi
for n in range(N):
    sum = sum + np.cos(4*np.pi*m/N*n+phi)

print(sum)
