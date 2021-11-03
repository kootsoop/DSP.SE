%% script
[a,b,c] = xlsread('q78810.csv');  % read CSV file
%% eliminate the empty cells
t1 = a(:,1); % time
t1(isnan(t1)) = [];
x1 = a(:,2); % insulin
x1(isnan(x1)) = [];
t2 = a(:,3);  % time
x2 = a(:,4);  % IRS

%% buid the impules response and filter the data
h = .72*exp(-log(2)/5.*t2)+.28*exp(-log(2)/2.8.*t2);
% filter with the first 40 taps, that seems plenty
y = filter(h(1:40),1,x2);


%% plot it
clf;
plot(t2,[x2 y]);
hold on
% scale factor: match the RMS
x1s = x1./rms(x1)*rms(y);
plot(t1,x1s);
grid on
xlabel('Time in minutes');
legend('ISR','Simulated','Actual');
h = get(gca,'Children'); set(h,'Linewidth',2);