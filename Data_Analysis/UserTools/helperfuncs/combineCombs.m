function [freq, spec] = combineCombs(freqaxisp1,amp1, freqaxisp2, amp2)

start1=freqaxisp1(1);
start2=freqaxisp2(1);
finish1=freqaxisp1(end);
finish2=freqaxisp2(end);
over1=findEl(freqaxisp1,start2);
over2=findEl(freqaxisp2,finish1);
finallength=length(freqaxisp1)+length(freqaxisp2)-over2;
freq=linspace(start1,finish2,finallength);
spec1=amp1(1:over1-1);
spec3=amp2(over2+1:end);
spec2=amp1(over1:end)+amp2(1:over2);
spec=[spec1' spec2' spec3'];
