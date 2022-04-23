clc; clear;

%% Calculate filter coefficients

fs = 1200e3;     %Sampling frequency [Hz]
fc = 30e3;      %Butterworth filter cuttoff frequency [Hz]
n = 4;          %Butterworth filter order

%Get low-pass butterworth filter zeroes and poles
[z, p, g] = butter(n, 2 * fc / fs, 'low');

%Convert zeroes and poles into SOS coefficients
sos_matrix = zp2sos(z, p, g, 'down', 'two');

nCascadedFilterSections = length(sos_matrix(:,1));

%Get double-precision filter coefficients according to my difference equation
%Note: The a coefficients must be multiplied by -1 because matlab uses a
%different difference equation than the CMSIS-Standard
b0_double =  sos_matrix(:, 1);
b1_double =  sos_matrix(:, 2);
b2_double =  sos_matrix(:, 3);
a1_double = -sos_matrix(:, 5);
a2_double = -sos_matrix(:, 6);


%Calculate the required post shift bit to scale all coefficients to my
%fixed-point range [-1 1)
maxValInSos = max(abs(sos_matrix(abs(sos_matrix) > 1)));

if (isempty(maxValInSos))
    postShift = 0;
else
    postShift = ceil(-log2(1 / maxValInSos));
end


%Get 1.15 signed [-1,1) format fixed-point coefficients by truncating the
%scaled double-precision values. Assign previously defined math properties to each
%variable
b0_fixed = fi(b0_double * 2^-postShift, true, 16, 15, fimath('RoundingMethod', 'Nearest'));
b1_fixed = fi(b1_double * 2^-postShift, true, 16, 15, fimath('RoundingMethod', 'Nearest'));
b2_fixed = fi(b2_double * 2^-postShift, true, 16, 15, fimath('RoundingMethod', 'Nearest'));
a1_fixed = fi(a1_double * 2^-postShift, true, 16, 15, fimath('RoundingMethod', 'Nearest'));
a2_fixed = fi(a2_double * 2^-postShift, true, 16, 15, fimath('RoundingMethod', 'Nearest'));

%% Calculate transfer function

%Anonymous Filter Transfer-Function
H = @(z, b0, b1, b2, a1, a2) ((b0 .* z.^2 + b1 .* z + b2) ./ (z.^2 - a1 .* z - a2));

f = 0 : 1 : fs / 2 - 1; %Frequency vector [Hz]
z = exp(1i * 2 * pi * f ./ fs); %Calculate frequency-corresponding z vector

%Calculate double-precision filter gain [-] and phase [°]
mag_double = 1;
ph_double = 0;

for (section = 1 : nCascadedFilterSections)
    mag_double = mag_double .* abs(H(z, ...
        b0_double(section), ...
        b1_double(section), ...
        b2_double(section), ...
        a1_double(section), ...
        a2_double(section)));
    
    ph_double = ph_double + rad2deg(unwrap(angle(H(z, ...
        b0_double(section), ...
        b1_double(section), ...
        b2_double(section), ...
        a1_double(section), ...
        a2_double(section)))));
end

%Calculate fixed-point filter gain [] and phase [°]
%Cast fixed-point variable type back to double (the coefficient value stays
%the same!)
%Multiply variables by postShift value (see CMSIS Documentation)
mag_fixed = 1;
ph_fixed = 0;

for (section = 1 : nCascadedFilterSections)
    mag_fixed = mag_fixed .* abs(H(z, ...
        double(b0_fixed(section)) * 2^postShift, ...
        double(b1_fixed(section)) * 2^postShift, ...
        double(b2_fixed(section)) * 2^postShift, ...
        double(a1_fixed(section)) * 2^postShift, ...
        double(a2_fixed(section)) * 2^postShift));
    
    ph_fixed = ph_fixed + rad2deg(unwrap(angle(H(z, ...
        double(b0_fixed(section)) * 2^postShift, ...
        double(b1_fixed(section)) * 2^postShift, ...
        double(b2_fixed(section)) * 2^postShift, ...
        double(a1_fixed(section)) * 2^postShift, ...
        double(a2_fixed(section)) * 2^postShift))));
end

%Plot
figure(1)
clf(1)
s2 = subplot(2,1,1);
hold on
plot(f * 1e-3, mag_double)
plot(f * 1e-3, mag_fixed)
xlabel('f [kHz]')
ylabel('Gain [-]')
legend('double', 'fixed')
s1 = subplot(2,1,2);
hold on
plot(f * 1e-3, ph_double)
plot(f * 1e-3, ph_fixed)
xlabel('f [kHz]')
ylabel('Phase [°]')
legend('double', 'fixed')
sgtitle('Bode Plot')

linkaxes([s1, s2], "x");
%% Calculate the step response
t = 0: 1 / fs : 1e-3; %Discrete Time vector [s]

stepHight = 0.5; %Height of the step input [-]
step = [zeros(1,20), stepHight * ones(1,length(t) - 20)]; %Step signal

%Define fixed-point math rules according to my arithmetic precisions
%ARM CMSIS-DSP Library:
%https://www.keil.com/pack/doc/CMSIS/DSP/html/group__BiquadCascadeDF1.html#ga4e7dad0ee6949005909fd4fcf1249b79
%Filter function:
%arm_biquad_cascade_df1_fast_q15()
fixedPointFilterProperties = fimath('CastBeforeSum', true, ...
    'OverflowAction', 'Wrap', ...
    'RoundingMethod', 'Floor', ...
    'ProductWordLength', 32, ...
    'ProductFractionLength', 30, ...
    'ProductMode', 'SpecifyPrecision', ...
    'SumWordLength', 32, ...
    'SumFractionLength', 30, ...
    'SumMode', 'SpecifyPrecision');

