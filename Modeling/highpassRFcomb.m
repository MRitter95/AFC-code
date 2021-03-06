%Calculates RF comb produced by FM and applies a bandpass filter to 
%output RF comb to model amplifier bandwidth

%Takes center freq (F_C), fm deviation (F_D), modulation freq (F_M) (MHz),
%low and high end of bandpass filter (f0l and f0h) applied by amplifier
%modulation function (FUNC: choices are sine and triangle wave).

%Returns spectrum as well as time series data of modulated signal and
%modulating signal

function [t,rf_t_pass1, rf_t_highpass, amp, f, amph, fh] = highpassRFcomb(f_c,f_d,f_m, f_3dB, func)

f_s= 4096*2; %sampling rate
dt= 1/f_s; %time step

Tmax= 5000/f_c; %length of signal
t= 0:dt:Tmax-dt; %time range
f= -4096.03+1/Tmax:1/Tmax:4096.03-1/Tmax; %frequency range

m_pass1= sin(2*pi*f_m*t); %modulating signal (defaults to sine modulation)

if func==1 %note: 'triangle' is a reserved keyword so tri has to be used instead
    disp('triangle time!');
    m_pass1= sawtooth(2*pi*f_m*t,1/2);
else
    disp('sine');
end

rf_t_pass1= fmmod(m_pass1,f_c,f_s,f_d);

rf_t_highpass=highpass(rf_t_pass1,f_3dB, f_s);

[amp, f]=periodogram(rf_t_pass1,[],[], f_s);
%amph=amp.*(f./sqrt(f0l^2+f.^2)).^2;
%amph=amp.*(f0h./sqrt(f0h^2+f.^2)).^2;
%fh=f;
[amph, fh]=periodogram(rf_t_highpass,[],[], f_s);
