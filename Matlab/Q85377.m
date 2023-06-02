clear all
clc
close all

noOfSensors = 8;
f = 8e3;
distanceBetweenSensors = 15/1000;
velocityWave = 340;
angles=-2*pi*f(1)*[0:noOfSensors-1]*distanceBetweenSensors/velocityWave;
diR=cos(angles)+1j*sin(angles);
delaySumWeights=diR/noOfSensors;
theta = -pi:pi/50:pi;
scanningMatrix = zeros(noOfSensors,length(theta));
for I=1:length(theta)
    scanningMatrix(:,I) = exp(-j*2*f*pi*[0:noOfSensors-1]'*distanceBetweenSensors*cos(theta(I))/velocityWave);
end

ampli = (((rand+1j*rand)));
ampli = ampli/abs(ampli);
phaseOfSource = ampli*eye(length(theta));

receivedSignal = scanningMatrix*phaseOfSource;

yValuesTestHat=testVer(receivedSignal);

[cc,rr]=size(receivedSignal);

for k=1:rr
    delaySum(k)=conj(delaySumWeights)*(receivedSignal(:,k));
end
figure
hold on
plot(theta,(abs(yValuesTestHat.*delaySum)))

plot(theta,(abs(delaySum)))
grid on
legend('New','delaySum')
title('Comparison')
