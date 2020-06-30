%This function generates a colormap plot of the echoes. The intensity/
%brightness on the colormap indicates the relative efficiency of storage at
%that frequency. The code expects a configuration file containing the peak
%finding parameters (prominence and min distance) and the experimental
%parameters (start and stop frequency, sweeprate etc.). If no path is
%specified, the code will use the current directory to find all the files
%(currently the config file is one folder up)
%Input: config, file containing peakfinding and sweep parameters
%Input: userpath, path to .bin files
%Input: savefigs, boolean for user to speficy whether figures should be saved
%Input: plotprobes, boolean controlling if the probes are plotted on the combs
%Output: none, saves figure in pdf/ .fig format if savefigs is true

function [freq,timevals,echovals,echoPeaks] = colormappingAFC_single(config,freqFile,...
    userpath, saveFigs, saveTextTraces, plotprobes)

%% User input

%Parameters for specific run
if(nargin<1)
    disp(['Using the current directory: ' pwd ])
    pathOK         = input('Is that ok (Y/N)?','s');
    if(strcmp(pathOK,'Y') || strcmp(pathOK,'y'))
        userpath   = pwd;
    else
        userpath   = input('Please enter the desired directory','s');
    end
    config         = input('Path to config file','s');
    freqFile       = input('Path to freq file','s');
    ufigs          = input('Save figures and pdfs? (Y/N)','s');
    if(strcmp(ufigs,'Y') || strcmp(ufigs,'y'))
        saveFigs   = true;
    else
        saveFigs   = false;
    end
    utraces        = input('Save combs in text files? (Y/N)','s');
    if(strcmp(utraces,'Y') || strcmp(utraces,'y'))
        saveTextTraces   = true;
    else
        saveTextTraces   = false;
    end 
    uprobes        = input('Plot probes? (Y/N)','s');
    if(strcmp(uprobes,'Y') || strcmp(uprobes,'y'))
        plotprobes = true;
    else
        plotprobes = false;
    end
end
disp(['Processing data from: ' userpath])
cd (userpath)

%%Configuration
fileID     = fopen(config);
if(fileID == -1)
    error('unable to open file');
end
config     = textscan(fileID,'%s%f');
fclose(fileID);

fid= fopen(freqFile);
if(fid == -1)
    error('unable to open freq file');
end
freqs= textscan(fid,'%f');
freqs= freqs{1,1}/(1e6);
fclose(fid);

params     = config{1};
vals       = config{2};
% step       = vals(1); %vertical spacing between consecutive traces
scale       = 50/min(diff(freqs));
minprom    = vals(2); %minimum prominence of a peak
mindist    = vals(3); %minimum distance between peaks
startfreq  = min(freqs); %start frequency for comb
endfreq    = max(freqs); %end frequency for comb
sweepRange     = [vals(6) vals(7)]; %freq range of first sweep
% sweep2     = [vals(8) vals(9)]; %freq range for second seep
% sweepspeed = vals(10); %sweep speed in MHz/s
sweepSpeed= vals(8);
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
%variables to hold processed data for a delta-function input
echovals = zeros(200,200); %array to hold all the echoes
timevals = zeros(1,numfiles);
markerSizes= timevals;

% %second set to handle the real pulse
% echovals2 = zeros(200,200); 
% timevals2 = zeros(1,numfiles);
% markerSizes2= timevals;

%This for loop runs through all the files in the directory and produces
%combined combs as well as the fourier transform of the comb
for i=1:numfiles
    %get the fourier transformed data (first two variables) and the
    %combined comb data for plotting
    [ffreq, famp, f, AFC, probe]= combAnalysisN( ...
        afcfiles(i).name, probefiles(i).name, sweepRange(1), sweepSpeed);

    if(saveTextTraces)
        txtFile= [userpath,...
            '\textFiles\afc', num2str(i/10,'%0.1f'), 'MHz.txt'];
        writematrix([f,AFC],txtFile);
    end
    
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
        for j=1:length(locs)
            if(locs(j)>10.)
                continue;
            end
            xind = round(10./locs(j));%generates stored freq *10
            if(xind > 200)
                xind = 200; %fixes out of range issues
            end
            echovals(xind,i) = peaks(j);
        end
        [markerSizes(i),im]      = max(peaks);
        timevals(i) = locs(im);
    end
    
