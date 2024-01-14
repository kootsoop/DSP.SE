function x = levin(a,b)
% function x = levin(a,b)
% solves system of complex linear equations toeplitz(a)*x=b
% using Levinson's algorithm
% a ... first row of positive definite Hermitian Toeplitz matrix
% b ... right hand side vector
%
% Author: Mathias C. Lang, Vienna University of Technology, AUSTRIA
% 1997-09
% mattsdspblog@gmail.com

a = a(:); b = b(:); n = length(a);
t = 1; alpha = a(1); x = b(1)/a(1);
for i = 1:n-1,
   k = -(a(i+1:-1:2)'*t)/alpha;
   t = [t;0] + k*flipud([conj(t);0]);
   alpha = alpha*(1 - abs(k)^2);
   k = (b(i+1) - a(i+1:-1:2)'*x)/alpha;
   x = [x;0] + k*flipud(conj(t));
end