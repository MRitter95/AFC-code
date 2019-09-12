%% User input

%Parameters for specific run
%TO DO: implement these in a simple config.txt file saved in the data
%folder

step=3; %vertical spacing between consecutive traces
minprom=0.5; %minimum prominence of a peak
mindist=0.1; %minimum distance between peaks
startfreq=0.1; %start frequency for comb
endfreq=20; %end frequency for comb
sweep1=[40 115]; %freq range of first sweep
sweep2=[70 160]; %freq range for second seep
sweepspeed=1200; %sweep speed in MHz/s

%% Filenames

% Get file names for the afc and probe data and sort them correctly 
afcfiles=dir('afc*.bin');
[~,idx]=sort_nat({afcfiles.name});
afcfiles=afcfiles(idx);
probefiles=dir('probe*.bin');
[~,idx]=sort_nat({probefiles.name});
probefiles=probefiles(idx);
numfiles=length(afcfiles);

%% Analysis

hold on

parray=[]; %array to hold the peak heights
larray=[]; %array to hold the peak locations
%This for loop runs through all the files in the directory and produces
%combined combs as well as the fourier transform of the comb
for i=1:numfiles
    %get the fourier transformed data (first two variables) and the
    %combined comb data for plotting
    figure(1)
    hold on
    [ffreq, famp, combinedf, combineda]=combAnalysisDouble( ...
        afcfiles(i).name, probefiles(i).name, sweep1, sweep2, sweepspeed);
    %Get the peaks and locations of peaks in the fourier transform data for
    %visualization and later analysis
    [peaks,locs]=findpeaks(famp, ffreq, 'MinPeakProminence', minprom, ...
        'MinPeakDistance', mindist);
    if(~isempty(locs))
        if(locs(1)<0.05)
            locs=locs(2:end);
            peaks=peaks(2:end);
        end
        if(isempty(locs))
            parray=cat(1,parray,0);
            larray=cat(1,larray,0);
        else
            parray=cat(1,parray,peaks(1));
            larray=cat(1,larray,locs(1));
        end
    else
        parray=cat(1,parray,0);
        larray=cat(1,larray,0);
    end
    plot(ffreq, famp+(i)*step, locs, peaks+(i)*step, 'x');
    xlim([0 10]);
    disp([num2str(i./10) ' MHz']);
end
%Produce the theoretical curves for where the peaks should be (1/f curves
%since we are essentially seeing an echo here
fs=linspace(startfreq,endfreq,numfiles);
heights=step:step:step*numfiles;
for i=1:0.5:10
    plot(i./fs,heights,1./(i*fs),heights)
end


%% Echo plots
figure(2)
time=1./fs;
hold on
for i=1:10
    plot(log(time),log(i*time),log(time),log(time/i))
end
plot(log(time),log(larray),'x') %plots the storage time vs programmed time as well as the expected y=x line
xlabel('Programmed storage time (us)');
ylabel('Storage time (us)');

figure(3)
%yyaxis right
plot(log(time),parray/max(parray)) %plots storage efficiency (relative) vs storage time
ylabel('Relative efficiency');
%print('-f2','FullEfficiency','-dpdf','-fillpage') %saves efficiency figure
