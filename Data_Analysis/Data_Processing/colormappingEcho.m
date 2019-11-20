%This function generates a colormap plot of the echoes. The intensity/
%brightness on the colormap indicates the relative efficiency of storage at
%that frequency. The code expects a configuration file containing the peak
%finding parameters (prominence and min distance) and the experimental
%parameters (start and stop frequency, sweeprate etc.). If no path is
%specified, the code will use the current directory to find all the files
%(currently the config file is one folder up)
%Input: config, file containing peakfinding parameters
%Input: userpath, path to .bin files
%Input: savefigs, boolean determining if figures are saved
%Output: none, saves figures in pdf/ .fig format if savefigs is true

function [echovals] = colormappingEcho(config, userpath, savefigs)

%% User input

%Parameters for specific run
if(nargin<1)
    disp(['Using the current directory: ' pwd ])
    pathOK       = input('Is that ok (Y/N)?','s');
    if(strcmp(pathOK,'Y') || strcmp(pathOK,'y'))
        userpath = pwd;
    else
        userpath = input('Please enter the desired directory','s');
    end
    config       = input('Path to config file','s');
    ufigs        = input('Savefigs? (Y/N)','s');
    if(strcmp(ufigs,'Y') || strcmp(ufigs,'y'))
        savefigs = true;
    else
        savefigs = false;
    end
end
disp(['Processing data from: ' userpath])
cd (userpath)

%%Configuration
fileID     = fopen(config);
if(fileID == -1)
    error('unable to open file');
end
config = textscan(fileID,'%s%f');
params    = config{1};
vals      = config{2};
step      = vals(1); %vertical spacing between consecutive traces
minprom   = vals(2); %minimum prominence of a peak
mindist   = vals(3); %minimum distance between peaks
stepp     = vals(4); %vertical spacing between consecutive traces
minpromp  = vals(5); %minimum prominence of a peak
mindistp  = vals(6); %minimum distance between peaks
startfreq = vals(7); %start frequency for comb
endfreq   = vals(8); %end frequency for comb

%% Filenames

% Get file names for the afc and probe data and sort them correctly 
echofiles  = dir('echo*.bin');
[~,idx]    = sort_nat({echofiles.name});
echofiles  = echofiles(idx);
probefiles = dir('probe*.bin');
[~,idx]    = sort_nat({probefiles.name});
probefiles = probefiles(idx);
numfiles   = length(echofiles);

%% Analysis

echovals = zeros(200,200); %array to hold all the echoes
timevals = zeros(1,numfiles);

%This for loop runs through all the files in the directory and finds
%all the peaks in the echo data
for i=1:numfiles
    echo  = readbin(echofiles(i).name(),'true');
    time  = avgByNs(echo.x*1E6,100);
    amp   = avgByNs(echo.y,100);
    
    probe = readbin(probefiles(i).name(),'true');
    timep = avgByNs(probe.x*1E6,100);
    ampp  = avgByNs(probe.y,100);
    %find peaks in probe data (sets the '0' point for storage time)
    [peaksp,locsp] = findpeaks(ampp, timep, 'MinPeakProminence', minpromp, ...
        'MinPeakDistance', mindistp);
    
    time     = time  - locsp(1);
    timep    = timep - locsp(1);
    locsp    = locsp - locsp(1);
    cutoff   = 0.07; %Use cutoff to reduce noise in data, storage pulse leaks out until 0.07us
    startind = findEl(timep,cutoff);
    %Get the peaks and locations of peaks in the echo data for
    %visualization and later analysis
    [peaks,locs] = findpeaks(amp(startind:end), time(startind:end), 'MinPeakProminence', ...
            minprom, 'MinPeakDistance', mindist);
    
    %Add all the peaks found to the echo array as well as the extracted
    %'storage' frequency (1/tstorage)
    if(~isempty(locs))
        for a=1:length(locs)
            %ignore peaks before ~1/20 MHz because our resolution is bad
            xind = round(10./locs(a));%generates stored freq multiplied by 10
            if(xind>200)
                xind = 200; %fixes out of range issues
            end
            echovals(xind,i) = peaks(a);
        end
        [~,im]      = max(peaks);
        timevals(i) = locs(im);
    end

    % Probe plot
    probes=figure(1);
    hold on
    plot(timep, ampp+(i)*stepp, locsp, peaksp+(i)*stepp, 'x');
    %Create y tick marks that show modulation frequency
    oldvals=0:stepp*numfiles/40.:stepp*numfiles;
    newvals=linspace(0,20,length(oldvals));
    set(gca,'XLim', [0 10]);
    set(gca,'YTick', oldvals);
    set(gca,'YTickLabel', newvals);
    xlabel('Time (us)');
    ylabel('Modulation frequency (MHz)');
    title({'Probe data';userpath},'Interpreter','none');
    
    %Echo plotting with peaks and hyperbolae
    echoes=figure(2);
    hold on
    plot(time, amp+(i)*step, locs, peaks+(i)*step, 'x');
    %Create y tick marks that show modulation frequency
    oldvals=0:step*numfiles/40.:step*numfiles;
    newvals=linspace(0,20,length(oldvals));
    set(gca,'XLim', [0 10]);
    set(gca,'YTick', oldvals);
    set(gca,'YTickLabel', newvals);
    xlabel('Time (us)');
    ylabel('Modulation frequency (MHz)');
    title({'Echo data';userpath},'Interpreter','none');
   
    % Update user on current frequency
    disp([num2str(i./10) ' MHz']);
end


%Produce the theoretical curves for where the peaks should be (1/f curves
%since we are essentially seeing an echo here)

fs      = linspace(startfreq,endfreq,numfiles);
heights = step:step:step*numfiles;
for i=1:0.5:10
    plot(i./fs,heights,1./(i*fs),heights)
end

%Build color map of where the echoes occur in frequency space
%Look at cumulative stored power by summing over the array rows
echovals = echovals/max(echovals,[],'all');
figure(3)
imagesc(echovals)
set(gca,'YDir','normal')
oldvals  = 0:step*numfiles/40.:step*numfiles;
newvals  = linspace(0,20,length(oldvals));
set(gca,'XTick', oldvals);
set(gca,'XTickLabel', newvals);
set(gca,'YTick', oldvals);
set(gca,'YTickLabel', newvals);
xlabel('Modulation frequency (MHz)');
ylabel('Storage frequency (MHz)');
title({'Stored frequency vs programmed frequency';userpath},'Interpreter','none');
set(gca,'TickDir','out');
pbaspect([1 1 1])

%Plot storage time against programmed time (expect straight line)
%Show additional harmonics of storage time to show only harmonics get stored
figure(4)
freq = startfreq:0.1:endfreq;
time = 1./freq;
hold on
for i=1:10
    plot(log(time),log(i*time),log(time),log(time/i))
end
plot(log(time),log(timevals),'x')
hline(log(cutoff),'r','Cutoff')
xlabel('Programmed storage time (log(us))');
ylabel('Storage time (log(us))');
title({'Stored time vs programmed time';userpath},'Interpreter','none');
set(gca,'TickDir','out');
pbaspect([1 1 1])

if(savefigs)
savefig(probes,'Probes','compact') %saves comb traces
savefig(echoes,'Echoes','compact') %saves FFT traces
print('-f3','Colormap', '-dpdf','-r500','-bestfit') % saves storage time info
print('-f4','Storage','-dpdf','-r500','-bestfit') %saves efficiency figure
end

end
