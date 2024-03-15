clear;
close all;

% system variables
mu = 0.1;
kappa = (2*pi)^2; % natural frequency of 1Hz

% integration variables
fs = 5; % sampling rate
tend = 1e4; % simulation length
ICs = [0;0]; % initial conditions
tSim = 0:(1/fs):tend; % integration points

% noise
fsn = 10; % noise sampling rate
tnoise = 0:(1/fsn):tend; % noise calculation points
sigma = 1e-2; % unscaled sigma
sigmaScale = sqrt(2*fsn*sigma); % scale sigma by noise sampling rate
rng(0,'v5normal'); % initialize random number generator for reproduceability
noiseMat = randn(length(tnoise),1); % calculate noise matrix
Fnoise = griddedInterpolant(tnoise,noiseMat,'cubic'); % calculate interpolation constants


% simulate system   
[T,X] = ode45(@(t,x) dfe(t,x,mu,kappa)+sigmaScale*Fnoise(t)*[0;1],tSim,ICs);

%% plot

% number of windows
N_wind = round(logspace(0,3.5,8));

figure;
% colororder(abyss(length(N_wind))); % set color order
for i = 1:length(N_wind)
    % calculate psd estimate
    [Ynorm,f] = pwelch(X(:,1),hanning(round(length(X(:,1))/N_wind(i))),0,[],fs);
    plot(f,pow2db(Ynorm),'LineWidth',2)
    hold on
end

xlabel('Frequency [Hz]')
ylabel('Amplitude')
set(gcf,'theme','light')
set(gcf,'color','white')



function dx = dfe(t,x,mu,kappa) %#ok<INUSD>

dx = [0 1;-kappa -mu]*x;

end