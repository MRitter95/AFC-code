%trying fft trick on real comb data

function [freq, amp]= combAnalysis(afcfile, probefile)

afc=ReadLeCroyBinaryWaveform(afcfile);
probe=ReadLeCroyBinaryWaveform(probefile);
time=afc.x;
amps=afc.y;
ptime=probe.x;
pamp=probe.y;

f1=40;
f2=115;
f1b=70;
f2b=160;
frontoffset=2e-3;
backoffset=3e-3;
deltaT=time(2)-time(1);

tones=findTones2(probe);
p1start    = tones(2)+round(frontoffset/deltaT);
p1end      = tones(3)-round(backoffset/deltaT);
p2start    = tones(4)+round(frontoffset/deltaT);
p2end      = tones(5)-round(backoffset/deltaT);
pulse1     = [ptime(p1start),ptime(p1end)];
pulse2     = [ptime(p2start),ptime(p2end)];
freqaxisp1 = 600*2*(ptime(p1start:p1end)-pulse1(1))+2*f1;
freqaxisp2 = 600*2*(ptime(p2start:p2end)-pulse2(1))+2*f1b;

amp1=amps(p1start:p1end);
amp2=amps(p2start:p2end);
[freqT,ampT]=combineCombs(freqaxisp1,amp1,freqaxisp2,amp2);

df=freqT(2)-freqT(1);
[amp, freq]=periodogram(ampT,[],[],1./df);