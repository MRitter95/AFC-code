%The function takes in a list of datafile names (generated by the dir
%command) and performs a runnning average, returning the averaged values in
%a row vector

function [xaxis, yaxis, xint, xoff, ygain, yoff] = doAVG(data)
numfiles=length(data); %get number of files to process
if(isempty(data))
    disp('no data of this type, returning default values')
    yaxis = 0;
    xaxis = 0;
    xint  = 1; %x time step
    xoff  = 0; %x offset
    ygain = 1; %y gain
    yoff  = 0; %y offset
    return 
end
[~, ~, ext] = fileparts(data(1).name); %get extension to choose which method to use

yaxis = 0;
xaxis = 0;
xint  = 1; %x time step
xoff  = 0; %x offset
ygain = 1; %y gain
yoff  = 0; %y offset

%disp(['Starting averaging, extension detected as: ' ext])

for k=1:numfiles
    %disp(data(k).name) %display current filename
    
    if(strcmp(ext,'.trc')) %LeCroy waveform
        %Extract waveform info and scaling info to convert voltages back to
        %ADC values (more space efficient). Modified
        %ReadLeCroyBinaryWaveform is in the includes folder of data
        [wave, xint, xoff, ygain, yoff] = ReadLeCroyBinaryWaveformExtra(data(k).name);
        time = wave.x;
        amps = wave.y;
    elseif(strcmp(ext,'.txt')) %RSA txt file
        file = fopen(data(k).name);
        amps = fscanf(file,'%f');
        fclose(file);
    end 
    
    yaxis = yaxis+amps; %accumulate y values for averaging
end
%select the correct xaxis (time for LeCroy, frequency for RSA)
if(strcmp(ext,'.trc'))
    xaxis=time'; %time axis, unused for storage efficiency (can recreate from xint and xoff)
    yaxis=int16(((yaxis'/numfiles)+yoff)/ygain); %convert y values back to int16 to store more efficiently 
elseif(strcmp(ext,'.txt'))
    xaxis=single(linspace(0,300,length(yaxis))); %generates a frequency axis (values are hard coded to 0 and 300 MHz)
    yaxis=single(yaxis'/numfiles); %transpose y axis to turn into row vector
end
    