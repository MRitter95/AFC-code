%This script calculates the difference between consecutive traces for all
%frequencies in an experiment and stores the results in three cells that
%can be plotted with the plotdifplotter script if saved. 

%% Get list of folders and sort them
files    = dir; %lists all the file and folder names
%removes the 'current' and 'parent' directory folders
files    = files(~ismember({files.name},{'.','..'})); 
dirFlags = [files.isdir]; %flags each entry as a folder (boolean)
folders  = files(dirFlags); %only store the folders
%sort folders currently by numerical value
[~,idx]  = sort_nat({folders.name}); 
folders  = folders(idx);

%% Initialization
difference = cell(1, length(folders));
difflast   = cell(1, length(folders));
netval     = cell(1, length(folders));
variance   = cell(1, length(folders));
topdir     = pwd;

parfor k=1:length(folders) %loop over all the folders in the directory
    currentdir=folders(k).name; %get current folder name
    disp(['Current data folder: ' currentdir])
    %create full file path to files that will be processed
    filepath = fullfile(topdir, currentdir, 'C1*.trc');
    afcs     = dir(filepath);
    
    for i=1:length(afcs)
        %add directory info to dir output so we don't have to CD into the
        %folder
        afcs(i).name=fullfile(topdir, currentdir, afcs(i).name);
    end
    
    % Initialize arrays (required when using parfor apparently)
    tempdiff     = zeros(1, length(afcs));
    tempdifflast = zeros(1,length(afcs));
    tempnet      = zeros(1, length(afcs));
    tempvar      = zeros(1, length(afcs));
    
    [tempdiff, tempdifflast, tempnet, tempvar]=takeDiff(afcs);
    
    %store results in cell
    difference{k} = tempdiff;
    difflast{k}   = tempdifflast;
    netval{k}     = tempnet;
    variance{k}   = tempvar;
end