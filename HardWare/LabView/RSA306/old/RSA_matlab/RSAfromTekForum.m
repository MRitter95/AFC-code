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

fwrite(rsa, 'SENSE:SPECTRUM:POINTS:COUNT P801');
fwrite(rsa, 'FETCH:SPECTRUM:TRACE1?');

data = binblockread(rsa,'float');

Start_Freq = str2double(query(rsa, 'SENSE:SPECTRUM:FREQUENCY:START?'));
Start_Freq = Start_Freq./1e6;
Stop_Freq = str2double(query(rsa, 'SENSE:SPECTRUM:FREQUENCY:STOP?'));
Stop_Freq = Stop_Freq./1e6;
Freq = linspace(Start_Freq, Stop_Freq, 801);

plot(Freq, data)
xlim([Start_Freq Stop_Freq]);
ylabel('Power (dBm)'); xlabel('Frequency (MHz)');

fclose(rsa);
delete(rsa);
clear rsa;