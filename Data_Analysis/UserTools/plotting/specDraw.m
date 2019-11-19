%Simple function to plot RSA data (saved in .txt format)
%Input: inputfile, .txt file with RSA data
%Input: startfreq, starting frequency of RSA sweep
%Input: endfreq, ending frequency of RSA sweep

function [] = specDraw(inputfile, startfreq, endfreq)

format  = '%f';
infile  = fopen(inputfile);
logamps = fscanf(infile,format);
freq    = linspace(startfreq, endfreq, length(logamps));
plot(freq, logamps)
