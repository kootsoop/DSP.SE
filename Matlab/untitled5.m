H=(16e6)/(((j*85)+1800)*((j*85)+4800));
Vi=12*exp(j*85*(pi/180));
Vo=H*Vi;
[abs(Vo)  angle(Vo)/pi*180]