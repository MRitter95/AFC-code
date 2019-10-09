%This function generates a colormap plot of the echoes. The intensity/
%brightness on the colormap indicates the relative efficiency of storage at
%that frequency. The code expects a configuration file containing the peak
%finding parameters (prominence and min distance) and the experimental
%parameters (start and stop frequency, sweeprate etc.). If no path is
%specified, the code will use the current directory to find all the files
%(currently the config file is one folder up)
function [echovals,timevals] = colormappingEcho(config, userpath)

%% User input

%Parameters for specific run
if(nargin<1)
    error('Please provide a configuration file with the experimental parameters')
end
if(nargin<2)
    userpath= pwd;
    disp(['No directory provided, using current directory: ' pwd])
end
cd(userpath)
configfile = config;
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
stepp=vals(4); %vertical spacing between consecutive traces
minpromp=vals(5); %minimum prominence of a peak
mindistp=vals(6); %minimum distance between peaks
startfreq=vals(7); %start frequency for comb
endfreq=vals(8); %end frequency for comb

%% Filenames

% Get file names for the afc and probe data and sort them correctly 
echofiles=dir('afc*.bin');
[~,idx]=sort_nat({echofiles.name});
echofiles=echofiles(idx);
probefiles=dir('probe*.bin');
[~,idx]=sort_nat({probefiles.name});
probefiles=probefiles(idx);
numfiles=length(echofiles);

%% Analysis

echovals=zeros(200,200); %array to hold all the echoes
timevals=zeros(numfiles);

%This for loop runs through all the files in the directory and produces
%combined combs as well as the fourier transform of the comb
for i=1:numfiles
    %get the fourier transformed data (first two variables) and the
    %combined comb data for plotting
    echo=readbin(echofiles(i).name(),'true');
    time=avgByNs(echo.x*1E6,100);
    amp=avgByNs(echo.y,100);
    
    probe=readbin(probefiles(i).name(),'true');
    timep=avgByNs(probe.x*1E6,100);
    ampp=avgByNs(probe.y,100);
    [peaksp,locsp]=findpeaks(ampp, timep, 'MinPeakProminence', minpromp, ...
        'MinPeakDistance', mindistp);
    
    time  = time-locsp(1);
    timep = timep-locsp(1);
    locsp = locsp-locsp(1);
    %Get the peaks and locations of peaks in the echo data for
    %visualization and later analysis
    [peaks,locs]=findpeaks(amp, time, 'MinPeakProminence', minprom, ...
        'MinPeakDistance', mindist);
    
    %Add all the peaks found to the echo array as well as the extracted
    %'storage' frequency (1/tstorage)
    if(~isempty(locs))
        count=0;
        for a=1:length(locs)
            %ignore peaks before 1/20 MHz because our resolution is bad
            if(locs(a)<0.07)
                count=count+1;
                continue;
            end
            xind=round(10./locs(a));%generates stored freq multiplied by 10
            if(xind>200)
                xind=200; %fixes out of range issues
            end
            echovals(xind,i)=peaks(a);
        end
        [~,im]=max(peaks(count:end));
        timevals(i)=locs(im);
    end

    %% Echo plotting with peaks and hyperbolae
    figure(111)
    hold on
    plot(timep, ampp+(i)*stepp, locsp, peaksp+(i)*stepp, 'x');
    oldvals=0:stepp*numfiles/40.:stepp*numfiles;
    newvals=linspace(0,20,length(oldvals));
    set(gca,'XLim', [0 10]);
    set(gca,'YTick', oldvals);
    set(gca,'YTickLabel', newvals);
    xlabel('Time (us)');
    ylabel('Modulation frequency (MHz)');
    
    figure(112)
    hold on
    plot(time, amp+(i)*step, locs, peaks+(i)*step, 'x');
    oldvals=0:step*numfiles/40.:step*numfiles;
    newvals=linspace(0,20,length(oldvals));
    set(gca,'XLim', [0 10]);
    set(gca,'YTick', oldvals);
    set(gca,'YTickLabel', newvals);
    xlabel('Time (us)');
    ylabel('Modulation frequency (MHz)');

    disp([num2str(i./10) ' MHz']);
end


%Produce the theoretical curves for where the peaks should be (1/f curves
%since we are essentially seeing an echo here)

fs=linspace(startfreq,endfreq,numfiles);
heights=step:step:step*numfiles;
for i=1:0.5:10
    plot(i./fs,heights,1./(i*fs),heights)
end

%Build color map of where the echoes occur in frequency space
%Look at cumulative stored power by summing over the array rows
echovals=echovals/max(echovals,[],'all');
figure
imagesc(echovals)
set(gca,'YDir','normal')
oldvals=0:20:200;
newvals=linspace(0,20,length(oldvals));
set(gca,'XTick', oldvals);
set(gca,'XTickLabel', newvals);
set(gca,'YTick', oldvals);
set(gca,'YTickLabel', newvals);
xlabel('Modulation frequency (MHz)');
ylabel('Storage frequency (MHz)');
title('Stored frequency vs programmed frequency')

figure
freq=startfreq:0.1:endfreq; %creates a frequency array spanning the modulating frequencies
time=1./freq;
for i=1:10
    plot(log(time),log(i*time),log(time),log(time/i))
end
plot(log(time),log(timevals),'x')
xlabel('Programmed storage time (log(us))');
ylabel('Storage time (log(us))');