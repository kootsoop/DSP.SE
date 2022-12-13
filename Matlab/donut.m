R=5; % outer radius of torus
r=2; % inner tube radius
th=linspace(0,2*pi,36); % e.g. 36 partitions along perimeter of the tube 
phi=linspace(0,2*pi,18); % e.g. 18 partitions along azimuth of torus
% we convert our vectors phi and th to [n x n] matrices with meshgrid command:
[Phi,Th]=meshgrid(phi,th); 
% now we generate n x n matrices for x,y,z according to eqn of torus
x=(R+r.*cos(Th)).*cos(Phi);
y=(R+r.*cos(Th)).*sin(Phi);
z=r.*sin(Th);
surf(x,y,z); % plot surface
daspect([1 1 1]) % preserves the shape of torus
colormap('jet') % change color appearance 
title('Donut')
xlabel('X');ylabel('Y');zlabel('Z');