% locates calibration tones. might need to play with thresholds in case it
% doesn't work for all data sets, but I think I left pretty large
% tolerances.
% Input: scopeData, LeCroy trace containing timing tones (we use probe trace)
% Input: verbose, boolean controlling how much output the function prints out
% Output: toneTimes, list of indices of the FALLING edges of the square tones

function [toneTimes] = findTones2(scopeData,verbose)

%add option for user to specify whether to display the plots and timing
%information or not, Matlab has no default setting so this is the best I
%can implement 
if(nargin<2)
    verbose = 'false';
end

threshold = 0.05;        % cal. tone must not drop below this value
pulsedur  = 1e-5;        % cal. tone is 1ms long
dt        = scopeData.x(2)-scopeData.x(1); % determine sampling rate of LeCroy
width     = cast(pulsedur/dt,'int32'); % approximate width of cal. tone
minWidth  = 0.75*width;    % tolerances on cal. tone width
maxWidth  = 1.25*width;

toneTimes = [];            % array of cal. tone falling-edge times
counter   = 0;             % measures widths of threshold-exceeding signals

intTime   = 1.5e-4;        % time interval before first tone
baseline  = mean(scopeData.y(1:round(intTime/dt)));
signal    = scopeData.y-baseline;

%If user wants to get more information, verbose flag gives timing, outputs
%location of the adges and shows plots of the signal and location of falling edges
if(strcmp(verbose,'true')) 
    tic

    figure
    hold on
    plot(signal,'k')
end

for j = 1:length(signal)

    if signal(j)>threshold
        counter = counter+1;
    else
        if counter>minWidth && counter<maxWidth
            % I found this extra step of checking the mean value in the
            % intervals immediately preceding and following the detected
            % interval was necessary. Without the rising edges of the probe
            % sweeps each trigger one or two detections.
            avg = mean(signal(j-width:j));
            if avg>mean(signal(j-2*width:j-width))&&...
                    avg>mean(signal(j:j+width))
                toneTimes = [toneTimes;j];
            end
        end
        counter=0;
    end
end

%Plot falling edges of timing tones
if(strcmp(verbose,'true'))
    output = zeros(size(signal));
    output(toneTimes)=max(signal);
    plot(output,'r')
    disp(toneTimes)

    toc
end

end
