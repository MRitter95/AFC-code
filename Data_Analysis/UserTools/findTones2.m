% locates calibration tones. might need to play with thresholds in case it
% doesn't work for all data sets, but I think I left pretty large
% tolerances.

function [toneTimes] = findTones2(scopeData,verbose)

%add option for user to specify whether to display the plots and timing
%information or not, Matlab has no default setting so this is the best I
%can implement 
if(nargin<2)
    verbose='false';
end
if(strcmp(verbose,'true')) 
    tic

    figure
    hold on
    plot(scopeData.y,'k')
end

threshold= 1e-3;        % cal. tone must not drop below this value
pulsedur=1e-3;          % cal. tone is 1ms long
dt=scopeData.x(2)-scopeData.x(1); % determine sampling rate of LeCroy
width= cast(pulsedur/dt,'int32'); % approximate width of cal. tone
minWidth= 0.75*width;  % tolerances on cal. tone width
maxWidth= 1.25*width;

toneTimes= [];          % array of cal. tone falling-edge times
counter= 0;             % measures widths of threshold-exceeding signals

for j=1:length(scopeData.y)
    if scopeData.y(j)>threshold
        counter= counter+1;
    else
        if counter>minWidth && counter<maxWidth
            % I found this extra step of checking the mean value in the
            % intervals immediately preceding and following the detected
            % interval was necessary. Without the rising edges of the probe
            % sweeps each trigger one or two detections.
            avg= mean(scopeData.y(j-width:j));
            if avg>mean(scopeData.y(j-2*width:j-width))&&...
                    avg>mean(scopeData.y(j:j+width))
                toneTimes= [toneTimes;j];
            end
        end
        counter=0;
    end
end

if(strcmp(verbose,'true'))
    output= zeros(size(scopeData.y));
    output(toneTimes)=1;
    plot(output,'r')
    disp(toneTimes)

    toc
end