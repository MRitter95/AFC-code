

files=dir; %lists all the file and folder names
files=files(~ismember({files.name},{'.','..'})); %removes the 'current' and 'parent' directory folders
dirFlags=[files.isdir]; %flags each entry as a folder (boolean)
folders=files(dirFlags); %only store the folders

data=cell(3,length(folders));
    
for k=1:length(folders)
    figure(1)
    hold on
    cd(folders(k).name)
    disp(['Current data folder: ' folders(k).name])
    afcs=dir('C1*.trc');
    
    [data{1,k}, data{2,k}, data{3,k}]=takeDiff(afcs);
    plot(data{1,k})
    cd ..
end

