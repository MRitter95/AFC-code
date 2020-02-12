%while running COMBINEFILES_TIMELAPSE.M, it was found that the code can run
%into errors:
%
% Caught "std::exception" Exception message is:
% Message Catalog MATLAB:FileIO was not loaded from the file. Please check file location, format or contents
%
% it seems this can happen if too many file handles are open. I don't
% understand how that could happen, and why it doesn't happen more
% consistently, but it's helpful to save progress and not have to start
% COMBINEFILES from the start; even more helpful not to have to start
% COMBINEFILES_TIMELAPSE from the start.

% this script shows how much progress COMBINEFILES_TIMELAPSE has made, so
% that the code can be temporarily modified to skip over the frequencies
% that have already been completed.


freqs= linspace(0.1,20,200);
progress= zeros(4,200);

for j=1:200
    progress(1,j)= length(dir(fullfile(pwd,['echo' num2str(freqs(j),'%0.1f') '*.bin'])));
    progress(2,j)= length(dir(fullfile(pwd,['probe' num2str(freqs(j),'%0.1f') '*.bin'])));
    progress(3,j)= length(dir(fullfile(pwd,['rfc' num2str(freqs(j),'%0.1f') '*.bin'])));
    progress(4,j)= length(dir(fullfile(pwd,['ofc' num2str(freqs(j),'%0.1f') '*.bin'])));
end

plot(freqs,progress(1,:),'-ok',freqs,progress(2,:)+1,'-ob',...
    freqs,progress(3,:)+2,'-or',freqs,progress(4,:)+3,'-og');
