%Combines an arbitrary number of probe sweeps into a single comb.
%Takes Fourier transform of the result.
%Returns composite comb; FFT of comb; probe sweeps (just for debugging).

%Input: afcfile, file name for afc data
%Input: probefile, file name for probe data
%Input: sweep1, range of first probe sweep ([start stop] format)
%Input: sweep2, range of second probe sweep ([start stop] format)
%Input: sweepspeed, sweep rate of probe in MHz/s
%Output: freq&amp are the fourier transformed frequency and amplitude of the combs
%Output: freqT&ampT contain the data for the combined comb, normalized to max value
%Output: probe(1-2)/freqaxisp(1-2) contains the probe information for plotting

function [freq, amp, freqT, ampT, probe1, freqaxisp1]= ...
    combAnalysisN(afcfile, probefile, sweep, sweepspeed)

%% Data input

%Check filetype and use correct reading function
[~,~,ext] = fileparts(afcfile);
disp(['Analyzing ' ext ' data'])
if(strcmp(ext,'.bin'))
    afc   = readbin(afcfile,'true');
    probe = readbin(probefile,'true');
else
    afc   = ReadLeCroyBinaryWaveform(afcfile);
    probe = ReadLeCroyBinaryWaveform(probefile);
end

%% Initialization

time  = afc.x;
amps  = afc.y;
ptime = probe.x;
pamp  = probe.y;

f1          = sweep(1); %Start frequency of first sweep
% f1b         = sweep2(1); %Start frequency of second sweep

%time between cal. tone falling edge and start of sweep
frontoffset = 2e-4;
%time between end of sweep and cal. tone rising edge
backoffset  = 2.1e-4;
disp(['Assuming ',num2str(frontoffset),...
    ' seconds between calibration tones and sweep.']);
disp(['Assuming ',num2str(backoffset-frontoffset),...
    '-second long calibration tones.']);

deltaT      = time(2)-time(1);

%% Creating frequency axes and combining combs

tones      = findTones2(probe); %get falling edges from probe data

%get indices for start and edge of each probe sweep
p1start    = tones(2)+round(frontoffset/deltaT);
p1end      = tones(3)-round(backoffset/deltaT);
% p2start    = tones(4)+round(frontoffset/deltaT);
% p2end      = tones(5)-round(backoffset/deltaT);

amp1       = amps(p1start:p1end)-mean(amps(1:tones(1))); %low freq sweep
% amp2       = amps(p2start:p2end)-mean(amps(1:tones(1))); %high freq sweep
pulse1     = [ptime(p1start),ptime(p1end)];
% pulse2     = [ptime(p2start),ptime(p2end)];

probe1     = pamp(p1start:p1end)-mean(pamp(1:tones(1)));
% probe2     = pamp(p2start:p2end)-mean(pamp(1:tones(1)));
% normval    = max([max(probe1) max(probe2)]);
normval= max(probe1);

probe1     = probe1/normval;
% probe2     = probe2/normval;

%Optional averaging of data, makes final results cleaner but cuts down on FFT range
amp1       = avgByNs(amp1,50);
% amp2       = avgByNs(amp2,50);
probe1     = avgByNs(probe1,50);
% probe2     = avgByNs(probe2,50);

%Creating frequency axes, the factor originates from double passing the AOM
freqaxisp1 = sweepspeed*2*(ptime(p1start:p1end)-pulse1(1))+2*f1;
% freqaxisp2 = sweepspeed*2*(ptime(p2start:p2end)-pulse2(1))+2*f1b;

freqaxisp1 = avgByNs(freqaxisp1,50);
% freqaxisp2 = avgByNs(freqaxisp2,50);

%Combine the high/ low frequency combs into a single comb (just adding them
%together at the moment
% [freqT,ampT] = combineCombs(freqaxisp1,amp1,freqaxisp2,amp2, probe1, probe2);
ampT = (amp1)./(probe1-min(probe1)+0.01);
freqT= freqaxisp1;
df           = freqaxisp1(2)-freqaxisp1(1);
[amp, freq]  = periodogram(amp,[],[],1./df);
end
