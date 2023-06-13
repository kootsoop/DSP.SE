A = [1 0 0 6; 
    1/(1j*10) (-1/(1j*10) + 1/(1j*100)) -1/(1j*100) 4*exp(1j*45/180*pi)
    0 -1/(1j*100) (1/(1j*100) + 1/100) 0];


RREF_MATRIX = rref(A);
Vnodes = RREF_MATRIX(:,4);

[abs(Vnodes(2)) angle(Vnodes(2))/pi*180]
[abs(Vnodes(3)) angle(Vnodes(3))/pi*180]

