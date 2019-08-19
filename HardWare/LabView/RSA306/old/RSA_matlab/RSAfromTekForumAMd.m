clear all
close all
clc

a = instrfind;
delete(a)
clear a

% Open connection to RSA306
visa_brand = 'tek';
visa_address_rsa = 'GPIB8::1::INSTR';
buffer = 10000 * 1024;
rsa = visa(visa_brand, visa_address_rsa, 'InputBufferSize', buffer, ...
    'OutputBufferSize', buffer);
fopen(rsa);
%get(rsa)
dataAccum = [];
tic

% Get Spectrum
%pts = [801 1601 2401 3201 4001 6401 8001 10401] %these should work
pts = [801  2401  4001  8001 10401 16001 32001 64001]; % but only these actually work
whichpt = 3;
fwrite(rsa, ['SENSE:SPECTRUM:POINTS:COUNT P', num2str(pts(whichpt))]);
SpecPts = query(rsa, 'SENSE:SPECTRUM:POINTS:COUNT?');
Center = str2double(query(rsa,'SENSe:SPECtrum:FREQuency:CENTer?'));
Center = Center./1e6;
Start_Freq = str2double(query(rsa, 'SENSE:SPECTRUM:FREQUENCY:START?'));
Start_Freq = Start_Freq./1e6;
Stop_Freq = str2double(query(rsa, 'SENSE:SPECTRUM:FREQUENCY:STOP?'));
Stop_Freq = Stop_Freq./1e6;
Span = (Stop_Freq - Start_Freq);
Freq = linspace(Start_Freq, Stop_Freq, pts(whichpt))';

