%This script was used to average powermeter readings
% Input: file, txt file containing all the readings
% Input: numavg, number of readings per frequency setting
% Output: freqs, array of modulation frequencies used
% Output: avgval, array of the averaged values at each frequency

function [freqs, avgval] = powermeter(file, numavg)

fID = fopen(file);

%Check file exists
if(fID==-1)
    error('unable to open file');
end

%Read in data (data is organized by numavg readings per
%frequency for a total of 200*numavg points)
data   = fscanf(fID, '%g %g', [2 Inf]);

freqs  = linspace(0.1,20,200);
avgval = zeros(1, 200);

for i = 1:200
    for j = 1:numavg
        avgval(i) = avgval(i)+data(2,j+(i-1)*numavg);
    end
    avgval(i) = avgval(i)/numavg;
end

end
