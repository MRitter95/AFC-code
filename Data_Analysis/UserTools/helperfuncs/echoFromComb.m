function [t,echo,echoVal,timeVal,markerSize]= echoFromComb(f,comb)
% simply combines various analysis steps already written out in other
% programs, so that we can call it in various other situations, such as for
% finding expected echo signal when the AFC is identical to the OFC.

% f is the frequency axis in MHz;
% comb is the power spectrum in dB;
% t is the time axis in us;
% echo is the emission power vs. t;
% echoVal is emission power vs. inverse time (for the intensity map);
% timeVal is the time of the main echo (for the hyperbola plot);
% markerSize is the magnitude of the main echo (for the hyperbola plot).

linCombAmp= 10.^(comb/20);
df= f(2)-f(1);

[echo,t]  = periodogram(linCombAmp,[],[],1./df);
% note that periodogram returns power spectrum of a signal; so we have to
% input the signal amplitude (hence the extra factor of 2 in linCombAmp
% definition), but we don't have to square the output to get the power
% spectrum.

cutoff       = 0.05;
minprom      = 2e-10;
mindist      = 0.045;
startind     = findEl(t,cutoff);
[peaks,locs] = findpeaks(echo(startind:end), t(startind:end),...
    'MinPeakProminence',minprom, 'MinPeakDistance', mindist);

% magnitude of echo signal vs. inverse time: one column of intensity map.
echoVal= zeros(1,200);

% time and magnitude of largest echo: gives one point of hyperbola plot.
timeVal= 0;
markerSize= 0;

if(~isempty(locs))
    for j=1:length(locs)
        if(locs(j)>10.)
            continue;
        end
        
        %echoFreq is inverse time of echo. it is the pixel index for the
        %intensity map; previous IF ignores echo signal
        %at inverse time smaller than 0.1MHz.
        echoFreq = round(10./locs(j));
        
        if(echoFreq > 200)
            echoFreq = 200; %fixes out of range issues
        end
        echoVal(echoFreq) = peaks(j);
    end
    [markerSize,im]      = max(peaks);
    timeVal = locs(im);
end


end

