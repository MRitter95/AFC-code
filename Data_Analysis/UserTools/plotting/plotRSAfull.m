%This generates plots of the RSA data (RF/ Optical comb data)
%The code takes in a list of files and generates plots and histograms of
%the teeth distribution

function [] = plotRSAfull(tracename,savefigs, start, step, userpath)

close all

olddir=pwd;
startfreq=1;
freqstep=0.1;
if(nargin>1)
    savefigs=true;
    if(nargin>2)
        startfreq=start;
        freqstep=step;
        if(nargin>4)
            cd(userpath)
            disp(['Plotting data from ' userpath])
        end
    end
end

dirlist=dir([tracename '*.bin']);
[~,idx]=sort_nat({dirlist.name});
dirlist=dirlist(idx);
numfiles=length(dirlist);

if(numfiles==0)
    disp('No files found')
    %TO DO: break
end

indexb=0;
numsubs=4;
fignum=0;
%% Make edge array for hist
edge=0.05;
edges=[];
while edge<=20.1
    edges=[edges,edge];
    edge=edge+0.1;
end

for i=1:numfiles
    currentfile=dirlist(i).name;
    data=readbin(currentfile,'false');
    fullplot=figure(1);
    plot(data.x,data.y+35*i);
    title(sprintf('%s data',upper(tracename)));
    xlim([0 200])
    hold on
    %% Building histogram from peak data 
    %% Index magic
    indexb=indexb+1; %Ratchet hist subplot index up by one
    if(mod(i,5*numsubs)==1) %Everytime we fill a figure with plots we have to reset the indices
        fignum=fignum+1; %Move to new figure
        if(i~=1)
            indexb=indexb-numsubs*5; %reset index for hist subplots
            if(savefigs)
                print(histfig,sprintf('%steeth%d',upper(tracename),fignum-1),'-dpdf','-r500','-fillpage');%save hist figure 
            end
        end 
    end
    
    histfig=figure(fignum+1);
    subplot(5,numsubs,indexb)
    inputfreq=startfreq+(i-1)*freqstep; %Get current frequency
        
    [~,locs] = findpeaks(data.y, data.x,'MinPeakProminence',5);
    len=length(locs);
    difference=locs(2:len)-locs(1:len-1);
    histogram(difference, edges) %Plot histogram of peak spacing with bins spaced 0.1 MHz
    title(['Comb at ' num2str(inputfreq) ' MHz']);
    v=vline([inputfreq inputfreq/2],{'r','b'},{'C','H'}); %Adds vertical lines at the comb freq (C) and half the comb frequency (H)
    %%
end

if(savefigs)
    print(fullplot,sprintf('Full%splot',upper(tracename)),'-dpdf','-r1200','-bestfit');
    print(histfig,sprintf('%steeth%d',upper(tracename), fignum),'-dpdf','-r1200','-fillpage');
end
cd(olddir)  