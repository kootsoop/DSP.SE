% 82918/music-algorithm-for-direction-of-arrival-in-acoustic-signals

f = 100;
fs = 10000;
T = 1024;
t = [0:T-1];

phi = pi*0.505;

if (~exist('n1','var'))
    n1 = randn(1,T)/100;
end
if (~exist('n2','var'))
    n2 = randn(1,T)/100;
end

s1 = sin(2*pi*f/fs*t);
s2 = sin(2*pi*f/fs*t + phi);

x1 = s1 + n1;
x2 = s2 + n2;


xc = [x1;x2]*[x1;x2]';

[v,d] = eig(xc);
[v2,d2] = eig(xc - d(1,1)*eye(2));

null_eigen_vector = v2(:,1);

directions = linspace(-pi,pi,20);
music = zeros(1,length(directions));
idx = 1;

for look_dirn = directions
    arrival_vector = [1 exp(1j*look_dirn)];
    music(idx) = conj(arrival_vector)*null_eigen_vector*null_eigen_vector'*arrival_vector';
    idx = idx + 1;
end

plot(directions, 1./abs(music));



