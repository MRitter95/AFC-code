%This function generates an array of the variations between two consecutive
%traces

function [truedif, diffs, normvar] = takeDiff(data)

if(isempty(data))
    disp('no data of this type, returning default values')
    diffs=0;
    truedif=0;
    normvar=0;
    return 
end

numfiles=length(data);
diffs=zeros(1,numfiles-1);
truedif=zeros(1,numfiles-1);
normvar=zeros(1,numfiles-1);

for i=1:numfiles-1
    current=ReadLeCroyBinaryWaveform(data(i).name);
    next=ReadLeCroyBinaryWaveform(data(i+1).name);
    truedif(i)=sum((next.y-current.y).^2)/length(current.x);
    stop=500;
    normvar(i)=sum((current.y(2:stop+1)-current.y(1:stop)).^2)/stop;
    diffs(i)=truedif(i)-normvar(i);
end

end
    