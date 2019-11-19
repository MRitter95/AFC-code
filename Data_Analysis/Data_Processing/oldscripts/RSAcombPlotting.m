%% User input

%Parameters for specific run
%TO DO: implement these in a simple config.txt file saved in the data
%folder

step=300; %vertical spacing between consecutive traces
minprom=50; %minimum prominence of a peak
mindist=0.1; %minimum distance between peaks
startfreq=0.1; %start frequency for comb
endfreq=20; %end frequency for comb

%% Filenames

% Get file names for the afc and probe data and sort them correctly 
files=dir('ofc*.bin');
[~,idx]=sort_nat({files.name});
files=files(idx);
numfiles=length(files);

%% Analysis

figure(1)
hold on

parray=[]; %array to hold the peak heights for the ofc
larray=[]; %array to hold the peak locations for the ofc

%This for loop runs through all the files in the directory and produces
%combined combs as well as the fourier transform of the comb
for i=1:numfiles
    %get the fourier transformed data (first two variables) and the
    %combined comb data for plotting
    [ff, fa, freq, amp]=RSAcombAnalysis(files(i).name, [50 150]);
    %Get the peaks and locations of peaks in the fourier transform data for
    %visualization and later analysis
    [peaks,locs]=findpeaks(fa, ff, 'MinPeakProminence', minprom, ...
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
    figure(1)
    plot(ff, fa+(i)*step, locs, peaks+(i)*step, 'x');
    xlim([0 10]);
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
hold on
time=1./fs;
yyaxis left
plot(log(time),log(larray),'x',log(time),log(time)) %plots the storage time vs programmed time as well as the expected y=x line
xlabel('Programmed storage time (us)');
ylabel('Storage time (us)');

yyaxis right
plot(log(time),parray/max(parray)) %plots storage efficiency (relative) vs storage time
ylabel('Relative efficiency');
print('-f2','FullEfficiency','-dpdf','-fillpage') %saves efficiency figure