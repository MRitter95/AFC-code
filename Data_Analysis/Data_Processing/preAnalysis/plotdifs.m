

files=dir; %lists all the file and folder names
files=files(~ismember({files.name},{'.','..'})); %removes the 'current' and 'parent' directory folders
dirFlags=[files.isdir]; %flags each entry as a folder (boolean)
folders=files(dirFlags); %only store the folders

[~,idx]=sort_nat({folders.name});
folders=folders(idx);
diff=cell(1, length(folders));
net=cell(1, length(folders));
var=cell(1, length(folders));

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
    diff{k}=tempdiff;
    net{k}=tempnet;
    var{k}=tempvar;
end

