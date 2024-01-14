% Q90151

syms s K Ti

Gp = (s+2)/((s+1)*(s+3));
Gr = K*(1 + 1/(Ti*s));

G = Gp*Gr/(1+Gp*Gr);

[num, den] = numden(G);
sympref('PolynomialDisplayStyle','ascend');
num
den

