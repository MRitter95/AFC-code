clear all
carrier=100;
fmdev=50;
teeth=3.2;

[freqs, amps]=RFcomb(carrier,fmdev,teeth,'tri','true');
df=freqs(2)-freqs(1);
ffreqs=0:df:2*freqs(end);
finalamps=zeros(1,length(ffreqs));
for i=1:length(freqs)
    finalamps(i:length(amps)+i-1)=finalamps(i:length(amps)+i-1)+amps*amps(i);
    if(mod(i,100)==0)
        disp(i)
    end
end
[freqs1, amps1]=RFcomb(carrier,fmdev,teeth,'sin','true');
df=freqs(2)-freqs(1);
finalamps1=zeros(1,length(ffreqs));
for i=1:length(freqs)
    finalamps1(i:length(amps)+i-1)=finalamps1(i:length(amps)+i-1)+amps1*amps1(i);
    if(mod(i,100)==0)
        disp(i)
    end
end

plot(ffreqs, 10*log10(finalamps),freqs,10*log10(amps), ffreqs, 10*log10(finalamps1), freqs, 10*log10(amps1))
xlim([0 400])
ylim([-100 0])
