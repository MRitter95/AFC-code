%Quick and dirty script to run the combineFiles code on a full
%data set (with subfolders containing the up and down sweep data)
%Input: exptype is a string describing the experiment (afc or echo)
%Input: userpath is the path to the toplevel directory were the data
%is stored. The code expects a directoy of the following structure 
% userpath/(0 or 1)/frequency folders
%Output: none, saves the combined files to binary files for analysis

function [] = superCombine(exptype, userpath)

%store the current directory
startpath = pwd;

%% Get user input if input parameters are not specified
if(nargin<1)
    disp(['Using the current directory: ' pwd ])
    pathOK       = input('Is that ok (Y/N)?','s');
    if(strcmp(pathOK,'Y') || strcmp(pathOK,'y'))
        userpath = pwd;
    else
        userpath = input('Please enter the desired directory','s');
    end
    exptype      = input('afc or echo data?','s');
    RSArange     = input('What was the RSA range in MHz?');
    numtoskip    = input('How many traces should be skipped?');
end

cd(userpath)
cd('0')
combineFiles(exptype, fullfile(userpath, '0\'), RSArange, numtoskip)
cd('../1')
combineFiles(exptype, fullfile(userpath, '1\'), RSArange, numtoskip)

cd(startpath)
