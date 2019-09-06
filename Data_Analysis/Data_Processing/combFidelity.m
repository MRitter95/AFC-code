function [linOverlap,logOverlap]= combFidelity(afcFile,probeFile)
% function takes .bin file containing AFC data (CH1) with two sweeps of the
% probe; returns overlap between measured AFCs on two sweeps. DELTAOVERLAP
% contains two numbers: overlap between AOM4 and AOM3 sweeps, approximating
% peaks as delta functions. OVERLAP has the same format, but includes the
% widths of the teeth, as determined by FINDPEAKS.

afc= readbin(afcFile,'true');
probe= readbin(probeFile,'true');

linOverlap= [0,0];
logOverlap= [0,0];

% find intervals between calibration tones and make equal-sized arrays in
% which to compare the two sweeps.
toneTimes= findTones2(probe,10);
if (toneTimes(3)-toneTimes(2))-(toneTimes(7)-toneTimes(6))>0
    toneTimes(2)= toneTimes(3)+toneTimes(6)-toneTimes(7);
else
    toneTimes(6)= toneTimes(7)+toneTimes(2)-toneTimes(3);
end
if (toneTimes(5)-toneTimes(4))-(toneTimes(9)-toneTimes(8))>0
    toneTimes(4)= toneTimes(5)+toneTimes(8)-toneTimes(9);
else
    toneTimes(8)= toneTimes(9)+toneTimes(4)-toneTimes(5);
end

% select points in afc arrays
sig_aom4= [afc.y(toneTimes(2):toneTimes(3)),...
    afc.y(toneTimes(6):toneTimes(7))];
sig_aom3= [afc.y(toneTimes(4):toneTimes(5)),...
    afc.y(toneTimes(8):toneTimes(9))];

% average to smooth things out
N= 100; %number of points to average.
data_aom4= avgByNs(sig_aom4(:,1),N);
data_aom4= [data_aom4,avgByNs(sig_aom4(:,2),N)];
data_aom3= avgByNs(sig_aom3(:,1),N);
data_aom3= [data_aom3,avgByNs(sig_aom3(:,2),N)];

% calculate overlap between two sweeps, first for AOM4, then AOM3
linOverlap(1)= sum(data_aom4(:,1).*data_aom4(:,2)/...
    sqrt(sum(data_aom4(:,1).^2)*sum(data_aom4(:,2).^2)))^2;
linOverlap(2)= sum(data_aom3(:,1).*data_aom3(:,2)/...
    sqrt(sum(data_aom3(:,1).^2)*sum(data_aom3(:,2).^2)))^2;

% similarly, calculate overlap between log of the signals.
dB_aom4= log(data_aom4+min(min(data_aom4)+1e-6));
dB_aom4= log(data_aom4+min(min(data_aom4)+1e-6));
logOverlap(1)= sum(dB_aom4(:,1).*dB_aom4(:,2)/...
    sqrt(sum(dB_aom4(:,1).^2)*sum(dB_aom4(:,2).^2)))^2;

dB_aom3= log(data_aom3+min(min(data_aom3)+1e-6));
dB_aom3= log(data_aom3+min(min(data_aom3)+1e-6));
logOverlap(2)= sum(dB_aom3(:,1).*dB_aom3(:,2)/...
    sqrt(sum(dB_aom3(:,1).^2)*sum(dB_aom3(:,2).^2)))^2;
end