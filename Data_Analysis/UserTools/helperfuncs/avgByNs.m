%avgByNs groups 1D array by Ns and averages those Ns. Result is an array
%that is N times shorter
%Input: input_array array to be shortened
%Input: N2groupAndAvg, number of points to average

function [ output_array ] = avgByNs( input_array, N2groupAndAvg )

%   Detailed explanation goes here
[r, c] = size(input_array);
% r
% c
% floor(r/N)
% floor(r/N)*N
% disp('hey')
% size(input_array)

if N2groupAndAvg>1
    temp = input_array(1:floor(r/N2groupAndAvg)*N2groupAndAvg,:);
    temp2 = mean(reshape(temp,  N2groupAndAvg, floor(r/N2groupAndAvg)));
    output_array = temp2';
else
    output_array = input_array;
end

end

