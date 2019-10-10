files=dir('C1*.trc');
figure
hold on
for i=1:length(files)
wave=ReadLeCroyBinaryWaveform(files(i).name);
plot(wave.y+1.5*i)
end