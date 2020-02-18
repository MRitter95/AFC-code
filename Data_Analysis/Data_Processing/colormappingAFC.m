%This function does all analysis of AFC data. If no inputs are provided, it
%will ask the user for file locations.

%Input: config.mat, file containing experimental and analysis parameters
%Input: userpath, path to .bin files
%Input: savefigs, boolean for user to speficy whether figures should be saved
%Input: plotprobes, boolean controlling if the probes are plotted on the combs
%Output: none, saves figure in pdf/fig format if savefigs is true

function [] = colormappingAFC()

%Parameters for specific run
disp(['Using .bin files in directory: ' pwd ])
pathOK         = input('Is that ok (Y/N)?','s');
if(strcmp(pathOK,'Y') || strcmp(pathOK,'y'))
    userpath   = pwd;
else
    userpath   = input('Please enter directory with .bin files: ','s');
    cd (userpath);
end

ufigs          = input('Savefigs? (Y/N)','s');
if(strcmp(ufigs,'Y') || strcmp(ufigs,'y'))
    savefigs   = true;
else
    savefigs   = false;
end

uprobes        = input('Plot probes? (Y/N)','s');
if(strcmp(uprobes,'Y') || strcmp(uprobes,'y'))
    plotprobes = true;
else
    plotprobes = false;
end

disp(['Processing data from: ' userpath])

%% Configuration
if(~isfile('config.mat'))
    disp('No config file in this directory. Let`s make a new one.');
    makeConfigFile;
end

disp(['Loading ',pwd,'\config.mat']);
load config.mat;

%% Filenames

% Get file names for the afc and probe data and sort them correctly 
afcfiles   = dir('afc*.bin');
[~,idx]    = sort_nat({afcfiles.name});
afcfiles   = afcfiles(idx);
probefiles = dir('probe*.bin');
[~,idx]    = sort_nat({probefiles.name});
probefiles = probefiles(idx);
numfiles   = length(afcfiles);

%% Analysis

echovals = zeros(200,200); %array to hold all the echoes
timevals = zeros(1,numfiles);

%This for loop runs through all the files in the directory and produces
%combined combs as well as the fourier transform of the comb
for i=1:numfiles
    %get the fourier transformed data (first two variables) and the
    %combined comb data for plotting
    [ffreq, famp, combinedf, combineda, probe1, f1]=combAnalysisN( ...
        afcfiles(i).name, probefiles(i).name, sweep1, sweepspeed);

    %Get the peaks and locations of peaks in the fourier transform data for
    %visualization and later analysis
    %ignore peaks before 1/20 MHz because our resolution is bad
    cutoff       = 0.05;
    startind     = findEl(ffreq,cutoff);
    [peaks,locs] = findpeaks(famp(startind:end), ffreq(startind:end),...
        'MinPeakProminence',minprom, 'MinPeakDistance', mindist);

    %Add all the peaks found to the echo array as well as the extracted
    %'storage' frequency (1/tstorage)
    if(~isempty(locs))
        for a=1:length(locs)
            if(locs(a)>10.)
                continue;
            end
            xind = round(10./locs(a));%generates stored freq multiplied by 10
            if(xind > 200)
                xind = 200; %fixes out of range issues
            end
            echovals(xind,i) = peaks(a);
        end
        [~,im]      = max(peaks);
        timevals(i) = locs(im);
    end
    
    %Plotting the combined combs
    combs = figure(1);
    hold on
    plot(combinedf, combineda+(i)*step)
    if(plotprobes)
        plot(f1, probe1+(i)*step);
    end
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
    set(gca,'TickDir','out');

    % Echo plotting with peaks and hyperbolae
    combsfft = figure(2);
    hold on
    plot(ffreq, famp+(i)*step, locs, peaks+(i)*step, 'x');
    xlabel('Time (us)');
    ylabel('Modulation frequency (MHz)');
    title({'FT of comb data';userpath},'Interpreter','none');
    %Create y-tick marks that show modulation frequency
    oldvals=0:step*numfiles/40:step*numfiles;
    newvals=linspace(0,20,length(oldvals));
    set(gca,'XLim', [0 10]);
    set(gca,'YTick', oldvals);
    set(gca,'YTickLabel', newvals);
    set(gca,'TickDir','out');

    % Update user about current frequency
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
figure(3)
echovals=echovals/max(echovals,[],'all');
imagesc(echovals)
set(gca,'YDir','normal')
oldvals=0:20:200;
newvals=linspace(0,20,length(oldvals));
set(gca,'XTick', oldvals);
set(gca,'XTickLabel', newvals);
set(gca,'YTick', oldvals);
set(gca,'YTickLabel', newvals);
set(gca,'TickDir','out');
xlabel('Modulation frequency (MHz)');
ylabel('Storage frequency (MHz)');
title({'AFC Stored frequency vs programmed frequency';userpath},'Interpreter','none');
pbaspect([1 1 1])

%Show the main storage time versus the programmed time (expect 
%times to lie on harmonics of 1/f
figure(4)
freq = startfreq:0.1:endfreq; 
time = 1./freq;
hold on
for i=1:10
    plot(log(time),log(i*time),log(time),log(time/i))
end
plot(log(time),log(timevals),'x')
pbaspect([1 1 1])
hline(log(cutoff),'r','Cutoff')
xlabel('Programmed storage time (log(us))');
ylabel('Storage time (log(us))');
title({'AFC Stored time vs programmed time';userpath},'Interpreter','none');
set(gca,'TickDir','out');

if(savefigs)
savefig(combs,'Combs','compact') %saves comb traces
savefig(combsfft,'AFCEchoes','compact') %saves FFT traces
print('-f3','Colormap', '-dpdf','-r500','-bestfit') % saves storage time info
print('-f4','Storage','-dpdf','-r500','-bestfit') %saves efficiency figure
end

end
