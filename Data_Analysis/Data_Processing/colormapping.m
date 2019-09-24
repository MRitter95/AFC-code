%% User input

%Parameters for specific run
%TO DO: implement these in a simple config.txt file saved in the data
%folder
configfile = 'E:\data_2019_09_18\2019-08-18config.txt';
fileID     = fopen(configfile);
if(fileID == -1)
    error('unable to open file');
end
config = textscan(fileID,'%s%f');
params = config{1};
vals   = config{2};
step=vals(1); %vertical spacing between consecutive traces
minprom=vals(2); %minimum prominence of a peak
mindist=vals(3); %minimum distance between peaks
startfreq=vals(4); %start frequency for comb
endfreq=vals(5); %end frequency for comb
sweep1=[vals(6) vals(7)]; %freq range of first sweep
sweep2=[vals(8) vals(9)]; %freq range for second seep
sweepspeed=vals(10); %sweep speed in MHz/s

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

echovals=zeros(200,200);
parrayp=[]; %array to hold the peak heights
larrayp=[]; %array to hold the peak locations
%This for loop runs through all the files in the directory and produces
%combined combs as well as the fourier transform of the comb
for i=1:numfiles
    %get the fourier transformed data (first two variables) and the
    %combined comb data for plotting
    [ffreq, famp, combinedf, combineda]=combAnalysisDouble( ...
        afcfiles(i).name, probefiles(i).name, sweep1, sweep2, sweepspeed);
    %Get the peaks and locations of peaks in the fourier transform data for
    %visualization and later analysis
    [peaks,locs]=findpeaks(famp, ffreq, 'MinPeakProminence', minprom, ...
        'MinPeakDistance', mindist);
    if(~isempty(locs))
        for a=1:length(locs)
            yind=round(10./locs(a));
            if(yind>200)
                yind=200;
            end
            echovals(i,yind)=peaks(a);
        end
    end
    %{
    figure(1)
    hold on
    combinedf=avgByNs(combinedf',100);
    combineda=avgByNs(combineda',100);
    plot(combinedf, combineda+(i)*step);
    oldvals=0:15:600;
    newvals=linspace(0,20,length(oldvals));
    set(gca,'YTick', oldvals);
    set(gca,'YTickLabel', newvals);
    xlabel('Frequency (MHz)');
    ylabel('Modulation frequency (MHz)');
    if(~isempty(locs))
        if(locs(1)<0.05)
            locs  = locs(2:end);
            peaks = peaks(2:end);
        end
        if(isempty(locs))
            parrayp = cat(1,parrayp,0);
            larrayp = cat(1,larrayp,0);
        else
            [m,im] = max(peaks);
            parrayp = cat(1,parrayp,m);
            larrayp = cat(1,larrayp,locs(im));
        end
    else
        parrayp=cat(1,parrayp,0);
        larrayp=cat(1,larrayp,0);
    end
    figure(2)
    hold on
    plot(ffreq, famp+(i)*step, locs, peaks+(i)*step, 'x');
    xlim([0 10]);
    disp([num2str(i./10) ' MHz']);
    oldvals=0:15:600;
    newvals=linspace(0,20,length(oldvals));
    set(gca,'YTick', oldvals);
    set(gca,'YTickLabel', newvals);
    xlabel('Time (us)');
    ylabel('Modulation frequency (MHz)');
    %}
end
%Produce the theoretical curves for where the peaks should be (1/f curves
%since we are essentially seeing an echo here)

%{
fs=linspace(startfreq,endfreq,numfiles);
heights=step:step:step*numfiles;
for i=1:0.5:10
    plot(i./fs,heights,1./(i*fs),heights)
end
%}