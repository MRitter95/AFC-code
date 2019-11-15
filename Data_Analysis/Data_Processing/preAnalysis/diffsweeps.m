%This function generates an array of the variations between two consecutive
%traces

function [truedif, diffs, normvar] = diffsweeps(data, tones)

%% Error checking
% If empty set (i.e. invalid folder or something like that), return default values
if(isempty(data))
    disp('no data of this type, returning default values')
    diffs=0;
    truedif=0;
    normvar=0;
    return 
end

start=1;
%% Initialization
numfiles=length(data);
% array to store the variations between two traces
diffs=zeros(1,numfiles); 
% array to store the net variations (taking into account the 'natural'
% fluctuations)
truedif=zeros(1,numfiles); 
% array to hold the intrinsic variance of the dataset
normvar=zeros(1,numfiles);

%Get span of both sweeps
span1=tones(5)-tones(2);
span2=tones(9)-tones(6);
    
%% Calculation
for i=1:numfiles-1
    current=ReadLeCroyBinaryWaveform(data(i).name);
    firstC=current.y(tones(2):tones(5));
    secondC=current.y(tones(6):tones(9)+(span1-span2)); %adjust small variations (order 1 differences in span)
    maxval=max([max(firstC) max(secondC)]);
    firstC=firstC/maxval;
    secondC=secondC/maxval;
    
    truedif(i)=sum((firstC-secondC).^2)...
        /length(firstC);
    stopval=500; %arbitrary length of array to sample variance
    normvar(i)=sum(...
        (current.y(start+1:stopval+1)-current.y(start:stopval)).^2)...
        /stopval;
    diffs(i)=truedif(i)-normvar(i);
end

end