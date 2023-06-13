function [magnitude, phase] = add_polar_numbers(A,B,C,D)
%

magnitude = sqrt((A*cos(B) + C*cos(D))^2 + (A*sin(B) + C*sin(D))^2);
phase = atan2(A*sin(B) + C*sin(D), A*cos(B) + C*cos(D));

