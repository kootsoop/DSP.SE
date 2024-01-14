% 91516

syms s R1 L1 C1 C2 R2 L2


H =@(s, R1, L1, C1, C2, R2, L2) R1 + s*L1 + 1/(1/(1/s(C1+C2)) + 1/(s*L2) + 1/R2);

