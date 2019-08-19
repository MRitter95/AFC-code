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
   SpecPts = query(rsa, 'SENSE:SPECTRUM:POINTS:COUNT?');
   fwrite(rsa, 'SENSe:IQVTime:MAXTracepoints NEV');%%%%%%%%%%%%%%%%%%%
   fwrite(rsa, 'SENSe:ANALysis:LENGth 4ms'); 
   AnalLength = query(rsa, 'SENSe:ANALysis:LENGth:ACT?'); 
   fprintf('Num of Spectrum Pts= %s  Analysis Length(s) %s',SpecPts,AnalLength);
   fwrite(rsa, 'SENSe:IQVTime:MAXTracepoints ONEK');%%%%%%%%%%%%%%%%%%%
   query(rsa, 'SENSe:IQVTime:MAXTracepoints?')%%%%%%%%%%%%%%%%%%%
   %fprintf('\nNum of Spectrum Pts= %f  \nAnalysis Length(s) %f',SpecPts,AnalLength);
datamat = [];
for j =1:50
    j
    fwrite(rsa, 'FETCH:SPECTRUM:TRACE1?');
    [data,datacount] = binblockread(rsa,'float');
    %datraw = query(rsa, 'FETCH:SPECTRUM:TRACE1?');
    if j == 1
        Start_Freq = str2double(query(rsa, 'SENSE:SPECTRUM:FREQUENCY:START?'));
        Start_Freq = Start_Freq./1e6;
        Stop_Freq = str2double(query(rsa, 'SENSE:SPECTRUM:FREQUENCY:STOP?'));
        Stop_Freq = Stop_Freq./1e6;
        Freq = linspace(Start_Freq, Stop_Freq, pts(whichpt))';
    
        dataAccum = data;
    else
        dataAccum = dataAccum*(j-1)/j + data/j;
    end
    datamat = [datamat,data];
    hold off
    plot(Freq, data)
    hold on
    plot(Freq, dataAccum,'-r')
    xlim([Start_Freq Stop_Freq]);
    ylim([-100 0]);
    ylabel('Power (dBm)'); xlabel('Frequency (MHz)');
    title(sprintf('Accumulated %d spectra', j));
    drawnow
    shg

end
toc
fclose(rsa);
delete(rsa);
clear rsa;