fs = 48000;
B = [0.6 0 ; 1 0.3 ; 1 -1; 1 -1 ; 1 -1; 1 -1]; % b(1,1) ajustado para 0.6
A = [1 -0.2025 ; 1 -0.2025 ; 1 -0.9860 ; 1 -0.9097 ; 1 -0.9973 ; 1 -0.9973];

x=[0 0];
y=[0 0];

t = linspace(0,1,fs);

yy = zeros(1,fs);


for c= 1:fs
x(1) = sin(2*pi*10000*t(c));


y(1) = (1/A(3,1))*(B(3,2)*x(1) + B(3,1)*x(2) + A(3,1)*y(2) ); 

yy(c) = y(1);
  % update x and y data vectors
  for i = 2:-1:1
    x(i+1) = x(i); % store xi
    y(i+1) = y(i); % store yi
  end


 
end

figure(1)
plot(t,yy)