%Set fixed point filter properties to coefficients for correct arithmetics
%according to CMSIS
b0_fixed = setfimath(b0_fixed, fixedPointFilterProperties);
b1_fixed = setfimath(b1_fixed, fixedPointFilterProperties);
b2_fixed = setfimath(b2_fixed, fixedPointFilterProperties);
a1_fixed = setfimath(a1_fixed, fixedPointFilterProperties);
a2_fixed = setfimath(a2_fixed, fixedPointFilterProperties);

%Set step signal as input
in = fi(step, true, 16, 15, fixedPointFilterProperties);

%Define fixed-point filter output vector
out = fi(zeros(1, length(in)), true, 16, 15, fixedPointFilterProperties);

%Filter as it would be done by the CMSIS Library function
for (section = 1 : nCascadedFilterSections)
    for (i = 1 : length(in))
        if (i == 1)
            b0_prod = in(i)    * b0_fixed(section);
            b1_prod = 0        * b1_fixed(section);
            b2_prod = 0        * b2_fixed(section);
            a1_prod = 0        * a1_fixed(section);
            a2_prod = 0        * a2_fixed(section);
        elseif (i == 2)
            b0_prod = in(i)    * b0_fixed(section);
            b1_prod = in(i-1)  * b1_fixed(section);
            b2_prod = 0        * b2_fixed(section);
            a1_prod = out(i-1) * a1_fixed(section);
            a2_prod = 0        * a2_fixed(section);
        else
            b0_prod = in(i)    * b0_fixed(section);
            b1_prod = in(i-1)  * b1_fixed(section);
            b2_prod = in(i-2)  * b2_fixed(section);
            a1_prod = out(i-1) * a1_fixed(section);
            a2_prod = out(i-2) * a2_fixed(section);
        end
        accum = b0_prod + b1_prod + b2_prod + a1_prod + a2_prod;
        
        accum = accum * 2^postShift;
        
        out(i) = fi(accum, true, 16, 15, fimath('OverflowAction', 'Saturate', 'RoundingMethod', 'Floor'));
    end
    in = out;
end

%Plot step response
figure(2)
clf(2)
hold on
plot(t,fi(step, true, 16, 15, fixedPointFilterProperties))
plot(t, double(out))
xlabel('t [s]')
ylabel('Response')
legend('original', 'fp filter out')
title('Step response')

%Display DC-Gain of Bode-Plot and Step-Response settling value
DC_Gain_FP_Tf = mag_fixed(1)
DC_Gain_FP_Step = double(out(end)) / stepHight

%% Further search using matlab filter object

%% Generate fixed-point Filter (SOS) with matlab toolbox
fp_object = dfilt.df1sos(sos_matrix);


%General settings
fp_object.Arithmetic = 'fixed';
fp_object.PersistentMemory = false;
fp_object.OptimizeScaleValues = false;
fp_object.RoundMode = 'floor';

%Specify input/output
fp_object.InputWordLength = 16;
fp_object.InputFracLength = 15;
fp_object.OutputMode = 'SpecifyPrecision';
fp_object.OutputWordLength = 16;
fp_object.OutputFracLength = 15;

%Specify coefficient format
fp_object.CoeffWordLength = 16;
fp_object.CoeffAutoScale = false;
fp_object.NumFracLength = 15 - postShift;
fp_object.DenFracLength = 15 - postShift;
fp_object.ScaleValueFracLength = 13;


%Specify Accumulator
fp_object.AccumMode = 'SpecifyPrecision';
fp_object.OverflowMode = 'saturate';
fp_object.AccumWordLength = 32;
fp_object.NumAccumFracLength = 30;
fp_object.DenAccumFracLength = 30;

%Specify Multiplicator
fp_object.ProductMode = 'SpecifyPrecision';
fp_object.ProductWordLength = 32;
fp_object.DenProdFracLength = 30;
fp_object.NumProdFracLength = 30;

%Bode plot
[h, ~] = freqz(fp_object, f, fs);

mag_fixed2 = abs(h);
ph_fixed2 = rad2deg(unwrap(angle(h)));

figure(3)
clf(3)
s1 = subplot(2,1,1);
plot(f * 1e-3, mag_fixed2)
xlabel('f [kHz]')
ylabel('Gain [-]')
legend('fixed obj. and freqz()')
s2 = subplot(2,1,2);
plot(f * 1e-3, mag_fixed2)
xlabel('f [kHz]')
ylabel('Phase [°]')
legend('fixed obj. and freqz()')
sgtitle('Bode Plot')

%Step response
[out1, t1] = stepz(fp_object);
stepHight = 0.5;
out1 = out1 * stepHight;
step = stepHight * ones(1, length(t1));
out2 = fp_object.filter(step);

out2 = double(out2);
t1 = t1 * 1 / fs;

figure(4)
clf(4)
hold on
plot(t1, out1)
plot(t1, out2)
xlabel('t [s]')
ylabel('Response')
legend('fixed obj. stepz()', 'fixed obj.filter()')
title('Step response')

DC_Gain_FP2_Tf = mag_fixed2(1)
DC_Gain_FP2_Step_Stepz = out1(end) / stepHight
DC_Gain_FP2_Step_filter = out2(end) / stepHight