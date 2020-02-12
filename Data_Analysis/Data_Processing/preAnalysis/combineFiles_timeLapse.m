%This program is a modification of COMBINEFILES.M. Instead of averaging
%all scope traces for each setting, it averages subsets of consecutive
%traces. The result is a sequence of averaged data showing the time
%evolution of the comb/echo. Unlike the original COMBINEFILES.M, the
%scope traces here are not all equivalent: the correspond to different time
%points. So it's more important than usual to make sure that the number of
%traces per setting is not varying a lot.

%It also saves all the data to bin files
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

function [] = combineFiles_timeLapse(exptype,userpath,RSArange,numFrames)

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
%     numtoskip    = input('How many traces do you want to skip?');
    numFrames    = input('How many frames do you want in your movie?');
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
%% Loops through the folders, breaks comb/echo data into NFRAMES. Gives
%  in case all frames don't have equal number of traces (so it WILL give a
%  warning).

%200xNFRAMES array; (J,K) is the number of traces in frame K for freq. J.
partitions= zeros(length(folders),numFrames);

%keep track of "errors"
errors= zeros(length(folders),1);

%use this plot to visualize time glitches... maybe. I can't think of a
%good solution right now...
% figure
% hold on
% offset=1;
for j=1:length(folders)
    numTraces= length(dir(fullfile(userpath,folders(j).name,'C1*.trc')));
    partitions(j,:)= ones(1,numFrames)*floor(numTraces/numFrames);
    errors(j)= numTraces-sum(partitions(j,:));
    if errors(j)>0
        partitions(j,end-errors(j)+1:end)=partitions(j,end-errors(j)+1:end)+1;
    end
    
%     plot(partitions(j,:)+(j-1)*offset,'-*');
end

%more useful will be the array of ending indices for each frame:
for j=2:numFrames
    partitions(:,j)= partitions(:,j)+partitions(:,j-1);
end

%this program takes a long time to finish. if it crashes midway, you don't
%want to start from the beginning. instead, input an array of the
%frequency indices (10*frequency in MHz) that have not yet been measured.
%(see CHECKCOMBINEPROGRESS.M to quickly get this information)
toMeasure= [109:112,121:124,133:137,145:150,157:200];

%% Loops through all the folders and processes the data
parfor k=1:length(folders)
    
    % in case of a crash, skip over freqs that have been processed already
    if ~ismember(k,toMeasure)
        continue;
    end

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
    for i=1:4
        if (i>2)
            datafiles{i,2}=[];
            for j=1:numFrames
                if j==1
                    first= 1;
                else
                    first= partitions(k,j-1)+1;
                end
                last= partitions(k,j);
                
                [xaxis,yaxis, hint, hoff, ygain, yoff]=doAVG(datafiles{i,1}(first:last), RSArange, 0); %average all the traces corresponding to this frame
                
                datafiles{i,2}=[datafiles{i,2};yaxis]; %store averaged y data; next frame will be on the next row.
            end
            datafiles{i,3}=[hint, hoff, ygain, yoff]; %store waveform conversion data
        else
            [xaxis,yaxis, hint, hoff, ygain, yoff]=doAVG(datafiles{i,1}, RSArange, 0); %average all the traces corresponding to a given dataset
            datafiles{i,2}=[xaxis;yaxis]; %store data in corresponding cell
        end
    end

    tooth=str2double(datafolder)/1e+6; %extract the tooth spacing for filenaming
    types={'ofc','rfc',exptype,'probe'};
    fileID=zeros(1,4);
    %Store a .bin file for each dataset
    for i=1:2
        filename = [types{i} num2str(tooth,'%0.1f') 'MHz.bin']; %creates filenames
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
    
    for i=3:4
        for j=1:numFrames
            filename = [types{i} num2str(tooth,'%0.1f') 'MHz_' num2str(j,'%02d') '.bin']; %creates filenames
            arrsize  = size(datafiles{i,2}(j,:)); %check for empty files

            if(arrsize(2)==1)
                disp('No data saved, continuing');
                continue;
            end

            disp(['Saving: ' filename])

            fileID(i)=fopen(filename,'W'); %open file to write ('W' is faster apparently than'w')

            %write the various offsets and scaling factors to file 
            fwrite(fileID(i),datafiles{i,3},'float'); 
            %only write y data to file to save space (x can be regenerated)
            fwrite(fileID(i),datafiles{i,2}(j,:),'int16'); 
        end
            fclose(fileID(i)); %close file
    end
end
