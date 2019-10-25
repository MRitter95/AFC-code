function [freqs, avgval] = powermeter(file, numavg)

fID=fopen(file);
if(fID==-1)
    error('unable to open file');
end

data=fscanf(fID, '%g %g', [2 Inf]);

freqs=linspace(0.1,20,200);
avgval=zeros(1, 200);

for i=1:200
    for j=1:numavg
        avgval(i)=avgval(i)+data(2,j+(i-1)*numavg);
    end
    avgval(i)=avgval(i)/numavg;
end