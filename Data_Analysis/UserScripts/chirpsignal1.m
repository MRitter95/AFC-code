clear all
close all
clc

Fs = 1e8; % Sampling frequency
t = 0:1/Fs:1e-6; % Time vector of 1 second
x = chirp(t,1e6,1e-6,10e6,'linear',90);
% x1 = [x x x x x x x x x x];
nfft = 1024*5000; % Length of FFT
% Take fft, padding with zeros so that length(X) is equal to nfft
X = fft(x,nfft);
% FFT is symmetric, throw away second half
X = X(1:nfft/2); 
% Take the magnitude of fft of x
mx = abs(X);
% This is an evenly spaced frequency vector
f = (0:nfft/2-1)*Fs/nfft; 
% Generate the plot, title and labels.
figure(1);
hold on
subplot(2,1,1)
plot(t,x);
title('Chirp Signal');
xlabel('Time (s)');
ylabel('Amplitude'); 
subplot(2,1,2)
plot(f,10*log10(mx),'r');
title('Power Spectrum of Chirp Signal');
xlabel('Frequency (Hz)');
ylabel('Power (dB)'); 
ylim([-5 20])