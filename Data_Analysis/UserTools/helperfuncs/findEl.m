% Quick and dirty function to find the element in an array. If the element
% doesn't exist, the function returns the closest index in the array.
% Written because Matlab's 'find' function wasn't working well and this
% does. Takes in an array and a value to find in it and does basic out of
% range error checking on the index

function [index] = findEl (array, val)

dd=array(2)-array(1); %step size in array
start=array(1);
index=round((val-start)/dd)+1;
if (index > length(array) || index <= 0)
    error('index is out of range, check value is contained in array')
end
    