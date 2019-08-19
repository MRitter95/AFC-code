clear all
close all
clc


Fs = 1e9; % Sampling frequency
pulseduration = 0.1e-6;
t = 0:1/Fs:pulseduration; % Time vector of 1 second
x = chirp(t,50e6,pulseduration,150e6,'linear',90);

for repeats = 1:4
    

    figure(6+repeats)
    for i = 1 : repeats  % ultimate duration is 
        t = [t, t+pulseduration];
        x = [x, x];
        pulseduration = pulseduration*2;
    end

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
    %figure(1);
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
%     ylim([-5 20])
end