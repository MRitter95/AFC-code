% Estimating power in RF comb after AOM bandwidth truncation. This code
% integrates the RF power in the RSA traces weighting the different
% frequencies by the bandwidth of the AOM

function [modfreqs, power, powerint] = RFpoweranalysis(userdir, threshold, useAOM)
startdir=pwd;
cd(userdir)
files=dir('*.bin'); % Get all data files names, expects only rfc data
[~,idx]=sort_nat({files.name}); %sort files correctly 
files=files(idx);

bandwidthdat=[0.1375, 0.101875, 0.2215625, 0.42, 0.659375, 0.85, ...
    0.95625, 0.99375, 1, 0.978125, 0.921875, 0.846875, 0.721875, ...
    0.571875, 0.4125, 0.258125, 0.1284375, 0.045625, 0.0121875, ...
    0.002875, 0.0011875]; %measured bandwidth from comb AOM

freqsmeas=linspace(60, 160, length(bandwidthdat));
%fit data to a pair of gaussians
bw=fit(freqsmeas', bandwidthdat', 'gauss2'); 

power=zeros(1,length(files));
powerint=zeros(1,length(files));
wave=readbin(files(1).name);
startf=findEl(wave.x, 20); %sets BW of analysis
endf=findEl(wave.x, 180); 
amp=zeros(1, length(wave.y(startf:endf)));

for i=1:length(files)
    wave=readbin(files(i).name);
    trunc=wave.y(startf: endf); %only care about signal in our BW
    thresh=trunc>threshold; %remove signal that is below threshold
    
    amp(thresh)=10.^((trunc(thresh)-threshold)/10); %turn signal back to amplitude

    if(strcmp(useAOM,'true'))
        amp=amp.*bw(wave.x(startf: endf))'; %weight amplitudes by bandwidth
    end
    power(i)=sum(amp); % 'integrate' power
    powerint(i)=trapz(wave.x(startf:endf), amp);
end

power=power/max(power);
powerint=powerint/max(powerint);
modfreqs=linspace(0.1, 20, 200);

cd (startdir);