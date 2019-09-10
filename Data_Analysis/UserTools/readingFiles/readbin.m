%This helper function reads in the binary files created by combineFiles.m
%and returns the x-y data in a data structure. The stored data for the
%LeCroy waveforms need some processing to turn it back into voltages and
%return time

function data = readbin(inputfile, islecroy)
fileID=fopen(inputfile);
if(fileID==-1)
    error('unable to open file');
end
if(nargin<2)
    islecroy='false';
    disp('Assuming RSA file');
end
if(strcmp(islecroy,'true'))
    scale=fread(fileID,4,'single'); %first four values of bin file are the scaling factors
    raw=fread(fileID,'int16'); %amplitude data
    hint=scale(1); %horizontal interval
    hoff=scale(2); %horizontal offset
    ygain=scale(3); %vertical gain
    yoff=scale(4); %vertical offset
    timesteps=0:length(raw)-1;
    rawx=timesteps*hint+hoff;
    rawy=raw*ygain-yoff;
    data.x=rawx';
    data.y=rawy;
else
    raw=fread(fileID,[2, Inf],'single');
    data.x=raw(1,:);
    data.y=raw(2,:);
end
fclose(fileID);