% Set and get IQVTime parameters
fwrite(rsa, 'SENSe:IQVTime:MAXTracepoints NEV');%%%%%%%%%%%%%%%%%%%
fwrite(rsa, 'SENSe:ANALysis:LENGth 0.2ms');
AnalLength = query(rsa, 'SENSe:ANALysis:LENGth:ACT?');
fprintf('Num of Spectrum Pts= %s  Analysis Length(s) %s',SpecPts,AnalLength);
%fwrite(rsa, 'SENSe:IQVTime:MAXTracepoints TENK');%%%%%%%%%%%%%%%%%%%
query(rsa, 'SENSe:IQVTime:MAXTracepoints?');%%%%%%%%%%%%%%%%%%%
fwrite(rsa, 'SENSE:ACQUISITION:MODE AUTO')
AcqLength = str2double(query(rsa, 'SENSE:ACQUISITION:SEC?'))
Samples = str2double(query(rsa, 'SENSE:ACQUISITION:SAMPLES?'))
time_step = AcqLength/Samples
fwrite(rsa,c
% query(rsa,'DISPLAY:IQVTIME:X:SCALE?')
% query(rsa,'DISPLAY:IQVTIME:X:SCALE:MIN?')
% query(rsa,'DISPLAY:IQVTIME:X:SCALE:MAX?')
% query(rsa,'DISPLAY:IQVTIME:Y:SCALE?')
offset = str2double(query(rsa,'DISPLAY:IQVTIME:X:SCALE:OFFSET?'))
% fprintf('\nNum of Spectrum Pts= %f  \nAnalysis Length(s) %f',SpecPts,AnalLength);

% Set to Trigger mode
fwrite(rsa,'TRIGGER:SEQUENCE:EVENT:SOURCE EXT')
fwrite(rsa,'TRIGGER:SEQUENCE:STATUS ON')


% Fetch acquisitions on each trigger
TotAcq = 15
fftout2 = [];
fftAccum = [];
for j =1:TotAcq
    fwrite(rsa, 'INITIATE:IMMEDIATE');
    disp('waiting');
    tic
    query(rsa, '*OPC?');
    disp('done')
    timerValtoc(j) = toc
    fwrite(rsa, 'FETCH:SPECTRUM:TRACE1?');
    [data,datacount] = binblockread(rsa,'float');
    datraw = query(rsa, 'FETCH:SPECTRUM:TRACE1?');
    
    fwrite(rsa,'FETCH:IQVTime:I?');
    [dataIbin,dataIbincount] = binblockread(rsa,'float');
    datIraw = query(rsa,'FETCH:IQVTime:I?');
    fwrite(rsa,'FETCH:IQVTime:Q?');
    dataQbin = binblockread(rsa,'float');
    % query(rsa, 'SENSe:?ANALysis:?STARt?')
    
    fprintf('trace %d, length of IQVT %d \n',j, length(dataIbin));%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(1)
    subplot(2,1,1)
    hold off
    plot(dataIbin);
    hold on
    plot(dataQbin);
    
    
    
    if j == 1
        dataAccum = data;
    else
        dataAccum = dataAccum*(j-1)/j + data/j;
    end
    
    subplot(2,1,2)
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
    
    time_axis = ([0:length(dataIbin)-1]*time_step) + offset;
    figure(2)
    ax1 = subplot(3,1,1);
    plot(time_axis,dataIbin)
    
    Y = dataIbin + 1i*dataQbin;
    interval = length(Y);
    Yinterval = Y;% Y((i*interval+1:(i+1)*interval))';
    LenY = length(Yinterval);
    title('Time domain - Real')
    ylim([-0.1 0.1]);
    
    ax2 = subplot(3,1,2);
    plot(time_axis,dataQbin)
    title('Time domain - Imaginary')
    linkaxes([ax1,ax2],'x')
    
    
    %     pause
    %     [x,y] = ginput
    %     hold on
    %     plot(x,[0,0],'-k');
    %
    %     curser1index = min(find(time_axis>x(1)));
    %     curser2index = min(find(time_axis>x(2)));
    %     Yinterval = Y(curser1index:curser2index);
    
    LenYinterval = length(Yinterval);
    subplot(3,1,3)
    fs = 1/time_step; %% sampling frequency
    NFFT = 2^(nextpow2(LenYinterval)); %% will always be even
    fres = fs/NFFT; %LenY; %% frequency resolution
    freqaxisraw = [0:NFFT-1]*fres;
    freqaxis = freqaxisraw -fres*NFFT/2;
    freqaxis = freqaxis + Center*1e6;
    freqaxis = freqaxis';
    ptstrunc = Span/2/fres;
    %     freqaxis = freqaxis(NFFT/2-ptstrunc:NFFT/2+ptstrunc);
    
    fftout = fftshift(log10((abs(fft(Yinterval,NFFT)))));
    %fftout = fftout(NFFT/2-ptstrunc:NFFT/2+ptstrunc);
    %    plot(freqaxisraw,fftout);
    %    title('Raw FFT')
    %    xlabel('Frequency (Hz)')
   
    
    [row,col] = size(fftout2);
    if col == 0
        fftout2 = fftout;
        fftout2 = [zeros(length(fftout),1), fftout2];
    else
        if col == 10
            fftout2 = fftout2(:,2:10);
        end
        fftout2 = [fftout2, fftout];
    end
    %     fftout2(1:length(fftout),end) = fftshift(fftout);
    [row,col] = size(fftout2)
    length(fftout2)
    plot(freqaxis/1e6,fftout2(:,end));
    
    title(['Frequencies ordered with fftshift  Center Freq(MHz)= ' num2str(Center/1e6)])
    xlabel('Frequency (MHz)')
    xlim([Center-Span/2,Center+Span/2]/1e6);
    
    if j == 1
        fftAccum = fftout2(:,j);
    else
        fftAccum = fftAccum*(j-1)/j + fftout2(:,end)/j;
    end
    
    subplot(3,1,3)
    hold off
    plot(freqaxis/1e6, fftout2(:,end),'b')
    hold on
    plot(freqaxis/1e6, fftAccum,'-r')
    
    figure(3)
    [F,J] = meshgrid(freqaxis,1:col);
    mesh(F'*1e-6,J',fftout2)
    xlabel('Frequency (MHz)')
    colormap(jet)
    view(-0.5,90)
    colorbar
    %    shading interp
    
    %        % Calculate RF Power
    %         Powerdbm = 10*log10(10*(dataIbin.^2 + dataQbin.^2));
    %         figure (2)
    %         plot(Powerdbm)
    
end
toc

% Disconnect RSA306
fclose(rsa);
delete(rsa);
clear rsa;