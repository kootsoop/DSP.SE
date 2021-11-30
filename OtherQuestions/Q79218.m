fs = 48000;     % [Hz] desired sampling rate of device
fmin = 20;      % [Hz] minimal desired low-end
fmax = 20480;   % [Hz] minimal desired high-end

oct_bw_ratio = 1/3; % [1] desired octave-split

n_octs = log2(fmax/fmin);               % [1] number of octaves from fmin to fmax
n_bands = ceil(n_octs/oct_bw_ratio);    % [1] number of octave divisions from fmin to fmax

fc = fmin*2.^((0:n_bands) * oct_bw_ratio);  % [Hz] center frequencies. 
                                            % "(0:n_bands)" means to iterate from 0 to n_bands 
                                            % and store result in vector
fl = fc*2^(-oct_bw_ratio/2);                % lower cutoffs @ -3dB (required by filter-designer)
fu = fc*2^(+oct_bw_ratio/2);                % upper cutoffs @ -3dB (required by filter-designer)

% test filter with uppermost band
filter = gen_iir_osix_bp(fl(31), fu(31), fs);
display(filter.sosMatrix);

[b,a] = sos2tf(filter.sosMatrix);
freqz(b,a)
