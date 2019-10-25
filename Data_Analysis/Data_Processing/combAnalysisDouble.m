%Get tones from probe to produce 'real' frequency axis, combine the low and
%high frequency combs and finally take the fourier transform of the result

function [freq, amp, freqT, ampT]= ...
    combAnalysisDouble(afcfile, probefile, sweep1, sweep2, sweepspeed)

%% Data input

%Check filetype and use correct reading function
[~,~,ext] = fileparts(afcfile);
disp(['Analyzing ' ext ' data'])
if(strcmp(ext,'.bin'))
    afc=readbin(afcfile,'true');
    probe=readbin(probefile,'true');
else
    afc=ReadLeCroyBinaryWaveform(afcfile);
    probe=ReadLeCroyBinaryWaveform(probefile);
end

%% Initialization

time=afc.x;
amps=afc.y;
ptime=probe.x;
pamp=probe.y;

f1=sweep1(1);
f2=sweep1(2);
f1b=sweep2(1);
f2b=sweep2(2);
frontoffset=2e-3; %time between falling edge of pulse and start of sweep
backoffset=3e-3; %time between end of pulse and falling edge of pulse
deltaT=time(2)-time(1);

%% Creating frequency axes and combining combs

tones      = findTones2(probe); %get falling edges from probe data

%get indices for start and edge of each probe sweep
p1start    = tones(2)+round(frontoffset/deltaT);
p1end      = tones(3)-round(backoffset/deltaT);
p2start    = tones(4)+round(frontoffset/deltaT);
p2end      = tones(5)-round(backoffset/deltaT);

amp1       = amps(p1start:p1end); %low freq sweep
amp2       = amps(p2start:p2end); %high freq sweep
probe1     = probe.y(p1start:p1end);
probe2     = probe.y(p2start:p2end);
probe1     = probe1/max([probe1' probe2']);
probe2     = probe2/max([probe1' probe2']);
pulse1     = [ptime(p1start),ptime(p1end)];
pulse2     = [ptime(p2start),ptime(p2end)];

%Creating frequency axes, the factor originates from double passing the AOM
freqaxisp1 = sweepspeed*2*(ptime(p1start:p1end)-pulse1(1))+2*f1;
freqaxisp2 = sweepspeed*2*(ptime(p2start:p2end)-pulse2(1))+2*f1b;

%Combine the high/ low frequency combs into a single comb (just adding them
%together at the moment
[freqT,ampT] = combineCombs(freqaxisp1,amp1,freqaxisp2,amp2, probe1, probe2);
%ampT         = ampT/max(ampT);
ampT         = ampT-mean(ampT);
df           = freqT(2)-freqT(1);
[amp, freq]  = periodogram(ampT,[],[],1./df);