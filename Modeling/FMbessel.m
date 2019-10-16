%Generates fm spectrum assuming single tone modulation
%Takes in a carrier frequency, fm deviation (amplitude of frequency
%variation) and a modulation frequency (teeth)
%Returns spectrum (linear scale, not log scale)

function [freq, amp] = FMbessel(carrier,fmdev,teeth)
numteeth=2*round(carrier/teeth); %number of frequency components to evaluate
amp=zeros(1,numteeth+1); %array of amplitudes of fourier components
freq=zeros(1,numteeth+1); %frequency array
beta=fmdev/teeth; %modulation depth
for k=-numteeth/2:numteeth/2
    amp(k+numteeth/2+1)=abs(besselj(k,beta));
    freq(k+numteeth/2+1)=carrier+k*teeth;
end

amp=amp.^2;
