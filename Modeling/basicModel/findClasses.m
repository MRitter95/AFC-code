function allFreqs = findClasses(teeth)
%input TEETH is an array of burn frequencies

%output DETUNINGS
% this segment of the script finds the frequencies affected by burning at a
% single frequency.

% we'll list the transitions in decreasing order of energy. ground
% (excited) states have to be listed in descending (ascending) order to do
% this. we multiply all energies by 10 so that we work at 0.1 precision and
% deal with integers to avoid rounding errors, since we'll need to compare
% numbers.

g= ones(3,1)*[-275, -102, 0];
e= [94; 46; 0]*ones(1,3);

levels= reshape(e-g,[9,1]);

% the elements of TRANSITIONS correspond to classes A-I. from this vector,
% we can construct a table of all absorption freqs. for each class.

detunings= zeros(9,9);

for j=1:9
    detunings(j,:)= levels'-levels(j);
end

% in DETUNINGS:
% the elements are the detunings for the different transitions associated
% with atom classes addressed by a burn at 0 MHz. the rows correspond to
% atom classes A-I and the columns to transitions a-i.
% each set of three columns corresponds to transitions starting from the
% same ground state: the first 3 columns give energies for transitions
% starting from (g,5/2), the next set from (g,3/2), the last from (g,1/2).
% classes A,B,C (first three rows) are defined by transitions from (g,5/2);
% D,E,F by (g,3/2); G,H,I (g,1/2). therefore, burning at zero detuning will
% give transparencies at the values in 3x3 blocks along the diagonal and
% increased absorption at the other values.

% now we take this result and use it to find all frequencies affected by
% the multiple teeth.
allFreqs= zeros(9*length(teeth),9);
for j=1:length(teeth)
    allFreqs(1+(j-1)*9:j*9,:)= detunings+teeth(j);
end
end
    