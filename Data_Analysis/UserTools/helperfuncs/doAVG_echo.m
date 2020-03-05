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

function [xaxis,normAxis,echoAxis,xInt,xOff,normGain,normOff,...
    echoGain,echoOff] = doAVG_echo(normDat,echoDat,numtoskip)

numfiles = length(echoDat); %get number of files to process

if(isempty(echoDat))
    disp('no data of this type, returning default values')
    normAxis = 0;
    xaxis = 0;
    xInt  = 1; %x time step
    xOff  = 0; %x offset
    normGain = 1; %y gain
    normOff  = 0; %y offset
    return 
end

normAxis = 0;
xaxis = 0;
xInt  = 1; %x time step
xOff  = 0; %x offset
normGain = 1; %y gain
normOff  = 0; %y offset

% the new part. we find the peak in each probe data set.
offsetNorm= [];
offsetEcho= [];
peaks= zeros(numfiles-numtoskip,1);
for k=numtoskip+1:numfiles
    [wave,~,~,...
        normGain,normOff]= ReadLeCroyBinaryWaveformExtra(normDat(k).name);
    
    [pk,loc] = findpeaks(wave.y,'MinPeakDistance',1e-5);
    blah= sortrows([pk,loc],'descend');
    
    peaks(k)= blah(1,2);
    offsetNorm= [offsetNorm,wave.y];
    
    [wave,xInt,xOff,...
        echoGain,echoOff]= ReadLeCroyBinaryWaveformExtra(echoDat(k).name);
    offsetEcho= [offsetEcho,wave.y];
    
    time= wave.x;
end

% now instead of simply averaging, we first align all the traces in time.
alignedNorm= [zeros( max(peaks)-min(peaks),numfiles-numtoskip );...
    zeros(size(offsetNorm))];
alignedEcho= alignedNorm;

for k=numtoskip+1:numfiles
    baselineNorm= mean(offsetNorm(:,k));
    alignedNorm(:,k)= [baselineNorm*ones( max(peaks)-peaks(k),1 );...
        offsetNorm(:,k)];
    
    baselineEcho= mean(offsetEcho(:,k));
    alignedEcho(:,k)= [baselineEcho*ones( max(peaks)-peaks(k),1 );...
        offsetNorm(:,k)];
end

normAxis= mean(offsetNorm,2);
echoAxis= mean(offsetEcho,2);

% we have to pad the x axis as well.
xaxis= [time',linspace(time(end),...
    time(end)+(max(peaks)-min(peaks))*(time(end)-time(end-1)),...
    max(peaks)-min(peaks))];

%convert y values back to int16 to store more efficiently  
normAxis= int16((normAxis'+normOff)/normGain);
echoAxis= int16((echoAxis'+echoOff)/echoGain);
 
