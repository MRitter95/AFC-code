close all
clear all
interval = 1000000;
 load '017-03-03test004.mat'
%  d = dir('*.mat');
%  [dx,dx] = sort([d.datenum]);
%  newest = d(dx(end)).name
%  load (newest);

% Span = 20e6
interval = length(Y);
Yinterval = Y;% Y((i*interval+1:(i+1)*interval))';
figure(1)
ax1 = subplot(3,1,1);
LenY = length(Yinterval);

timeaxis = XDelta*[1:LenY];
plot(timeaxis,real(Yinterval(1:floor(LenY))))
title('Time domain - Real')
pause
[x,y] = ginput
hold on
plot(x,[0,0],'-k');

ax2 = subplot(3,1,2);
plot(timeaxis,imag(Yinterval(1:floor(LenY))))
title('Time domain - Imaginary')
linkaxes([ax1,ax2],'x')


curser1index = min(find(timeaxis>x(1)));
curser2index = min(find(timeaxis>x(2)));
Yinterval = Y(curser1index:curser2index);
LenYinterval = length(Yinterval);
subplot(3,1,3)
fs = 1/XDelta; %% sampling frequency
NFFT = 2^(nextpow2(LenYinterval)); %% will always be even
fres = fs/NFFT; %LenY; %% frequency resolution
freqaxisraw = [0:NFFT-1]*fres;
freqaxis = freqaxisraw -fres*NFFT/2;
freqaxis = freqaxis + InputCenter;
ptstrunc = Span/2/fres;
%freqaxis = freqaxis(NFFT/2-ptstrunc:NFFT/2+ptstrunc);
%Yinterval(LenY+1:NFFT) = 0; %% zero padding

fftout = log10((abs(fft(Yinterval,NFFT))));
%fftout = fftout(NFFT/2-ptstrunc:NFFT/2+ptstrunc);
% plot(freqaxisraw,fftout);
% title('Raw FFT')
% xlabel('Frequency (Hz)')


fftout2 = fftshift(fftout);
plot(freqaxis/1e6,fftout2);
title(['Frequencies ordered with fftshift  Center Freq(MHz)= ' num2str(InputCenter/1e6)])
xlabel('Frequency (MHz)')
xlim([InputCenter-Span/2,InputCenter+Span/2]/1e6);

shg
%pause



    