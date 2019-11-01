%This program takes in data files from the RSA and the Oscope and produces
%the averaged waveform or spectrum. It also saves all the data to bin files
%in the parent directory for further processing. It will process each
%directory (i.e. modulation frequency) in parallel (max is 4 I think).

function [] = combineFiles(exptype, userpath, RSArange, numtoskip)

if(nargin<1)
    disp(['Using the current directory: ' pwd ])
    pathOK=input('Is that ok (Y/N)?','s');
    if(strcmp(pathOK,'Y')||strcmp(pathOK,'y'))
        userpath=pwd;
    else
        userpath=input('Please enter the desired directory','s');
    end
    exptype=input('afc or echo data?','s');
    RSArange=input('What was the RSA range in MHz?');
    numtoskip=input('How many traces should be skipped?');
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

%% Loops through all the folders and processes the data
parfor k=1:length(folders)
    datafolder=folders(k).name; %get name of current folder
    disp(['Current data folder: ' datafolder])
    %cd(datafolder); %cd into current folder where the data is stored 
    
    %get the various datafiles
    %ofcdat=dir('ofc*.txt'); %Optical comb
    %rfcdat=dir('rfc*.txt'); %RF comb
    %odatC1=dir('C1*.trc'); %AFC comb
    %odatC3=dir('C3*.trc'); %Probe
    
    filepath=fullfile(userpath, datafolder, 'ofc*.txt');
    ofcdat=dir(filepath);
    filepath=fullfile(userpath, datafolder, 'rfc*.txt');
    rfcdat=dir(filepath);
    filepath=fullfile(userpath, datafolder, 'C1*.trc');
    odatC1=dir(filepath);
    filepath=fullfile(userpath, datafolder, 'C3*.trc');
    odatC3=dir(filepath);
    
    for i=1:length(ofcdat)
        ofcdat(i).name=fullfile(userpath, datafolder, ofcdat(i).name);
    end
    for i=1:length(rfcdat)
        rfcdat(i).name=fullfile(userpath, datafolder, rfcdat(i).name);
    end
    for i=1:length(odatC1)
        odatC1(i).name=fullfile(userpath, datafolder, odatC1(i).name);
        odatC3(i).name=fullfile(userpath, datafolder, odatC3(i).name);
    end
    datafiles=cell(4,3); %create a cell to hold all the data
    datafiles{1,1}=ofcdat;
    datafiles{2,1}=rfcdat;
    datafiles{3,1}=odatC1;
    datafiles{4,1}=odatC3;
    
    for i=1:4
        [xaxis,yaxis, hint, hoff, ygain, yoff]=doAVG(datafiles{i,1}, RSArange, numtoskip); %average all the traces corresponding to a given dataset
        if (i>2)
            datafiles{i,2}=yaxis; %only keep y data since x data is just a scaled sequential array
            datafiles{i,3}=[hint, hoff, ygain, yoff]; %store waveform conversion data
        else
            datafiles{i,2}=[xaxis;yaxis]; %store data in corresponding cell
        end
    end
    %cd .. %move up a directory to store files
    tooth=str2double(datafolder)/1e+6; %extract the tooth spacing for filenaming
    types={'ofc','rfc',exptype,'probe'};
    fileID=zeros(1,4);
    %Store a .txt file for each dataset
    for i=1:4
        filename=[types{i} num2str(tooth,'%0.1f') 'MHz.bin']; %creates filenames
        arrsize=size(datafiles{i,2});
        if(arrsize(2)==1)
            disp('No data saved, continuing');
            continue;
        end
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