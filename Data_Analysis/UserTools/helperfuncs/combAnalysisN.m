%Normalizes single probe sweep to extract AFC.
%Takes Fourier transform of the result.
%Returns AFC; FFT of AFC; probe sweeps (just for debugging).

%Input: afcfile, file name for afc data
%Input: probefile, file name for probe data
%Input: sweep1, range of first probe sweep ([start stop] format)
%Input: sweep2, range of second probe sweep ([start stop] format)
%Input: sweepspeed, sweeprate of probe in MHz/s
%Output: freq/ amp are the fourier transformed frequency and amplitude of the combs
%Output: freqT/ ampT contains the data for the combined comb, normalized to max value
%Output: probe(1-2)/freqaxisp(1-2) contains the probe information for plotting

function [freq, amp, f, comb, sweep]= ...
    combAnalysisN(afcfile, probefile, fMin, sweepSpeed)

%% Data input

%Check filetype and use correct reading function
[~,~,ext] = fileparts(afcfile);
disp(['Analyzing ' ext ' data'])

%we read off the AFC and probe traces. the x fields for both traces are
%identical arrays of times (so they're interchangeable). the y fields are
%arrays of voltage readings.
if(strcmp(ext,'.bin'))
    afc   = readbin(afcfile,'true');
    probe = readbin(probefile,'true');
else
    afc   = ReadLeCroyBinaryWaveform(afcfile);
    probe = ReadLeCroyBinaryWaveform(probefile);
end

%% Initialization

% fMin          = sweep(1); %Start frequency of first sweep

%time between cal. tone falling edge and start of sweep
frontoffset = 2e-4;
%time between end of sweep and first cal. tone falling edge
backoffset  = 2.1e-4;

disp(['Assuming ',num2str(frontoffset),...
    ' seconds between calibration tones and sweep.']);
disp(['Assuming ',num2str(backoffset-frontoffset),...
    '-second long calibration tones.']);

%time step between readings
dt      = afc.x(2)-afc.x(1);

%% Creating frequency axes and combining combs

tones      = findTones2(probe); %get falling edges from probe data

%get first and last indices of probe sweep; identify corresponding times
pStart    = tones(2)+round(frontoffset/dt);
pEnd      = tones(3)-round(backoffset/dt);

%subset of the traces actually corresponding to the sweep
comb      = afc.y(pStart:pEnd)-mean(afc.y(1:tones(1)));
sweep     = probe.y(pStart:pEnd)-mean(probe.y(1:tones(1)));
sweep     = sweep/max(sweep);       %normalize
sweep     = sweep-min(sweep)+0.01;  %stay positive

%map time to instantaneous frequency; factor of 2 from AOM double pass
f = sweepSpeed*2*(afc.x(pStart:pEnd)-afc.x(pStart))+2*fMin;

% average data: makes final results cleaner but cuts down on FFT range
comb= avgByNs(comb,25);
sweep= avgByNs(sweep,25);
f= avgByNs(f,25);
% we have to be careful with this averaging. if it's done right away, we're
% really taking the geometric mean of the AFC data. is that what we want?
% maybe, since we're averaging out high-frequency noise unrelated to the
% actual signal, so I guess that's not logarithmic...

%our amplifier's V vs. log(I) has slope 0.1.
comb= comb-0.1*log(sweep);
df           = f(2)-f(1);
[amp, freq]  = periodogram(exp(comb/0.2),[],[],1./df);

%return comb in dB
comb= 100*log10(exp(1))*comb;

end
