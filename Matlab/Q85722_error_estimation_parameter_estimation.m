% 85722/error-estimation-parameter-estimation

clear
close all
f=linspace(0,400,50);
B=0.001; % B= constant
err=rand(32,50); % random numbers between 0 and 1 
Im=B*2*pi*f+err; % Some sample
figure(1)% plot imaginary part over frequency to show standard deviation 
errorbar(f,mean(Im),std(Im)) 
xlabel('f in Hz')
ylabel('Imaginary part')

figure(2)% plot imaginary part over frequency to show standard deviation 
errorbar(f,mean(Im-mean(Im(:,1))),std(Im)) 
xlabel('f in Hz')
ylabel('Imaginary part')

% Estimate B
figure(3) 
errorbar(f,mean(Im)./(2*pi*f),std(Im)./(2*pi*f)) % 
xlabel('f in Hz')
ylabel('B')

figure(4) 
errorbar(f,mean(Im-mean(Im(:,1)))./(2*pi*f),std(Im)./(2*pi*f)) % 
hold on;
plot([0 400], [B B])
xlabel('f in Hz')
ylabel('B')

