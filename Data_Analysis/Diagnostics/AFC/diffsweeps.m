%This function generates an array of the variations between two consecutive
%sweeps by summing the square of the difference between the two sweeps
%Input: data is a list of .TRC file names at a given modulation frequency
%Input: tones contains the location of the 100 MHz tones in the probe signal, 
%expects double sweep config
%Output: truedif is an array containing the net variation
%Output: diffs is an array containing the background subtracted variation
%Output: normvar is an array containing a sample of the natural variation

function [truedif, diffs, normvar] = diffsweeps(data, tones)

%% Error checking
% If empty set (i.e. invalid folder or something like that), return default values
if(isempty(data))
    disp('no data of this type, returning default values')
    diffs   = 0;
    truedif = 0;
    normvar = 0;
    return 
end

%% Initialization
numfiles=length(data);
% array to store the variations between two sweeps
diffs   = zeros(1,numfiles); 
% array to store the net variations (taking into account the 'natural'
% fluctuations)
truedif = zeros(1,numfiles); 
% array to hold the intrinsic variance of the dataset
normvar = zeros(1,numfiles);

%Get span of both sweeps
span1 = tones(5)-tones(2);
span2 = tones(9)-tones(6);

%Region to sample intrinsic variance of signal (numbers are arbitrary)
start   = 1;
stopval = 500;

%% Calculation
for i=1:numfiles-1
    %Read in file and select both sweeps from data
    current = ReadLeCroyBinaryWaveform(data(i).name);
    firstC  = current.y(tones(2):tones(5));
    secondC = current.y(tones(6):tones(9)+(span1-span2));

    %Normalize the traces by max of either sweep
    maxval  = max([max(firstC) max(secondC)]);
    firstC  = firstC/maxval;
    secondC = secondC/maxval;
    
    normvar(i) = sum(...
        (current.y(start+1:stopval+1)-current.y(start:stopval)).^2)...
        /stopval;
    truedif(i) = sum((firstC-secondC).^2)/length(firstC);
    diffs(i)   = truedif(i)-normvar(i);
end

end
