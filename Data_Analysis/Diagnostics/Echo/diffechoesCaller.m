function [] = diffechoesCaller(userpath)

currentdir=pwd;
if(nargin<1)
    disp(['Using the current directory: ' pwd ])
    pathOK=input('Is that ok (Y/N)?','s');
    if(strcmp(pathOK,'Y')||strcmp(pathOK,'y'))
        userpath=pwd;
    else
        userpath=input('Please enter the desired directory: ','s');
    end
end
disp(['Processing data from: ' userpath])
cd (userpath)

%% Getting all the folder names from the directory
files=dir; %lists all the file and folder names
files=files(~ismember({files.name},{'.','..'})); %removes the 'current' and 'parent' directory folders
dirFlags=[files.isdir]; %flags each entry as a folder (boolean)
folders=files(dirFlags); %only store the folders

[~, idx]=sort_nat({folders.name});
folders=folders(idx); %sorts the folders by frequency

fcount=1;
numx=5;
numy=2;
plotindex=1;
figure(fcount)
for i=1:length(folders)
    datafolder=folders(i).name;
    ints=diffechoes(datafolder);
    tooth=str2double(datafolder)/1e+6;
    
    if(mod(i,numx*numy)==1 && i~=1)
        fcount=fcount+1;
        plotindex=plotindex-(numx*numy);
        filename = sprintf('plot-%dMHz',fcount-2);
        print('-dpng', filename);
    end
    figure(fcount);
    subplot(5,2,plotindex)
    title(sprintf('%0.1f MHz',tooth));
    for j=1:length(ints(:,1))
        hold on
        plot(ints(j,:))
    end
    plotindex=plotindex+1;
end
filename = sprintf('plot-%dMHz',fcount-1);
print('-dpng', filename);
cd(currentdir)
