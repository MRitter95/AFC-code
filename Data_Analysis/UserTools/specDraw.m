function [] = specDraw(inputfile, startfreq, endfreq)
infile=fopen(inputfile);
format='%f';
logamps=fscanf(infile,format);
freq=linspace(startfreq, endfreq, length(logamps));
plot(freq, logamps)