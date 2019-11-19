%Get comb info from RSA file and compute fourier transform over limited
%range specified by the user

function [fourierf,fouriera,freq,amp]= RSAcombAnalysis(file, ...
    combspan)
wave      = readbin(file);
freqfull  = wave.x;
ampfull   = wave.y;
startcomb = findEl(freqfull,combspan(1));
endcomb   = findEl(freqfull,combspan(2));
freq      = freqfull(startcomb:endcomb);
amp       = ampfull(startcomb:endcomb);
amp       = amp-mean(amp);
df        = freq(2)-freq(1);
[fouriera, fourierf]  = periodogram(amp,[],[],1./df);