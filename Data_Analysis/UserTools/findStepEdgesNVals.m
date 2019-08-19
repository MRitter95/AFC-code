function [ StepEdges, StepVals ] = findStepEdgesNVals( InputArray )
%UNTITLED2 Summary of this function goes here
%   Align triggers

ArrayDiffs = [1; diff(InputArray); 1];
ArrayDiffs = ArrayDiffs ~=0;
StepEdges = find (ArrayDiffs ~=0);
StepVals = unique(InputArray);

end

