function [est] = qnf(signal)
% QNF -	The Quinn - Fernandes frequency estimator.
%
%          Inputs:  signal - T x N matrix where
%                            T = data length
%                            N = number of signals
%                            (i.e. N signals in columns).
%
%          Outputs: est - N Quinn-Fernandes frequency estimates.
%
% [1]  B.G. Quinn & J.M. Fernandes, "A fast technique for the estimation of frequency,"
%      Biometrika, Vol. 78(3), pp. 489--497, 1991.

% $Id: qnf.m 1.1 2000/06/07 18:57:16 PeterK Exp PeterK $

% File: qnf.m
%
% Copyright (C) 1993 CRC for Robust & Adaptive Systems
% 
% This software provided under the GNU General Public Licence, which
% is available from the website from which this file originated. For
% a copy, write to the Free Software Foundation, Inc., 675 Mass Ave, 
% Cambridge, MA 02139, USA.

%
% Initializations
%
[t,ns]=size(signal);
xb=mean(signal);
signal=signal-ones(t,1)*xb;
t3 = t+1;
vrsn = version;
if vrsn(1)=='3'
  y=fft([signal; zeros(signal)]);
else
  y=fft([signal; zeros(size(signal))]);
end

z=y.*conj(y);
z=z(2:t3,:);

[m,j]=max(z(2:t-1,:));

j=j+1;

a=2*cos(pi*j/t);
y=y(1:2:2*t,:);

%
% Quinn-Fernandes method
%
b=[1];
nm=t-1;
for jjj=1:2

  for q = 1:ns
    c=[1;-a(q);1];
    y(:,q) = filter(b,c,signal(:,q));
  end

  v = sum(signal(2:t,:).*y(1:nm,:))./sum((y(1:nm,:).*y(1:nm,:)));
  a = a+2*v;
end

est=acos(a/2);

% Author: SJS 1992; Adapted from code within ttinpie.m (author PJK)
%
% Based on: P.J. Kootsookos, S.J. Searle and B.G. Quinn, 
% "Frequency Estimation Algorithms," CRC for Robust and 
% Adaptive Systems Internal Report, June 1993.

%