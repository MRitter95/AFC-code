%This function generates an array of the variations between two consecutive
%traces

function [truedif, diff_from_last, diffs, normvar] = takeDiff(data, start, stop)

%% Error checking
% If empty set (i.e. invalid folder or something like that), return default values
if(isempty(data))
    disp('no data of this type, returning default values')
    diffs=0;
    truedif=0;
    normvar=0;
    return 
end

%% Get start and stop indices of interest
size=ReadLeCroyBinaryWaveform(data(1).name); %get size of data files
%If user doesn't specify range, use entire data set
if(nargin<2)
    start=1;
    stop=length(size.x);
end
if(nargin<3)
    stop=length(size.x);
end

%% Initialization
numfiles=length(data);
% array to store the variations between two traces
diffs=zeros(1,numfiles-1); 
diff_from_last=zeros(1, numfiles-1);
% array to store the net variations (taking into account the 'natural'
% fluctuations)
truedif=zeros(1,numfiles-1); 
% array to hold the intrinsic variance of the dataset
normvar=zeros(1,numfiles-1);

%% Calculation
for i=1:numfiles-1
    current=ReadLeCroyBinaryWaveform(data(i).name);
    next=ReadLeCroyBinaryWaveform(data(i+1).name);
    last=ReadLeCroyBinaryWaveform(data(end).name);
    truedif(i)=sum((next.y(start:stop)-current.y(start:stop)).^2)...
        /length(current.x(start:stop));
    diff_from_last(i)=sum((last.y(start:stop)-current.y(start:stop)).^2)...
        /length(current.x(start:stop));
    stopval=500; %arbitrary length of array to sample variance
    normvar(i)=sum(...
        (current.y(start+1:stopval+1)-current.y(start:stopval)).^2)...
        /stopval;
    diffs(i)=truedif(i)-normvar(i);
end

end