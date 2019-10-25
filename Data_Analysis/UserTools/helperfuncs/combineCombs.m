% This function combines two comb sweeps into a single comb for further
% analysis. The function expects arrays of frequency and amplitudes for
% each comb, finds the overlap region and concatenates the three regions
% together (comb1, comb1+comb2, comb2). 

function [freq, spec] = combineCombs(freqaxisp1,amp1, freqaxisp2, amp2, probe1, probe2)

% Get start/ end frequencies of each comb
start1=freqaxisp1(1);
start2=freqaxisp2(1);
finish1=freqaxisp1(end);
finish2=freqaxisp2(end);
%Find indices of start and end of overlap region
over1=findEl(freqaxisp1,start2);
over2=findEl(freqaxisp2,finish1);
%Create array of total length equaling the overlap region plus the
%remainder form each comb
finallength=length(freqaxisp1)+length(freqaxisp2)-over2;

prvals        = (probe1/max(probe1))>0.01;
amp1(prvals)  = amp1(prvals)./probe1(prvals);
prvals2       = (probe2/max(probe2))>0.01;
amp2(prvals2) = amp2(prvals2)./probe2(prvals2);

spec1=amp1(1:over1-1);
spec2=amp1(over1:end)+amp2(1:over2);
spec3=amp2(over2+1:end);
% Returns the full spectrum along with an extended frequency axis
spec=[spec1' spec2' spec3'];
spec=spec/max(spec);
freq=linspace(start1,finish2,finallength);
