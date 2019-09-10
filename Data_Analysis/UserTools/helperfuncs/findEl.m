function [index] = findEl (array, val)

dd=array(2)-array(1);
start=array(1);
index=round((val-start)/dd)+1;