% This reads Lecroy file in .trc format
% The base file names and the trace prefixes are listed.
% Trace prefixes are added to the base filenames
% The outer loop is over the base file names to look at.
% The inner loop is over the channel traces to look at.
% NumtoAvg is used to reduce the number of data points by grouping and
% averaging them.


clc
close all
clear all
format long
warning off
path = 'C:\Users\Lab\Desktop\Data\2016-11\2016-11-18\'  %PC
%path = '/Users/migdall/Documents/MATLAB/2016-07-25/'   %Mac
%tracenames=strvcat( 'C2', 'C3', 'C4');
tracenames=strvcat( 'C2');
[numoftraces,tracelen] = size(tracenames);

% filename=strvcat(...    % basefile names
%     '2016_07_1300000.trc',...
%     '2016_07_1300002.trc',...
%     '2016_07_1300009.trc'...
%     );
% [numoffiles,filelen] = size(filename);

% firstfile = '2016_10_2800000.trc';
% firstfile = '2016_11_0200000.trc';
firstfile = '2016_11_1800007.trc';

filenum = 10;
basefilename = [firstfile(1,1:end-7) sprintf('%.3d',filenum) '.trc'];
numoffiles = 5;

nsub1 = 4;
nsub2 = 3;
% timeAvgAll = [];
% sigAvgAll = [];
offsetbtwfiles(1) = 0;



for k = 1 : numoffiles  % not needed in this case but it allows looking at multiple files
    %     figure(k);
    basefilename = [firstfile(1,1:end-7) sprintf('%.3d', k-1+filenum) '.trc'];
    
    for tnum = 1 : numoftraces
        
        currentfilename = [path tracenames(tnum,:) basefilename];
        wave=ReadLeCroyBinaryWaveform1(currentfilename);
        disp(sprintf('Filename is %s', currentfilename));
        
        time = wave.x;
        sig = wave.y;
        
        [npts, numofseg] = size(time);
        sig(:,k:numofseg+k-1) = sig(:,:);
        sig(:,numofseg+1:end) = [];
        
        blankfind = regexp(wave.info.TRIGGER_TIME,': ');
        if ~isempty(blankfind)
            wave.info.TRIGGER_TIME(blankfind+1) = '0';
        end
        %now look for minute blank and replace. Maybe needs a third for
        %the hour
        blankfind = regexp(wave.info.TRIGGER_TIME,':%c: ');
        if ~isempty(blankfind)
            wave.info.TRIGGER_TIME(blankfind+1) = '0';
        end
        
        wave.info.TRIGGER_TIME;
        starttracedays = datenum(wave.info.TRIGGER_TIME,'dd.mm.yyyy, HH:MM:SS'); % days since Jan 1, 0000
        starttraceseconds = (starttracedays-floor(starttracedays))*24*3600;  % seconds since midnight
        if k==1
            starttraceseconds0 = starttraceseconds;
        end
        
        %         clear time
        %         clear sig
        
        filestartoffset = starttraceseconds-starttraceseconds0;
        triggers = wave.trigger_time + wave.trigger_offset + starttraceseconds-starttraceseconds0; 
        
        
        startpeak = 1; % start from this peak after each new burn (to avoid saturated peaks)
        numofprobes = 25; % number of probes after each new burn
        offsetbtwseg(1:numofprobes) = 0;
        segcol = 1;
        
        while segcol <= numofseg
            segcol;
            
%             pause
            
            if mod(segcol,numofprobes) == 1 %&& segcol > numofprobes
                segcol = segcol + startpeak - 1;
            end
            
            segcol;
            NumtoAvg = 100;    %*********************
            timeAvg(:,segcol) = avgByNs(time(1:end,segcol)+filestartoffset,NumtoAvg);
            sigAvg(:,segcol) = avgByNs(sig(1:end,segcol),NumtoAvg);
%             h1 = figure(1);
%            % subplot(nsub1,1,1)
%              plot(timeAvg, sigAvg)     %*********
%             %         timeAvgAll = [timeAvgAll timeAvg]; % this appends all files into one long time series
%             %         sigAvgAll = [sigAvgAll sigAvg];
%              hold on                   %**********
%             title([basefilename ' ' wave.info.TRIGGER_TIME ' #ptsAvg= ' num2str(NumtoAvg) ' ' mfilename()],'interpreter', 'none');
%           %  drawnow
            
             %             pause
             segcol = segcol + 1;
           
        end
        
        %         segcol = segcol - 1;
        %         lastpoint = maxjoined(segcol);
        
    end
    segcol = 1;
    while segcol <= numofseg
        plot(timeAvg(:,segcol),sigAvg(:,segcol));
        segcol = segcol + 1;
        hold on
    end
    
end

