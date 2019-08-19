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
dataAccum = [];
tic
for j =1:1
%     fwrite(rsa, 'SENSE:SPECTRUM:POINTS:COUNT P801');
%     fwrite(rsa, 'FETCH:SPECTRUM:TRACE1?');
%     data = binblockread(rsa,'float');
    fwrite(rsa,'SENSE:IQVTIME:MAXTRACEPOINTS ONEK')  

    FreqSpan = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:SPAN?'))
    FreqStart = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:START?'))  
    FreqStop = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:STOP?'))  
    FreqCenter = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:CENTER?'))  

    Maxi = (query(rsa,'READ:IQVTime:MAXimum?')) 

    MaxT = (query(rsa,'SENSE:IQVTIME:MAXTRACEPOINTS?')) 
     data = (query(rsa,'READ:IQVTime:I?'))
     
     d1 = str2num(data(1))
     d2 = str2num(data(2))
     newdata = data(str2num(data(2))+2:end);
     newdatauint = int32(newdata);
%     floatdata = typecast (int32(newdata),'single');
     floatdata = typecast (int32(newdata),'single');
     floatdataswapped = swapbytes(floatdata);
       %   FreqCent = str2double(query(rsa,'SENSE:?IQVTIME:?FREQUENCY:?CENTER?'));

% %     data = binblockread(rsa,'float');
% % 
% %     Start_Freq = str2double(query(rsa, 'SENSE:SPECTRUM:FREQUENCY:START?'));
% %     Start_Freq = Start_Freq./1e6;
% %     Stop_Freq = str2double(query(rsa, 'SENSE:SPECTRUM:FREQUENCY:STOP?'));
% %     Stop_Freq = Stop_Freq./1e6;
% %     Freq = linspace(Start_Freq, Stop_Freq, 801)';

%     fwrite(rsa, 'SENSE:IQVTIME:MAXTRACEPOINTS ONEK');
%     result = fwrite(fid,'FSENSE:IQVTIME:MAXTRACEPOINTS?');
%     result2 = fread(fid);
   % result = query(rsa,'FETCH:?IQVTIME:?RESULT?');
%     stuff = query(rsa,'FETCh:IQVTime:I?');
%     Cent_Freq = (query(rsa, 'SENSE:?IQVT:?FREQ:?CENT?'));
%     %MaxPts =  
%     %data = str2double(query(rsa,'FETCh:IQVTime:I?'));
%    data = binblockread(rsa,'float');


    
% %     if j == 1
% %         dataAccum = data;
% %     else
% %         dataAccum = dataAccum*(j-1)/j + data/j;
% %     end
% %     hold off
% %     plot(Freq, data)
% %     hold on
% %     plot(Freq, dataAccum,'-r')
% %     xlim([Start_Freq Stop_Freq]);
% %     ylabel('Power (dBm)'); xlabel('Frequency (MHz)');
% %     drawnow
% %     shg
    toc
end
fclose(rsa);
delete(rsa);
clear rsa;