%RSA306_Driver_Script
%Version: Uses build 3.4.0253 of the API.

%add path of header file, DLL file and dependencies. If these files are
%moved, the path below must be updated.
addpath('.')
addpath('C:\Tektronix\RSA_API\include')
addpath('C:\Tektronix\RSA_API\lib\x64')
addpath('C:\Tektronix\RSA_API\lib\x64')

%declare values
loopIterations = 1000;

timeout = 5000;
centerFreq = 700.0e6;
recordLength = 5000;
refLevel = -50.0;
iqbw = 40.0e6;

%create device object
dev = icdevice('RSA306.mdd');
%connect to handle
connect(dev); 


%set values
set(dev.Acquisition, 'CenterFrequency', centerFreq);
set(dev.Amplitude, 'ReferenceLevel', refLevel);
set(dev.Acquisition, 'IQRecordLength', recordLength);
set(dev.Acquisition, 'IQBandwidth', iqbw);

% Triggering
set(dev.Trigger, 'Position', 50);     % trigger occurs at %50 into record
set(dev.Trigger, 'IFPowerLevel', -75.5);  % -75.5dBm trigger level
set(dev.Trigger, 'Transition', 1);      % low-high transition
set(dev.Trigger, 'Source', 1);          % internal IF trigger
% set(dev.Trigger, 'Mode', 1);            % enable trigger

%get IQ data
line = semilogy(nan);
axis([0, recordLength, 10e-5, 10e0])
running = 0;
while(running < loopIterations)  
    %start data acq
    invoke(dev.Waveform, 'Run');
    %if(running < loopIterations/2)
    %    invoke(dev.Trigger, 'ForceTrigger');            % force trigger
    %end
    %wait for data to be ready. Not currently checking for timeout occurence
    ready = invoke(dev.Waveform, 'WaitForIQDataReady', timeout);

    if ready
    IQ = invoke(dev.Waveform, 'GetIQData', 0, recordLength);
    
    I = IQ(1:2:recordLength*2);
    Q = IQ(2:2:recordLength*2);
    
    %plot
	spec = circshift(abs(fft(I+Q*1i)),[0,recordLength/2]);
	set(line, 'YData', spec);
    drawnow
    end
    running = running + 1;
end

%disconnect
invoke(dev.Waveform, 'Stop');
close
disconnect(dev);
delete(dev);
clear('dev');