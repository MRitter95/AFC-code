%This program takes in data files from the RSA and the Oscope and produces
%the averaged waveform or spectrum. It also saves all the data to bin files
%in the parent directory for further processing. It will process each
%directory (i.e. modulation frequency) in parallel
%Input parameters are not required, code will prompt if no values are given
%Input: exptype is a string (afc or echo) describing the experiment
%Input: userpath is the path to the data to be processed
%Input: RSArange is the max value of the RSA (assumes start is 0)
%Input: numtoskip is the number of traces to skip before starting to combine
%the files. This is to improve the final results. Number can be determined
%from the difftracesCaller output
%Output: none, saves the combined files to binary files for later analysis

function [] = combineFiles(exptype, userpath, RSArange, numtoskip)

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
    RSArange     = input('What was the RSA max freq (typically 300,400 or 600) in MHz?');
    numtoskip    = input('How many traces should be skipped?');
end
disp(['Processing data from: ' userpath])
cd (userpath)

%% Getting all the folder names from the directory
files=dir; %lists all the file and folder names
%removes the 'current' and 'parent' directory folders
files=files(~ismember({files.name},{'.','..'})); 
dirFlags=[files.isdir]; %flags each entry as a folder (boolean)
folders=files(dirFlags); %only store the folders
%sort folders by numerical value
[~, idx]=sort_nat({folders.name});
folders=folders(idx); %sorts the folders by frequency

%% Loops through all the folders and processes the data
parfor k=1:length(folders)

    datafolder=folders(k).name; %get name of current folder
    disp(['Current data folder: ' datafolder])
    
    filepath = fullfile(userpath, datafolder, 'ofc*.txt');
    ofcdat   = dir(filepath);
    filepath = fullfile(userpath, datafolder, 'rfc*.txt');
    rfcdat   = dir(filepath);
    filepath = fullfile(userpath, datafolder, 'C1*.trc');
    odatC1   = dir(filepath);
    filepath = fullfile(userpath, datafolder, 'C3*.trc');
    odatC3   = dir(filepath);
    
    %Build full path names of the file so that we can avoid cd commands
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

    datafiles      = cell(4,3); %create a cell to hold all the data
    datafiles{1,1} = ofcdat;
    datafiles{2,1} = rfcdat;
    datafiles{3,1} = odatC1;
    datafiles{4,1} = odatC3;
    
    %Average the traces
    %for echo measurement data, we call a different averaging program for
    %the scope traces in order to fix the few ns jitter between traces.
    if(strcmp(exptype,'echo')||...
                strcmp(exptype,'Echo')||...
                    strcmp(exptype,'ECHO'))
            for i=1:3
                if i<3      %average RSA traces as usual
                    [xaxis,...
                        yaxis,~]= doAVG(datafiles{i,1},RSArange,numtoskip);
                    datafiles{i,2}=[xaxis;yaxis];
                else        %average scope traces after correcting jitter
                    [~,normAxis,echoAxis,xInt,xOff,normGain,normOff,...
                        echoGain,echoOff]= doAVG_echo(datafiles{3,1},...
                        datafiles{4,1},numtoskip);
                    datafiles{3,2}= echoAxis;
                    datafiles{4,2}= normAxis;
                    datafiles{3,3}= [xInt,xOff,echoGain,echoOff];
                    datafiles{4,3}= [xInt,xOff,normGain,normOff];
                end
            end
            
    %if we are looking at AFC data, the few ns jitter is not important and
    %we average as usual.
    else
        for i=1:4
            [xaxis,yaxis,hint,hoff,...
                ygain,yoff]= doAVG(datafiles{i,1},...
                RSArange,numtoskip); %average all traces
            if (i>2)
                datafiles{i,2}= yaxis; %only keep y data since x data is just a scaled sequential array
                datafiles{i,3}= [hint, hoff, ygain, yoff]; %store waveform conversion data
            else
                datafiles{i,2}= [xaxis;yaxis]; %store data in corresponding cell
            end
        end
    end

%     tooth=str2double(datafolder)/1e+6; %extract the tooth spacing for filenaming
    types={'ofc','rfc',exptype,'probe'};
    fileID=zeros(1,4);
    %Store a .bin file for each dataset
    for i=1:4
        filename = [types{i} num2str(datafolder,'%d') 'Hz.bin']; %creates filenames
        arrsize  = size(datafiles{i,2}); %check for empty files

        if(arrsize(2)==1)
            disp('No data saved, continuing');
            continue;
        end

        disp(['Saving: ' filename])

        fileID(i)=fopen(filename,'W'); %open file to write ('W' is faster apparently than'w')
        if(i<3)
            %write the [x;y] array to file in binary format to save some space
            fwrite(fileID(i),datafiles{i,2},'float'); 
        else
            %write the various offsets and scaling factors to file 
            fwrite(fileID(i),datafiles{i,3},'float'); 
            %only write y data to file to save space (x can be regenerated)
            fwrite(fileID(i),datafiles{i,2},'int16'); 
        end
        fclose(fileID(i)); %close file
    end
    
end
