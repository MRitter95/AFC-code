%This helper function reads in the binary files created by combineFiles.m
%and returns the x-y data in a data structure. The stored data for the
%LeCroy waveforms need some processing to turn it back into voltages and
%return time
%Input: inputfile, name of the file to be read
%Input: islecroy, boolean indicating if the base file is a lecroy trace
%Output: data, structure orgranized to return the same format as 
%ReadLeCroyBinaryWaveform. X data is accessed by data.x and so is Y data

function data = readbin(inputfile, islecroy)

%% Basic file checking
fileID=fopen(inputfile);
if(fileID == -1)
    error('unable to open file');
end

%Default case is RSA file
if(nargin<2)
    islecroy = 'false';
    disp('Assuming RSA file');
end

%If LeCroy data, need to convert integers back into real values using scaling factors
if(strcmp(islecroy,'true'))
    %first four values of bin file are the scaling factor
    scale = fread(fileID,4,'single'); 
    hint      = scale(1); %horizontal interval
    hoff      = scale(2); %horizontal offset
    ygain     = scale(3); %vertical gain
    yoff      = scale(4); %vertical offset

    raw       = fread(fileID,'int16'); %amplitude data
    timesteps = 0:length(raw)-1;
    rawx      = timesteps*hint+hoff;
    rawy      = raw*ygain-yoff;
    data.x    = rawx'; %transpose x data to match y data
    data.y    = rawy;
else
    raw=fread(fileID,[2, Inf],'single');
    data.x=raw(1,:);
    data.y=raw(2,:);
end

fclose(fileID);

end
