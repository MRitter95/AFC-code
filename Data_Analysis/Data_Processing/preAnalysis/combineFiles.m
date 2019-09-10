%This program takes in data files from the RSA and the Oscope and produces
%the averaged waveform or spectrum. It also saves all the data to bin files
%in the parent directory for further processing. It will process each
%directory (i.e. modulation frequency) in parallel (max is 4 I think).

function [] = combineFiles(userpath)
if(nargin<1)
    userpath=pwd;
    disp(['No directory provided, using current directory: ' pwd])
end
cd (userpath)
[~, date] = fileparts(userpath);
disp(['Processing data from: ' date])

%% Getting all the folder names from the directory
files=dir; %lists all the file and folder names
files=files(~ismember({files.name},{'.','..'})); %removes the 'current' and 'parent' directory folders
dirFlags=[files.isdir]; %flags each entry as a folder (boolean)
folders=files(dirFlags); %only store the folders

%% Loops through all the folders and processes the data
parfor k=1:length(folders)
    datafolder=folders(k).name; %get name of current folder
    disp(['Current data folder: ' datafolder])
    cd(datafolder); %cd into current folder where the data is stored 
    
    %get the various datafiles
    ofcdat=dir('ofc*.txt'); %Optical comb
    rfcdat=dir('rfc*.txt'); %RF comb
    odatC1=dir('C1*.trc'); %AFC comb
    odatC3=dir('C3*.trc'); %Probe
    
    datafiles=cell(4,3); %create a cell to hold all the data
    datafiles{1,1}=ofcdat;
    datafiles{2,1}=rfcdat;
    datafiles{3,1}=odatC1;
    datafiles{4,1}=odatC3;
    
    for i=1:4
        [xaxis,yaxis, hint, hoff, ygain, yoff]=doAVG(datafiles{i,1}); %average all the traces corresponding to a given dataset
        if (i>2)
            datafiles{i,2}=yaxis; %only keep y data since x data is just a scaled sequential array
            datafiles{i,3}=[hint, hoff, ygain, yoff]; %store waveform conversion data
        else
            datafiles{i,2}=[xaxis;yaxis]; %store data in corresponding cell
        end
    end

    cd .. %move up a directory to store files
    tooth=str2double(datafolder)/1e+6; %extract the tooth spacing for filenaming
    types={'ofc','rfc','afc','probe'};
    fileID=zeros(1,4);
    %Store a .txt file for each dataset
    for i=1:4
        filename=[types{i} num2str(tooth,'%0.1f') 'MHz.bin']; %creates filenames
        disp(['Saving: ' filename])
        fileID(i)=fopen(filename,'W'); %open file to write ('W' is faster apparently than'w')
        if(i<3)
            fwrite(fileID(i),datafiles{i,2},'float'); %write the [x;y] array to file in binary format to save some space
        else
            fwrite(fileID(i),datafiles{i,3},'float'); %write the various offsets and scaling factors to file
            fwrite(fileID(i),datafiles{i,2},'int16'); %only write y data to file to save space (x can be regenerated)
        end
        fclose(fileID(i)); %close file
    end
    
end