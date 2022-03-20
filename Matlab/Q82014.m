fs=50

%creating the filter 
[A1,B1,C1,D1] = ellip(6,0.1,50,[0.1  2.95 ]/25);
[A2,B2,C2,D2] = ellip(6,0.2,50,[ 3   7 ]/25);
[A3,B3,C3,D3] = ellip(8,0.05,50,[ 7  13 ]/25);
[A4,B4,C4,D4] = ellip(10,0.1,50,[ 13 24 ]/25);

%getting second order coefficients of size Nx6, where N is order of the filter
s1 = ss2sos(A1,B1,C1,D1);
s2 = ss2sos(A2,B2,C2,D2);
s3 = ss2sos(A3,B3,C3,D3);
s4 = ss2sos(A4,B4,C4,D4);

%create cascaded biquad filter from the coefficients
biquad_0_3   = dfilt.df1sos(s1)
biquad_3_7   = dfilt.df1sos(s2)
biquad_7_13  = dfilt.df1sos(s3)
biquad_13_25 = dfilt.df1sos(s4)

%CHECK STABILITY
stable1 = isstable(s1);
stable2 = isstable(s2);
stable3 = isstable(s3);
stable4 = isstable(s4);

zplane(ss2zp(A1,B1,C1,D1))
zplane(ss2zp(A2,B2,C2,D2))
zplane(ss2zp(A3,B3,C3,D3))
zplane(ss2zp(A4,B4,C4,D4))

%plots magnitude response and group delay
  fvtool(biquad_0_3,biquad_3_7,biquad_7_13,biquad_13_25); 
  grpdelay(biquad_0_3)
  grpdelay(biquad_3_7)
  grpdelay(biquad_7_13)
  grpdelay(biquad_13_25) 