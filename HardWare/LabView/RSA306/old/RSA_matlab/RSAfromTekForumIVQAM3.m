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
% rsa = visa(visa_brand, visa_address_rsa);
fopen(rsa);
dataAccum = [];
% get(rsa)
% set(rsa,'Timeout',20);
query(rsa,'DISPlay:WINDow:ACTive:MEASurement? ')
fwrite(rsa,'INITiate:CONTinuous ON');
tic
for j =1:1
    
%      fwrite(rsa,'SENSE:?REANALYZE:?SELECT:?ACQUISITION:?DATA:?TYPE IQ')
%      query(rsa,'*OPC?')
%      query(rsa,'SENSE:?REANALYZE:?SELECT:?ACQUISITION:?DATA:?TYPE?')
     
%      while query(rsa,'*OPC?') ~= 1
%          0
%      end
     
 %    fwrite(rsa,'SENSE:IQVTIME:MAXTRACEPOINTS ONEK');
 %   fwrite(rsa,'SENSE:IQVTIME:MAXTRACEPOINTS NEVerdecimate');
    
    FreqSpan = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:SPAN?'))
    FreqStart = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:START?'));
    FreqStop = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:STOP?'));
    FreqCenter = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:CENTER?'))
    MaxTrPts = query(rsa,'SENSE:IQVTIME:MAXTracepoints?')

   
    Maxi = (query(rsa,'READ:IQVTime:MAXimum?'));
    
    MaxT = (query(rsa,'SENSE:IQVTIME:MAXTRACEPOINTS?'));
    
%     fwrite(rsa,'INITiate:CONTinuous ON;INITiate:IMMediate')
%     pause(2)
%     fwrite(rsa,'Abort')
fwrite(rsa,'INITiate:RESUME');
%      while query(rsa,'*OPC?') ~= 1
%          0
%      end

     Result = (query(rsa,'READ:IQVTime:Result?')) %<max>,<max_time>,<min>,<min_time>
%      fwrite(rsa,'TRIGger:?SAVE:?DATA:?FORMat MAT')
%      (query(rsa,'TRIGger:?SAVE:?DATA:?FORMat?'))

      dataI = (query(rsa,'READ:IQVTime:I?'))
     
%     query(rsa,'READ:?IQVTime:?RESult?')


   % dataQ = (query(rsa,'READ:IQVTime:Q?'));
    
    d2 = str2num(dataI(2));
    length(dataI)
    newdataI = dataI(str2num(dataI(2))+d2:end);
    length(newdataI);
   % newdataQ = dataQ(str2num(dataQ(2))+d2:end);
    newdatauintI = uint32(newdataI);
    length(newdatauintI);
    %newdatauintQ = uint8(newdataQ);
    floatdataI = typecast (newdatauintI,'single');
    % Checking Endian-ness of this processor
%     str = computer;
%     archstr = computer('arch');
%     [str,maxsize] = computer;
%     [str,maxsize,endian] = computer;
    %     floatdata = typecast (int32(newdata),'single');
    % floatdataI = typecast (int32(newdataI),'single');
%   floatdataI = typecast (uint32(newdataI),'single');
  %  floatdataQ = typecast (uint32(newdataQ),'single');
%   dumdum = reshape(newdatauintI,4,268/4); <---
   plot(floatdataI,'r')
plot(uint32(dumdum(4,:)))
  hold on
  plot(uint32(dumdum(3,:)),'-r')
 
  % plot(floatdataQ,'k')
%     floatdataswapped = swapbytes(floatdata);
    %   FreqCent = str2double(query(rsa,'SENSE:?IQVTIME:?FREQUENCY:?CENTER?'));

    
    %     fwrite(rsa, 'SENSE:IQVTIME:MAXTRACEPOINTS ONEK');
    %     result = fwrite(fid,'FSENSE:IQVTIME:MAXTRACEPOINTS?');
    %     result2 = fread(fid);
    % result = query(rsa,'FETCH:?IQVTIME:?RESULT?');
    %     stuff = query(rsa,'FETCh:IQVTime:I?');
    %     Cent_Freq = (query(rsa, 'SENSE:?IQVT:?FREQ:?CENT?'));
    %     %MaxPts =
    %     %data = str2double(query(rsa,'FETCh:IQVTime:I?'));
    %    data = binblockread(rsa,'float');
    
end
toc
fclose(rsa);
delete(rsa);
clear rsa;