%     %we can improve this analysis. the above gives the storage of a
%     %delta-function input pulse. here we do the same thing again for the
%     %a 20-ns Gaussian (to do: replace with measured pulse). instead of
%     %looking directly at FFT of AFC, first convolute it with time-domain
%     %pulse.
%     k=1;
%     conv= zeros(size(ffreq));
%     while ffreq(k)<10+0.02   %stop convolution at 10us + pulsewidth.
%         
%         %replace this stuff with the real pulse
%         sig= 0.00425;
%         pulse= sig*sqrt(2*pi)*exp(-((ffreq-ffreq(k))/(sqrt(2)*sig)).^2);
% %         %flip pulse for convolution (not necessary for Gaussian)
% %         pulse= fliplr(pulse')';
% 
%         conv(k)= sum(pulse.*famp);
%         k= k+1;
%     end
%%%%%%%%%%%%%%%%%
%     %we proceed to locate peaks in conv exactly the same way as for famp.
%     [peaks2,locs2] = findpeaks(conv(startind:end), ffreq(startind:end),...
%         'MinPeakProminence',minprom, 'MinPeakDistance', mindist);
% 
%     %Add all the peaks found to the echo array as well as the extracted
%     %'storage' frequency (1/tstorage)
%     if(~isempty(locs2))
%         for j=1:length(locs2)
%             if(locs2(j)>10.)
%                 continue;
%             end
%             xind = round(10./locs2(j));%generates stored freq *10
%             if(xind > 200)
%                 xind = 200; %fixes out of range issues
%             end
%             echovals2(xind,i) = peaks2(j);
%         end
%         [markerSizes2(i),im]      = max(peaks2);
%         timevals2(i) = locs2(im);
%     end
%%%%%%%%%%%%%%%%%
    
    %Plotting the combined combs
    combFig = figure(1);
    hold on
    plot(f, AFC+freqs(i)*scale)
    if(plotprobes)
        plot(f, probe+freqs(i)*scale);
    end
    xlabel('Frequency (MHz)');
    ylabel('Modulation frequency (MHz)');
    title({'Comb data';userpath},'Interpreter','none');
%     %create y-tick marks that show modulation frequency instead of some
%     %arbitrary amplitude
%     oldvals=0:scale*numfiles/40:scale*numfiles; 
%     newvals=linspace(0,20,length(oldvals));
%     set(gca,'XLim', [80 320]);
%     set(gca,'YTick', oldvals);
%     set(gca,'YTickLabel', newvals);
%     set(gca,'TickDir','out');

    % Echo plotting with peaks and hyperbolae
    combsfftFig = figure(2);
    hold on
    plot(ffreq, famp+freqs(i)*scale*1000);%, locs, peaks+freqs(i)*scale*100,'x');
    xlabel('Time (\mus)');
    ylabel('Modulation frequency (MHz)');
    title({'FT of comb data';userpath},'Interpreter','none');

    yticks(freqs*scale*1000);
    yticklabels(freqs);
% %     %Create y-tick marks that show modulation frequency
%     oldvals=0:step*numfiles/40:step*numfiles;
%     newvals=linspace(0,20,length(oldvals));
%     set(gca,'XLim', [0 10]);
%     set(gca,'YTick', oldvals);
%     set(gca,'YTickLabel', newvals);
%     set(gca,'TickDir','out');

