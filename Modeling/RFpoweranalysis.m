% Estimating power in RF comb after AOM bandwidth truncation

function [modfreqs, power] = RFpoweranalysis(userdir)
startdir=pwd;
cd(userdir)
files=dir('*.bin');
[~,idx]=sort_nat({files.name});
files=files(idx);

bandwidthdat=[0.1375, 0.101875, 0.2215625, 0.42, 0.659375, 0.85, ...
    0.95625, 0.99375, 1, 0.978125, 0.921875, 0.846875, 0.721875, ...
    0.571875, 0.4125, 0.258125, 0.1284375, 0.045625, 0.0121875, ...
    0.002875, 0.0011875];
freqsmeas=linspace(60, 160, length(bandwidthdat));
bw=fit(freqsmeas', bandwidthdat', 'gauss2');

power=zeros(1,length(files));
wave=readbin(files(1).name);
amp=zeros(1, length(wave.y));

for i=1:length(files)
    wave=readbin(files(i).name);
    thresh=wave.y>-80;
    amp(thresh)=10.^(wave.y(thresh)/10);
    %amp=amp.*bw(wave.x*2)';
    power(i)=sum(amp);
end

power=power/max(power);
modfreqs=linspace(0.1, 20, 200);

cd (startdir);