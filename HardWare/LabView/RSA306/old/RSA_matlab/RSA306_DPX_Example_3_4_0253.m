addpath('.')
addpath('.\Dependency Files')
dev = icdevice('RSA306_Driver_3_4_0253');
connect(dev); 

%Set tuning parameters
centerFreq = 700e6;
refLevel = -50.0;
recordLength = 5000;
span = 40e6;
set(dev.Acquisition, 'CenterFrequency', centerFreq);
set(dev.Amplitude, 'ReferenceLevel', refLevel);
set(dev.Acquisition, 'IQRecordLength', recordLength);
set(dev.Acquisition, 'IQBandwidth', span);

invoke(dev.DPX, 'ResetDPX');
invoke(dev.DPX, 'SetSpectrumTraceType', 0, 1); %first trace set to max peak detection

[minRBW, maxRBW] = invoke(dev.DPX, 'FindRBWRange', span); %Use this command to find the max and min allowed RBW

%set DPX spectrum parameters
resBandwidth = 300e3; %must be between max and min RBW
bitmapWidth = 801;
tracePtsPerPixel = 1;
yUnit = 0;
yTop = -50;
yBottom = -150;
infinitePersistance = false;
persistanceTimeSec = 1;
showOnlyTriggerFrames = false;  %must be set to true for DPX triggering
invoke(dev.DPX, 'SetParameters', span, resBandwidth, bitmapWidth, tracePtsPerPixel, yUnit, yTop, yBottom, infinitePersistance, persistanceTimeSec, showOnlyTriggerFrames);

%set DPXogram parameters
timePerBitmapLine = 0.0001;
timeResolution = 0.0001;
maxPower = -43;
minPower = -200;
invoke(dev.DPX, 'SetSogramParameters', timePerBitmapLine, timeResolution, maxPower, minPower);
invoke(dev.DPX, 'SetSogramTraceType', 0);

invoke(dev.DPX, 'Configure', true, true);

Settings = invoke(dev.DPX, 'GetSettings')
SogramSettings = invoke(dev.DPX, 'GetSogramSettings')

% Triggering
set(dev.Trigger, 'Position', 10);     % trigger occurs at %50 into record
set(dev.Trigger, 'IFPowerLevel', -75.5);  % -50dBm trigger level
set(dev.Trigger, 'Transition', 1);      % low-high transition
set(dev.Trigger, 'Source', 1);          % internal IF trigger
set(dev.Trigger, 'Mode', 1);            % enable trigger

%start audio
set(dev.Audio, 'Mode', 3);       %FM 200kHz
set(dev.Audio, 'Volume', 0.2);   %10% volume
invoke(dev.Audio, 'StartAudio');

frames = 500;

mode = get(dev.Audio, 'Mode')
volume = get(dev.Audio, 'Volume')
mute = get(dev.Audio, 'Mute')

invoke(dev.Waveform, 'Run');
invoke(dev.DPX, 'SetDPXEnabled', true);
for i = 1:frames
    invoke(dev.Waveform, 'Run');
    %invoke(dev.Trigger, 'ForceTrigger');            % force trigger
    %aquire DPX
    invoke(dev.DPX, 'FinishFrameBuffer', true);
    dataready = invoke(dev.DPX, 'WaitForDPXDataReady', 20);
    if dataready
        bufferready = invoke(dev.DPX, 'IsFrameBufferAvailable');
    else
        bufferready = 0;
    end
    if bufferready
        buf =  invoke(dev.DPX, 'GetFrameBuffer');

        %plot DPX spectrum
        spectrum = vec2mat(buf.spectrumBitmap, buf.spectrumBitmapWidth);
        spectrum = round(((spectrum / 900).^.3)*128);
        subplot(3,1,1);
        image(spectrum)

        %plot DPX sogram
        sogram = vec2mat(buf.sogramBitmap, buf.sogramBitmapWidth);
        sogram = sogram-130;
        subplot(3,1,2)
        image(sogram)

        trace1 = buf.spectrumTraces(:,1);
        subplot(3,1,3)
        semilogy(trace1)
        xlim([0,801])
        ylim([10e-15,10e-8])
        
        drawnow;
    end
    
end

invoke(dev.Audio, 'StopAudio');

pause(1);
invoke(dev.Waveform, 'Stop');

close

%SogramHiRes functions must be called after Stop
linecount = invoke(dev.DPX, 'GetSogramHiResLineCountLatest');
if linecount > 4000
    linecount = 4000;
end
A= zeros(linecount,801);
for i = 1:linecount
    hires = invoke(dev.DPX, 'GetSogramHiResLine', i, 801, 0);
    timestamps(i) = invoke(dev.DPX, 'GetSogramHiResLineTimestamp', i);
    triggers(i) = invoke(dev.DPX, 'GetSogramHiResLineTriggered', i);
    A(i,:) = hires;
end

figure
imagesc(A);

disconnect(dev);
delete(dev);
clear('dev');
