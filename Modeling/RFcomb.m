%Generates RF comb from FM modulation
%Takes in center frequency, fm deviation (amplitude of frequency
%variation), modulation frequency (teeth), modulation function (choices
%are sine and triangle wave), and a boolean that applies the AOM response
%function to the comb
%Returns spectrum as well as time series data of modulated signal and
%modulating signal

function [freq, spectrunc, t, signal, m] = RFcomb(center, fmdev, teeth, func, useAOM)

fc = center; %carrier frequency 
f = teeth; %tooth spacing
beta = fmdev/f; %modulation depth

fs=4096*2; %sampling rate
dt=1/fs; %time step

fref=100;
T=1/fref; %carrier period
Tmax=5000*T; %length of signal
t = 0:dt:Tmax-dt; %time range
freq=-4096.03+1/Tmax:1/Tmax:4096.03-1/Tmax; %frequency range

m = sin(2*pi*f*t); %modulating signal (defaults to sine modulation)

if(strcmp(func,'tri')) %note: 'triangle' is a reserved keyword so tri has to be used instead
    m=0;
    for n=0:100
        term=((-1)^n)/((2*n+1)^3)*cos((2*n+1)*2*pi*f*t);
        m=m+term;
    end
    m=-8*m/pi^2;
end

signal=0.29*fmmod(m,fc,fs,fmdev);
N=length(signal);
spec = fft(signal); %normalized spectrum
% lspec=spec(1:N/2+1);
% lspec= spec;
lspec= [spec(end-N/2:end),spec(1:N/2+1)];
lspec=(dt/N)*abs(lspec).^2; %power spectrum
% lspec(2:end-1)=2*(lspec(2:end-1)); %negative and positive frequencies are indistinguishable 
% spectrunc=lspec(1:length(freq)); %returns truncated power spectrum (don't need negative frequencies and high frequencies)
spectrunc= lspec;

%Use this to apply aom bandwidth correction (will cut out high and low
%frequencies as a function of bandwidth)
if(strcmp(useAOM,'true'))
    bw=25; %aom bandwidth
    f0=100;
    aom=0.8*exp(-((freq-f0)./(2*bw)).^2); %gaussian bw, max diffraction efficiency 110 MHz, 90%
    spectrunc=spectrunc.*aom; %convolve AOM bw with spectrum
end