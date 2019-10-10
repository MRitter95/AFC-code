files=dir; %lists all the file and folder names
files=files(~ismember({files.name},{'.','..'})); %removes the 'current' and 'parent' directory folders
dirFlags=[files.isdir]; %flags each entry as a folder (boolean)
folders=files(dirFlags); %only store the folders

[~,idx]=sort_nat({folders.name});
folders=folders(idx);
difference=cell(1, length(folders));
netval=cell(1, length(folders));
variance=cell(1, length(folders));

topdir=pwd;

parfor k=1:length(folders)
    currentdir=folders(k).name;
    disp(['Current data folder: ' currentdir])
    filepath=fullfile(topdir, currentdir, 'C1*.trc');
    afcs=dir(filepath);
    for i=1:length(afcs)
        afcs(i).name=fullfile(topdir, currentdir, afcs(i).name);
    end
    
    tempdiff=zeros(1, length(afcs));
    tempnet=zeros(1, length(afcs));
    tempvar=zeros(1, length(afcs));
    
    [tempdiff, tempnet, tempvar]=takeDiff(afcs);
    difference{k}=tempdiff;
    netval{k}=tempnet;
    variance{k}=tempvar;
end