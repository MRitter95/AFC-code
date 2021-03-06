%The function takes in a list of datafile names (generated by the dir
%command) and performs a runnning average. The function also returns
%some scaling parameters for the LeCroy traces
%Input: data, list of filenames of data to process in a folder (.trc or .txt)
%Input: RSArange, range of the RSA (300 or 600 MHz typically)
%Input: numtoskip, number of traces to skip before starting averaging
%Output: xaxis, time or frequency data from trace (depends on trace type)
%Output: yaxis, averaged amplitudes of traces
%Output: xint, xoff, time step and time offset of LeCroy samples
%Output: ygain, yoff, scale factor and y offset for LeCroy amplitudes

function [xaxis, yaxis, xint, xoff, ygain, yoff] = doAVG(data, RSArange, numtoskip)

numfiles = length(data); %get number of files to process

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

%skipping traces is only potentially necessary for the scope data, when the
%first few traces might correspond to measuring things before the system
%has equilibrated. the RSA traces don't involve the atoms at all, are very
%stable, so there's never a need to skip any traces.
if(strcmp(ext,'.txt'))
    numtoskip= 0;
end
    
    
yaxis = 0;
xaxis = 0;
xint  = 1; %x time step
xoff  = 0; %x offset
ygain = 1; %y gain
yoff  = 0; %y offset

%disp(['Starting averaging, extension detected as: ' ext])

for k=numtoskip+1:numfiles
    %disp(data(k).name) %display current filename
    
    if(strcmp(ext,'.trc')) %LeCroy waveform
        %Extract waveform info and scaling info to convert voltages back to
        %ADC values (more space efficient)
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
    %time axis, unused for storage efficiency (can recreate from xint and xoff)
    xaxis = time'; 
    %convert y values back to int16 to store more efficiently  
    yaxis = int16(((yaxis'/numfiles)+yoff)/ygain); 
elseif(strcmp(ext,'.txt'))
    xaxis = single(linspace(0,RSArange,length(yaxis))); %generates a frequency axis
    yaxis = single(yaxis'/numfiles); %transpose y axis to turn into row vector
end

end 
