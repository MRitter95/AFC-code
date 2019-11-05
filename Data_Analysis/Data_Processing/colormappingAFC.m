%This function generates a colormap plot of the echoes. The intensity/
%brightness on the colormap indicates the relative efficiency of storage at
%that frequency. The code expects a configuration file containing the peak
%finding parameters (prominence and min distance) and the experimental
%parameters (start and stop frequency, sweeprate etc.). If no path is
%specified, the code will use the current directory to find all the files
%(currently the config file is one folder up)
function [echovals] = colormappingAFC(config, userpath)

%% User input

%Parameters for specific run
if(nargin<1)
    disp(['Using the current directory: ' pwd ])
    pathOK=input('Is that ok (Y/N)?','s');
    if(strcmp(pathOK,'Y')||strcmp(pathOK,'y'))
        userpath=pwd;
    else
        userpath=input('Please enter the desired directory','s');
    end
    config=input('Path to config file','s');
end
disp(['Processing data from: ' userpath])
cd (userpath)

fileID     = fopen(config);
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

echovals=zeros(200,200); %array to hold all the echoes
timevals=zeros(1,numfiles);
savefigs=true;

%This for loop runs through all the files in the directory and produces
%combined combs as well as the fourier transform of the comb
for i=1:numfiles
    %get the fourier transformed data (first two variables) and the
    %combined comb data for plotting
    [ffreq, famp, combinedf, combineda]=combAnalysisDouble( ...
        afcfiles(i).name, probefiles(i).name, sweep1, sweep2, sweepspeed);
    %Get the peaks and locations of peaks in the fourier transform data for
    %visualization and later analysis
    %ignore peaks before 1/20 MHz because our resolution is bad
    cutoff=0.05;
    startind=findEl(ffreq,cutoff);
    [peaks,locs]=findpeaks(famp(startind:end), ffreq(startind:end),...
        'MinPeakProminence',minprom, 'MinPeakDistance', mindist);
    %Add all the peaks found to the echo array as well as the extracted
    %'storage' frequency (1/tstorage)
    max(ffreq)
    if(~isempty(locs))
        for a=1:length(locs)
            xind=round(10./locs(a));%generates stored freq multiplied by 10
            if(xind>200)
                xind=200; %fixes out of range issues
            end
            echovals(xind,i)=peaks(a);
        end
        [~,im]=max(peaks);
        timevals(i)=locs(im);
    end
    
    %Plotting the combined combs
    figure(1)
    hold on
    combinedf=avgByNs(combinedf',100); %reduce the amount of data
    combineda=avgByNs(combineda',100); %makes plots look smoother
    plot(combinedf, combineda+(i)*step);
    xlabel('Frequency (MHz)');
    ylabel('Modulation frequency (MHz)');
    title({'Comb data';userpath},'Interpreter','none');
    %create y-tick marks that show modulation frequency instead of some
    %arbitrary amplitude
    oldvals=0:step*numfiles/40:step*numfiles; 
    newvals=linspace(0,20,length(oldvals));
    set(gca,'XLim', [80 320]);
    set(gca,'YTick', oldvals);
    set(gca,'YTickLabel', newvals);

    %% Echo plotting with peaks and hyperbolae
    figure(2)
    hold on
    plot(ffreq, famp+(i)*step, locs, peaks+(i)*step, 'x');
    oldvals=0:step*numfiles/40:step*numfiles;
    newvals=linspace(0,20,length(oldvals));
    set(gca,'XLim', [0 10]);
    set(gca,'YTick', oldvals);
    set(gca,'YTickLabel', newvals);
    xlabel('Time (us)');
    ylabel('Modulation frequency (MHz)');
    title({'FT of comb data';userpath},'Interpreter','none');
    
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
figure(3)
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
title({'AFC Stored frequency vs programmed frequency';userpath},'Interpreter','none');

figure(4)
freq=startfreq:0.1:endfreq; %creates a frequency array spanning the modulating frequencies
time=1./freq;
hold on
for i=1:10
    plot(log(time),log(i*time),log(time),log(time/i))
end
plot(log(time),log(timevals),'x')
hline(log(cutoff),'r','Cutoff')
xlabel('Programmed storage time (log(us))');
ylabel('Storage time (log(us))');
title({'AFC Stored time vs programmed time';userpath},'Interpreter','none');

if(savefigs)
print('-f1','Combs','-dpdf','-r1000','-fillpage') %saves probe traces
print('-f2','AFCEchoes','-dpdf','-r1000','-fillpage') %saves echo traces
print('-f3','Colormap', '-dpdf','-r500','-fillpage') % saves storage time info
print('-f4','Storage','-dpdf','-r500','-fillpage') %saves efficiency figure
end