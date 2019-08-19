clear all
close all
clc

fs=1e9 ; %sampling frequency
t=-0.1e-6:1/fs:7e-6; %time base
T=1e-6; %Period
D=0.5e-6 %Duration
N=4; %Number of pulses
d=[0:T:T*N];
y=pulstran(t,d,'rectpuls',D);
t=t+0.25e-6;
subplot(2,1,1) 
plot(t,y);
title(['Rectangular Pulse width=', num2str(T),'s']);
xlabel('Time(s)');
ylabel('Amplitude');
L=length(y);
NFFT = 1024;
X = fftshift(fft(y,NFFT)); %FFT with FFTshift for both negative & positive frequencies
f = fs*(-NFFT/2:NFFT/2-1)/NFFT; %Frequency Vector
subplot(2,1,2) 
plot(f,abs(X)/(L),'r');
title('Magnitude of FFT');
xlabel('Frequency (Hz)')
ylabel('Magnitude |X(f)|');