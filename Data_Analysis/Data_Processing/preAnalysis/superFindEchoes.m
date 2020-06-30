%% Getting all the folder names from the directory
userpath= pwd;
files=dir; %lists all the file and folder names
%removes the 'current' and 'parent' directory folders
files=files(~ismember({files.name},{'.','..'})); 
dirFlags=[files.isdir]; %flags each entry as a folder (boolean)
folders=files(dirFlags); %only store the folders
%sort folders by numerical value
[~, idx]=sort_nat({folders.name});
folders=folders(idx); %sorts the folders by frequency

histData= cell(length(folders));
parfor k=1:length(folders)

    datafolder=folders(k).name; %get name of current folder
    disp(['Current data folder: ' datafolder])
    
    filepath = fullfile(userpath, datafolder, 'C1*.trc');
    echoDat  = dir(filepath);
    filepath = fullfile(userpath, datafolder, 'C3*.trc');
    normDat  = dir(filepath);
    
    for i=1:length(echoDat)
        echoDat(i).name=fullfile(userpath, datafolder, echoDat(i).name);
        normDat(i).name=fullfile(userpath, datafolder, normDat(i).name);
    end
    
    histData{k}= findEchoes(echoDat,normDat);
    close all
end

save('newHistograms.mat','histData');
