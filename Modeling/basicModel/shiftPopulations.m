%%
% this segment will take the list of all affected frequencies (this could
% come from the last segment, or it could be produced by burning at
% multiple frequencies) and rearranges all populations.

% % list of all affected frequencies (i.e., all unique elements of DETUNINGS)
% peaks= unique(detunings);

f= linspace(-1000,1000,2001);

% populations of absorbers on each transition for each affected freq.
% all ground states start with 1/3 of the possible population.
allAbsorbers= (1/3)*ones(length(f),9);

for j= 1:size(detunings,1)      % for each class
    for k=1:size(detunings,2)   % for each transition of that class        
        
        index= find(f==detunings(j,k));
        
        % my slick move to identify elements in the diagonal blocks: takes
        % value 1 or 0 depending whether the entry corresponds to a
        % transparency peak or anti-peak.
        cleared= abs(floor((j-1)/3)-floor((k-1)/3))<1;
        
        if cleared
            allAbsorbers(index,k)= 0;
        else
            allAbsorbers(index,k)= allAbsorbers(index,k)+1/6;
        end
    end
end

figure
plot(f/10,sum(allAbsorbers,2))