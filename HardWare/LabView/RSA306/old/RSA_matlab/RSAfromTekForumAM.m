clear all
close all
clc

a = instrfind;
delete(a)
clear a

visa_brand = 'tek';
visa_address_rsa = 'GPIB8::1::INSTR';
buffer = 1000 * 1024;
rsa = visa(visa_brand, visa_address_rsa, 'InputBufferSize', buffer, ...
      'OutputBufferSize', buffer);
fopen(rsa);
%get(rsa)
dataAccum = [];
tic
%pts = [801 1601 2401 3201 4001 6401 8001 10401] %these should work
pts = [801  2401  4001  8001 10401 16001 32001 64001]; % but only these actually work
whichpt = 2;
   fwrite(rsa, ['SENSE:SPECTRUM:POINTS:COUNT P', num2str(pts(whichpt))]);
   query(rsa, 'SENSE:SPECTRUM:POINTS:COUNT?')

for j =1:10
     fwrite(rsa, 'FETCH:SPECTRUM:TRACE1?');
    data = binblockread(rsa,'float');
%    datraw = query(rsa, 'FETCH:SPECTRUM:TRACE1?')
    
 fwrite(rsa, 'SENSe:IQVTime:MAXTracepoints TENK');%%%%%%%%%%%%%%%%%%%
query(rsa, 'SENSe:IQVTime:MAXTracepoints?')%%%%%%%%%%%%%%%%%%%

    fwrite(rsa,'FETCH:IQVTime:I?')
    dataIbin = binblockread(rsa,'float');
 %   datIraw = query(rsa,'FETCH:IQVTime:I?') 
    fwrite(rsa,'FETCH:IQVTime:Q?')
    dataQbin = binblockread(rsa,'float');
    length(dataIbin)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        subplot(2,1,2)
        hold off
        plot(dataIbin);
        hold on
        plot(dataQbin);
% dataI = (query(rsa,'READ:IQVTime:I?'));%%%%%%%%%%%%%%%%
% length(dataI)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Start_Freq = str2double(query(rsa, 'SENSE:SPECTRUM:FREQUENCY:START?'));
    Start_Freq = Start_Freq./1e6;
    Stop_Freq = str2double(query(rsa, 'SENSE:SPECTRUM:FREQUENCY:STOP?'));
    Stop_Freq = Stop_Freq./1e6;
    Freq = linspace(Start_Freq, Stop_Freq, pts(whichpt))';
    
    if j == 1
        dataAccum = data;
    else
        dataAccum = dataAccum*(j-1)/j + data/j;
    end
    subplot(2,1,1)
    hold off
    plot(Freq, data)
    hold on
    plot(Freq, dataAccum,'-r')
    xlim([Start_Freq Stop_Freq]);
    %ylim([-100 -30]);
    ylabel('Power (dBm)'); xlabel('Frequency (MHz)');
    title(sprintf('Accumulated %d traces', j));
    drawnow
    shg

end
toc
fclose(rsa);
delete(rsa);
clear rsa;