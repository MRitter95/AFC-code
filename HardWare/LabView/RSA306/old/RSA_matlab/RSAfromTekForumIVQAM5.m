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
% get(rsa);
fwrite(rsa,'SYSTem:SVPC:CONNect:RSA306')
% query(rsa,'STATUS:?IQVTIME:?EVENTS?')
dataAccum = [];
display = query(rsa,'DISPlay:WINDow:ACTive:MEASurement? ');
fprintf('Display type= %s',display);
fwrite(rsa,'INITiate:CONTinuous ON');
fwrite(rsa,'SENSE:IQVTIME:MAXTRACEPOINTS ONEK')
tic
for j =1:1
       
    FreqSpan = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:SPAN?'));
    fprintf('FreqSpan = %d \n',FreqSpan);
    FreqStart = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:START?'));
    fprintf('FreqStart = %d \n',FreqStart);    
    FreqStop = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:STOP?'));
    fprintf('FreqStop = %d \n',FreqStop);    
    FreqCenter = str2double(query(rsa,'SENSE:IQVTIME:FREQUENCY:CENTER?'));
    fprintf('FreqCenter = %d \n',FreqCenter);    
    MaxTrPts = query(rsa,'SENSE:IQVTIME:MAXTracepoints?');  
    fprintf('MaxTrPts = %s \n',MaxTrPts);    
    Maxi = (query(rsa,'READ:IQVTime:MAXimum?'));    
    MaxT = (query(rsa,'SENSE:IQVTIME:MAXTRACEPOINTS?'));
    
    fwrite(rsa,'INITiate:CONT');
    Result = (query(rsa,'READ:IQVTime:Result?')); %<max>,<max_time>,<min>,<min_time>
    fprintf('<max>,<max_time>  ,<min> ,<min_time> %s \n',Result);   
    fwrite(rsa,'TRIGger:?SEQuence:?FORCed')
%     get(rsa);
    pause(1);
%     get(rsa)   
    dataI = (query(rsa,'READ:IQVTime:I?'));
     
    d2 = str2num(dataI(2));
    fprintf('length= %d data= %s',length(dataI),dataI);
    newdataI = dataI(str2num(dataI(2))+d2:end);
    length(newdataI);
    newdatauintI = uint32(newdataI);
    length(newdatauintI);
    floatdataI = typecast (newdatauintI,'single');
%   dumdum = reshape(newdatauintI,4,268/4); <---
%     plot(floatdataI,'r')
%     plot(uint32(dumdum(4,:)))
%     hold on
%     plot(uint32(dumdum(3,:)),'-r')
    
end
toc
fclose(rsa);
delete(rsa);
clear rsa;