% Checks that the AFC is robust enough that it looks the same both times we
% sweep the probe. Calls COMBFIDELITY.M on each of the probe sweeps in the
% folder; for each call, it creates a bar plot of the number of teeth in 
% each of the two consecutive sweeps, number of overlapping teeth between
% the two sweeps, and expected number of teeth.

clc
close all
format short

folder = 'E:\2019_08_09\secondRun\data\';
ext= '.bin';

% make char array of all freqs, as they appear in filenames
loFreq=0.1;
hiFreq=20;
numFiles=200;
freqs= num2str(linspace(loFreq,hiFreq,numFiles)');

savefigs= false;

%% Main loop
for k= 1:numFiles
    figIndex= ceil(k/64);
    subIndex= 1+mod(k-1,64);

    if(savefigs)
        print(barPlot,sprintf('teeth%d',fignum-1),'-dpdf','-fillpage');%save hist figure 
    end

    % file being processed
    currentfilename= [folder,'afc',strtrim(freqs(k,:)),'MHz',ext];
    probeFile= [folder,'probe',strtrim(freqs(k,:)),'MHz',ext];
    fprintf('Filename is %s \n', currentfilename);
    [linOverlap,logOverlap]= combFidelity(currentfilename,probeFile);
    
    % build bar plot from peak data 
    inputfreq=str2double(freqs(k)); %Get current frequency
    numPeaks_aom4= floor(75/inputfreq);
    numPeaks_aom3= floor(90/inputfreq);
    barPlot= figure(figIndex);
%     title('Overlap between first and second sweeps (E:\\2019_08_09\\secondRun\\data\\)');
    subplot(10,10,subIndex);
    hold on
    title([strtrim(freqs(k,:)),' MHz']);
    
    bar(1-logOverlap,'b');
    bar(-1+linOverlap,'r');
end
if(savefigs)
    print(barPlot,sprintf('teeth%d',fignum),'-dpdf','-fillpage');
end