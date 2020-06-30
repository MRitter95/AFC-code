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

function [freq,timevals,markerSizes,echovals] = colormappingEcho(config, userpath, savefigs)

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
% step      = vals(1); %vertical spacing between consecutive traces
step= 3;
minprom   = vals(2); %minimum prominence of a peak
mindist   = vals(3); %minimum distance between peaks
stepp     = vals(4); %vertical spacing between consecutive traces
minpromp  = vals(5); %minimum prominence of a peak
mindistp  = vals(6); %minimum distance between peaks
startfreq = vals(7); %start frequency for comb
endfreq   = vals(8); %end frequency for comb

%% Filenames

% Get file names for the afc and probe data and sort them correctly
% (added the possibility that the echo files are named "afc"; I've changed
% combineFiles.m for the case of echo data, to compensate for jitter. The
% easiest way to run the old version of the program is to tell it that the
% data is afc, not echo, so it does the averaging without jitter
% compensation -- useful for comparing results with/without compensation.)
echofiles  = [dir('echo*.bin');dir('afc*.bin')];
[~,idx]    = sort_nat({echofiles.name});
echofiles  = echofiles(idx);
probefiles = dir('probe*.bin');
[~,idx]    = sort_nat({probefiles.name});
probefiles = probefiles(idx);
numfiles   = length(echofiles);

%% Analysis

echovals = zeros(200,200); %array to hold all the echoes
timevals = zeros(1,numfiles);
markerSizes= timevals;

%This for loop runs through all the files in the directory and finds
%all the peaks in the echo data
for i=1:numfiles
    echo  = readbin(echofiles(i).name(),'true');
    time  = avgByNs(echo.x*1E6,25);
    amp   = avgByNs(echo.y,25);
    
    probe = readbin(probefiles(i).name(),'true');
    timep = avgByNs(probe.x*1E6,25);
    ampp  = avgByNs(probe.y,25);
    %find peaks in probe data (sets the '0' point for storage time)
    [peaksp,locsp] = findpeaks(ampp, timep, 'MinPeakProminence', minpromp, ...
        'MinPeakDistance', mindistp);
    
    time     = time  - locsp(1)-0.018;
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
        for j=1:length(locs)
            %ignore peaks before ~1/20 MHz because our resolution is bad
            xind = round(10./locs(j));%generates stored freq multiplied by 10
            if(xind>200)
                xind = 200; %fixes out of range issues
            end
            echovals(xind,i) = peaks(j);
        end
        [markerSizes(i),im]      = max(peaks);
        timevals(i) = locs(im);
    end

%     Probe plot
    probeFig= figure(1);
    hold on
    plot(timep, ampp+(i)*stepp, locsp, peaksp+(i)*stepp, 'x');
%     Create y tick marks that show modulation frequency
    oldvals=0:stepp*numfiles/40.:stepp*numfiles;
    newvals=linspace(0,20,length(oldvals));
    set(gca,'XLim', [0 10]);
    set(gca,'YTick', oldvals);
    set(gca,'YTickLabel', newvals);
    xlabel('Time (us)');
    ylabel('Modulation frequency (MHz)');
    title({'Probe data';userpath},'Interpreter','none');
%     
%     Echo plotting with peaks and hyperbolae
    echoFig= figure(2);
    hold on
    plot(time, amp+(i)*step, locs, peaks+(i)*step, 'x');
%     Create y tick marks that show modulation frequency
    oldvals=0:step*numfiles/40.:step*numfiles;
    newvals=linspace(0,20,length(oldvals));
    set(gca,'XLim', [0 10]);
    set(gca,'YTick', oldvals);
    set(gca,'YTickLabel', newvals);
    xlabel('Time (us)');
    ylabel('Modulation frequency (MHz)');
    title({'Echo data';userpath},'Interpreter','none');
   
%     Update user on current frequency
    disp([num2str(i./10) ' MHz']);
end


% %Produce the theoretical curves for where the peaks should be (1/f curves
% %since we are essentially seeing an echo here)
% 
% fs      = linspace(startfreq,endfreq,numfiles);
% heights = step:step:step*numfiles;
% for i=1:0.5:10
%     plot(i./fs,heights,1./(i*fs),heights)
% end

