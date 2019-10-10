%This function generates an array of the variations between two consecutive
%traces

function [truedif, diffs, normvar] = takeDiff(data, start, stop)

if(isempty(data))
    disp('no data of this type, returning default values')
    diffs=0;
    truedif=0;
    normvar=0;
    return 
end

size=ReadLeCroyBinaryWaveform(data(1).name); %get size of data files
if(nargin<2)
    start=1;
    stop=length(size.x);
end
if(nargin<3)
    stop=length(size.x);
end

numfiles=length(data);
diffs=zeros(1,numfiles-1);
truedif=zeros(1,numfiles-1);
normvar=zeros(1,numfiles-1);

for i=1:numfiles-1
    current=ReadLeCroyBinaryWaveform(data(i).name);
    next=ReadLeCroyBinaryWaveform(data(i+1).name);
    truedif(i)=sum((next.y(start:stop)-current.y(start:stop)).^2)/length(current.x(start:stop));
    stopval=500;
    normvar(i)=sum((current.y(2:stopval+1)-current.y(1:stopval)).^2)/stopval;
    diffs(i)=truedif(i)-normvar(i);
end

end