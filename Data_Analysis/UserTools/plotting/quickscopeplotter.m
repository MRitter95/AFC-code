%This quick script will plot all the C1 traces with a given name and show
%them on the same plot. Should probably be changed to a function in the
%longer term

files=dir('C1*.trc');
figure
hold on
for i=1:length(files)
wave=ReadLeCroyBinaryWaveform(files(i).name);
plot(wave.y+1.5*i)
end