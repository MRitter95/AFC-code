% too slow.

% calibration tone locator

% calculates a normalized correlation between signal and a square pulse
% slightly narrower than the calibration tone.

% takes input SCOPEDATA, 1-D array of scope data from probe (CH3)
% (x data isn't necessary, since we don't need the actual time scale here).

% gets TONETIMES, 1-D array of falling-edge times of all calibration tones.
tic
figure
hold on
plot(scopeData*1e4,'b')

% how wide are the calibration tones? WIDTH should be a little smaller.
width= 1.9e4;

% here assuming scopeData is a vertical array
correlation= zeros(size(scopeData)-[width,0]);
digCorr= correlation;

heightThreshold= 100;
widthThresholdLow= 1e4;
widthThresholdHigh= 4e4;

% COUNTER will keep track of the widths of peaks
toneTimes= [];
counter= 0;

for j= 1:length(scopeData)-width+1
    if j==1
        interval= scopeData(1:width);
        total= sum(interval);
        M= max(interval);
    else
%         interval= [interval(2:end);scopeData(j+width-1)];
        total= total-scopeData(j-1)+scopeData(j+width-1);
        M= max(scopeData(j-1:j+width-1));
    end
    %correlation(j)= sum(interval/max(interval));
    correlation(j)= total/M;
    if correlation(j)>heightThreshold
        digCorr(j)= 1;
        counter= counter+1;
    else
        if counter>widthThresholdLow && counter<widthThresholdHigh
                toneTimes= [toneTimes;j];
        end
        counter=0;
    end
end

plot(correlation,'k')
plot(digCorr*1e4,'g')
output= zeros(size(scopeData));
for j=1:length(toneTimes)
    output(toneTimes(j))=1;
end
plot(output*1e4,'r')
toc