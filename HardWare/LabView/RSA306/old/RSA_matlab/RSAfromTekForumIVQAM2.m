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
    fwrite(rsa,'[SENSE]:?REANALYZE:?SELECT:?ACQUISITION:?DATA:?TYPEIQ')
    query(rsa,'[SENSE]:?REANALYZE:?SELECT:?ACQUISITION:?DATA:?TYPE?')
    
%   fwrite(rsa,'SENSE:IQVTIME:MAXTRACEPOINTS ONEK');
    fwrite(rsa,'SENSE:IQVTIME:MAXTRACEPOINTS NEVerdecimate');
    
    FreqSpan = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:SPAN?'));
    FreqStart = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:START?'));
    FreqStop = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:STOP?'));
    FreqCenter = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:CENTER?'));
    
    Maxi = (query(rsa,'READ:IQVTime:MAXimum?'));
    
    MaxT = (query(rsa,'SENSE:IQVTIME:MAXTRACEPOINTS?'));
    
    dataI = (query(rsa,'READ:IQVTime:I?'));
    dataQ = (query(rsa,'READ:IQVTime:Q?'));
    
    d2 = str2num(dataI(2));
    newdataI = dataI(str2num(dataI(2))+d2:end);
    newdataQ = dataQ(str2num(dataQ(2))+d2:end);
    newdatauintI = int32(newdataI);
    newdatauintQ = int32(newdataQ);
    
    % Checking Endian-ness of this processor
    str = computer;
    archstr = computer('arch');
    [str,maxsize] = computer;
    [str,maxsize,endian] = computer;
    %     floatdata = typecast (int32(newdata),'single');
    floatdataI = typecast (int32(newdataI),'single');
    floatdataQ = typecast (int32(newdataQ),'single');
    
   plot(floatdataI,'r')
   hold on
   plot(floatdataQ,'k')
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