%     % Echo plotting with peaks and hyperbolae
%     echoSim = figure(3);
%     hold on
%     plot(ffreq, conv+(i)*step, locs, peaks+(i)*step, 'x');
%     xlabel('Time (\mus)');
%     ylabel('Modulation frequency (MHz)');
%     title({'Comb FT convoluted with pulse';userpath},'Interpreter','tex');
%     %Create y-tick marks that show modulation frequency
%     oldvals=0:step*numfiles/40:step*numfiles;
%     newvals=linspace(0,20,length(oldvals));
%     set(gca,'XLim', [0 10]);
%     set(gca,'YTick', oldvals);
%     set(gca,'YTickLabel', newvals);
%     set(gca,'TickDir','out');
    
    % Update user about current frequency
    disp([num2str(i./10) ' MHz']);
end
figure(1)
yticks(freqs*scale);
yticklabels(freqs);

figure(2)
yticks(freqs*scale);
yticklabels(freqs);


% %Produce the theoretical curves for where the peaks should be (1/f curves
% %since we are essentially seeing an echo here)
% 
% fs=linspace(startfreq,endfreq,numfiles);
% heights=scale:scale:scale*numfiles;
% for i=1:0.5:10
%     plot(i./fs,heights,1./(i*fs),heights)
% end

% %Build color map of where the echoes occur in frequency space
% %Look at cumulative stored power by summing over the array rows
figure(4)
echovals=echovals/max(echovals,[],'all');
imshow(echovals)
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
title({'AFC Stored frequency vs programmed frequency';userpath},'Interpreter','tex');
pbaspect([1 1 1])

%Show the main storage time versus the programmed time (expect 
%times to lie on harmonics of 1/f
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
end

echoPeaks= markerSizes/max(markerSizes);
markerSizes= 0.001+300*echoPeaks;
scatter(time,timevals,markerSizes,'MarkerEdgeColor',...
    [0,0.4470,0.7410],'LineWidth',1.5);
hold off

xlabel('Optical comb inverse tooth spacing (\mus)');
ylabel('AFC storage time (\mus)');
title({'Storage time inferred from AFC';userpath},'Interpreter','none');
set(gca,'TickDir','out');
pbaspect([1 1 1])

%%%%%%%%%%
figure(6)
hold on
for i=1:10
    plot(freq,i*time,...
        freq,time/i,'Color',0.1*(i-1)*[1,1,1],'LineWidth',2/i);
end
% markerSizes= 0.001+300*markerSizes/max(markerSizes);
scatter(freq,timevals,markerSizes,'MarkerEdgeColor',...
    [0,0.4470,0.7410],'LineWidth',1.5);
hold off
xlabel('Optical comb tooth spacing (MHz)');
ylabel('AFC storage time (\mus)');
title({'Storage time inferred from AFC';userpath},'Interpreter','none');
set(gca,'TickDir','out');

% %Repeat efficiency plot, considering input pulse
% figure(6)
% set(gca,'XScale','log','YScale','log');
% xlim([0.05,2]);
% ylim([0.05,2]);
% hold on
% 
% for i=1:10
%     loglog(time,i*time,...
%         time,time/i,'Color',0.1*(i-1)*[1,1,1],'LineWidth',2/i);
% end
% 
% markerSizes2= 0.001+300*markerSizes2/max(markerSizes2);
% scatter(time,timevals2,markerSizes2,'MarkerEdgeColor',...
%     [0,0.4470,0.7410],'LineWidth',1.5);
% hold off
% 
% xlabel('Optical comb inverse tooth spacing (\mus)');
% ylabel('AFC storage time (\mus)');
% title({'Storage time for real input pulse';userpath},'Interpreter','tex');
% set(gca,'TickDir','out');
% pbaspect([1 1 1])

if(saveFigs)
savefig(combFig,'combs','compact') %saves comb traces
% savefig(combsfftFig,'deltaEchoes','compact') %saves FFT traces
% savefig(echoSim,'pulseEchoes','compact') %saves FFT traces
% print('-f4','colormap', '-dpdf','-r500','-bestfit') % saves storage time info
print('-f5','idealStorage','-dpdf','-r500','-bestfit') %saves efficiency figure
% print('-f6','expectedStorage','-dpdf','-r500','-bestfit') %saves efficiency figure

end

end
