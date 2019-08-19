% CAUTION: Automatically deletes files from folder!
close all
clear all
interval = 1000000;
% load '017-03-03test004.mat'
newestold = 'empty';
fftaccum = [];
filecount = 0;
for j=1:10000
 
 d = dir('*.mat');
 [dx,dx] = sort([d.datenum]);
 newest = d(dx(end)).name;
 while strcmp( newest,newestold) ~= 1
 
 filecount = filecount+1   
 load (newest);
newestold = newest;
% Span = 20e6
interval = length(Y);
Yinterval = Y;% Y((i*interval+1:(i+1)*interval))';
figure(1)
ax1 = subplot(2,1,1);
LenY = length(Yinterval);

timeaxis = XDelta*[1:LenY];
plot(timeaxis,real(Yinterval(1:floor(LenY))))
title('Time domain - Real')
ylim([-1 1]);
% % pause
% % [x,y] = ginput
% % hold on
% % plot(x,[0,0],'-k');
% % 
% % ax2 = subplot(3,1,2);
% % plot(timeaxis,imag(Yinterval(1:floor(LenY))))
% % title('Time domain - Imaginary')
% % linkaxes([ax1,ax2],'x')
% % 
% % 
% % curser1index = min(find(timeaxis>x(1)));
% % curser2index = min(find(timeaxis>x(2)));
% % Yinterval = Y(curser1index:curser2index);
LenYinterval = length(Yinterval);
subplot(2,1,2)
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
hold off


plot(freqaxis/1e6,fftout2);
ylim([-1.5 3]);
title(['Frequencies ordered with fftshift  Center Freq(MHz)= ' num2str(InputCenter/1e6)])
xlabel('Frequency (MHz)')
% xlim([InputCenter-Span/2,InputCenter+Span/2]/1e6);
if length(fftaccum)==0
    fftaccum = fftout2;
end
fftaccum = fftaccum*(filecount-1)/filecount + fftout2/filecount;

%subplot(3,1,3)
hold on
plot(freqaxis/1e6,fftaccum, '-r');
ylim([-1.5 3]);



%shg

 end  
 pause(.2)
%  pause

% newest = d(dx(end)).name
% currentFile = fullfile('C\:Users\Lab\Desktop\Data',newest);
% currentFile1 = currentFile(1:end-4)
disp(newest)
delete(newest);
disp(exist(newest, 'file'))

 
end
%pause



    