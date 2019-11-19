%This script calculates the difference between consecutive traces for all
%frequencies in an experiment and stores the results in three cells that
%can be plotted with the plotdiffs script if saved. 
%Input parameters are not required, code will prompt if no values are given
%Input: userpath is the full path to the data to be processed
%Input: expdate is a string containing the date of the experiment
%Output: none but saves the results of the computation to a .mat file for 
%plotting


function [] = plotdifs(userpath, expdate)

%% Get user input if input parameters are not provided
if(nargin<1)
    disp(['Using the current directory: ' pwd ])
    pathOK=input('Is that ok (Y/N)?','s');
    if(strcmp(pathOK,'Y') || (strcmp(pathOK,'y'))
        userpath = pwd;
    else
        userpath = input('Please enter the desired directory','s');
    end
    expdate      = input('Date of experiment: ','s');
end
disp(['Processing data from: ' userpath])
cd (userpath)

%% Get list of folders and sort them
files    = dir; %lists all the file and folder names
%removes the 'current', 'parent' directory folders and other junk
files    = files(~ismember({files.name},{'.','..','CombineFilesfull'})); 
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

%% Computation
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

outfile='plotdiff_output.mat';
save(outfile, 'difference', 'difflast', 'netval', 'variance', 'expdate', 'folders');

end