%Build color map of where the echoes occur in frequency space
%Look at cumulative stored power by summing over the array rows
echovals = echovals/max(echovals,[],'all');
figure(3)
imshow(echovals)
set(gca,'YDir','normal')
% oldvals  = 0:step*numfiles/40.:step*numfiles;
% newvals  = linspace(0,20,length(oldvals));
axis on
xticks(linspace(50,200,4));
xticklabels(linspace(5,20,4));
% set(gca,'XTick',linspace(50,200,4) );
% set(gca,'XTickLabel',linspace(5,20,4) );
% set(gca,'YTick', oldvals);
% set(gca,'YTickLabel', newvals);
yticks(linspace(50,200,4));
yticklabels(linspace(5,20,4));
xlabel('Modulation frequency (MHz)');
ylabel('Storage frequency (MHz)');
title({'Stored frequency vs programmed frequency';userpath},'Interpreter','none');
set(gca,'TickDir','out');
pbaspect([1 1 1])

figure(4)
imshow(1-echovals)
set(gca,'YDir','normal')
axis on
xticks(linspace(50,200,4));
xticklabels(linspace(5,20,4));
yticks(linspace(50,200,4));
yticklabels(linspace(5,20,4));
% oldvals  = 0:step*numfiles/40.:step*numfiles;
% newvals  = linspace(0,20,length(oldvals));
% set(gca,'XTick', oldvals);
% set(gca,'XTickLabel', newvals);
% set(gca,'YTick', oldvals);
% set(gca,'YTickLabel', newvals);
xlabel('Modulation frequency (MHz)');
ylabel('Storage frequency (MHz)');
title({'Stored frequency vs programmed frequency';userpath},'Interpreter','none');
set(gca,'TickDir','out');
pbaspect([1 1 1])

%Plot storage time against programmed time (expect straight line)
%Show additional harmonics of storage time to show only harmonics get stored
figure(5)
set(gca,'XScale','log','YScale','log');
xlim([0.05,2]);
ylim([0.05,2]);
hold on
freq = startfreq:0.1:endfreq;
time = 1./freq;

for i=1:10
    loglog(time,i*time,...
        time,time/i,'Color',0.1*(i-1)*[1,1,1],'LineWidth',2/i);
    
%     plot(log(time),log(i*time),':b',...
%         log(time),log(time/i),':b','LineWidth',4/i);
end
markerSizes= 0.001+300*markerSizes/max(markerSizes);
scatter(time,timevals,markerSizes,'MarkerEdgeColor',...
    [0,0.4470,0.7410],'LineWidth',1.5);
hold off
% plot(log(time),log(timevals),'*k')

%the plot view coincides with the cutoff, so no need to include line.
%hline(cutoff,'r')
xlabel('Inverse spacing of optical comb teeth (\mus)');
ylabel('Emission time of largest echo (\mus)');
title({'Measured storage time';userpath},'Interpreter','none');
set(gca,'TickDir','out');
pbaspect([1 1 1])

figure(6)
hold on
for i=1:10
    plot(freq,i*time,...
        freq,time/i,'Color',0.1*(i-1)*[1,1,1],'LineWidth',2/i);
end
markerSizes= 0.001+300*markerSizes/max(markerSizes);
scatter(freq,timevals,markerSizes,'MarkerEdgeColor',...
    [0,0.4470,0.7410],'LineWidth',1.5);
hold off
ylim([0,2.1]);
xlabel('Optical comb tooth spacing (MHz)');
ylabel('Emission time of largest echo (\mus)');
title({'Measured storage time';userpath},'Interpreter','none');
set(gca,'TickDir','out');

if(savefigs)
% savefig(probeFig,'Probes','compact') %saves comb traces
% savefig(echoFig,'Echoes','compact') %saves FFT traces
print('-f3','echo_white', '-dpdf','-r500','-bestfit') % saves storage time info
print('-f4','echo_black', '-dpdf','-r500','-bestfit') % saves storage time info
print('-f5','echo_loglog','-dpdf','-r500','-bestfit') %saves efficiency figure
print('-f6','echo_hyperbola','-dpdf','-r500','-bestfit') %saves efficiency figure
end

end
