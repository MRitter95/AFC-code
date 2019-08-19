%This reads Lecroy file in .dat format
% The base file names and the trace prefixes are listed.
% Trace prefixes are added to the base filenames
% The outer loop is over the base file names to look at.
% the inner loop is over the traces to look at.
% NumtoAvg is used to reduce the number of data points by grouping and
% averaging them.


clc
close all
clear all
format short
mfilename
path = 'C:\Users\Lab\Desktop\Data\2017-03\2017-03-03\'
%tracenames=strvcat( 'C2', 'C3', 'C4');
tracenames=strvcat( 'C1');
[numoftraces,tracelen] = size(tracenames);

filename=strvcat(...    % basefile names
    '2017_02_0900000.trc',...
    '2017_02_0900002.trc',...
    '2017_02_0900004.trc',...
    );
[numoffiles,filelen] = size(filename);
trigdates = [];
trigtimes = [];
for k = 1  : numoffiles  % not needed in this case but it allows looking at multiple files
%    figure(k);
    for tnum = 1 : numoftraces
        currentfilename = [path tracenames(tnum,:) filename(k,:)]
        %currentfilename = [path  filename(k,:)]
        %fileID = fopen(currentfilename,'r')
        wave=ReadLeCroyBinaryWaveform(currentfilename);
        disp(sprintf('Filename is %s', currentfilename));
        %eval(currentfilename);
%         rawdat = fscanf(fileID,'%f %f');
%         [r, c] = size(rawdat)
%         rawdatby2 = reshape(rawdat, 2, r/2)';
%         clear rawdat;
%         time = rawdatby2(:,1);
%         sig = rawdatby2(:,2);
        time = wave.x;
        sig = wave.y;
        trigtimes = [trigtimes, datenum(wave.info.TRIGGER_TIME)];
        

%        clear rawdatby2;
        
        NumtoAvg = 10;    %*********************
        timeAvg = avgByNs(time,NumtoAvg);
        sigAvg = avgByNs(sig,NumtoAvg);
        subplot(numoftraces,1,tnum);
        plot(timeAvg, sigAvg+(k-1)*.2)
        hold on
     
        if tnum == 1
            title(currentfilename);
        end
        drawnow
        
%         if tnum == 1
%             timeAvg1 = timeAvg;
%             sigAvg1 = sigAvg;
%             for j = 1:length(timeAvg1)
%                 if timeAvg1(j) <= 0 || timeAvg1(j) >= 0.499
%                     sigAvg1(j) = 0;
%                 end
%             end
%             sigPeak(k) = max(sigAvg1);
%         end
%         
%         if tnum == 2
%             timeAvg2 = timeAvg;
%             sigAvg2 = sigAvg;
%             g = 1;
%             for j = 1:length(timeAvg2)
%                 if timeAvg2(j) <= -0.1
%                     sigAvg2a(g) = sigAvg2(j);
%                     g = g+1;
%                 end
%             end
%             sigBurn(k) = mean(sigAvg2a);
%         end
        
        
         
    end
    
end
trigtimes = trigtimes - trigtimes(1);
trigtimes = trigtimes*24*3600;
figure(k+1);
plot(trigtimes)

% figure
% str = {'t_1';'t_2';'t_3';'t_4';'t_5';'t_6';'t_7'};
% plot(sigBurn,'x')
% set(gca, 'XTickLabel',str, 'XTick',1:numel(str))
% xlabel('Half-wave plate setting (degrees)')
% ylabel('Burn beam signal (V)')
% title('Burn unblocked at t_1 and blocked at t_5')
% % ylim([0 1.4])
% figure
% plot(sigPeak,'o')
% set(gca, 'XTickLabel',str, 'XTick',1:numel(str))
% xlabel('Half-wave plate setting (degrees)')
% ylabel('Peak probe beam signal (V)')
% ylim([0 0.115])
% title('Burn unblocked at t_1 and blocked at t_5')
% 
% 
