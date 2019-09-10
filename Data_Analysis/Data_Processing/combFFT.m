%First attempt to take FFT of AFC comb to get better idea of "quality of
%comb" and hopefully predict what frequencies will dominate storage time/
%echo

%create dummy optical comb spaced by n MHz
center=100;
bw=50;
dF=5;
fs=8096;
T=1/center;
Tmax=1000*T;
t=-Tmax:1/fs:Tmax;
freqs=center-bw:dF:center+bw;
signal=zeros(1,length(t));
signal2=zeros(1,length(t));
for i=1:length(freqs)
    signal=signal+1/2*(sin(2*pi*freqs(i)*t)+sin(2*pi*(freqs(i)+dF/2)*t));
    signal2=signal2+sin(2*pi*freqs(i)*t);
end

signal=signal/length(freqs);
signal2=signal2/length(freqs);

figure(1)
[pxx,f]=periodogram(signal,[],[],fs);
[pxx2,f2]=periodogram(signal2,[],[],fs);
df=f(2)-f(1);
plot(f,10*log10(pxx),f2,10*log10(pxx2))
xlim([0 300])
ind1=round((40-f(1))/df);
ind2=round((160-f(1))/df);
pxxtrunc=pxx(ind1:ind2);
pxx2trunc=pxx2(ind1:ind2);
figure(2)
[fpxx,ff]=periodogram(pxxtrunc,[],[],1/(df));
[fpxx2,ff2]=periodogram(pxx2trunc,[],[],1/(df));
plot(ff,fpxx,ff2,fpxx2)