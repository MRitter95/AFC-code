step= input('Spacing between vertical traces? (usually 3) ');
minprom= input('Minimum prominence for a peak? (usually 0.01) ');
mindist= input('Minimum distance between peaks? (usually 0.045) ');
startfreq= input('Smallest modulation frequency (MHz)? ');
endfreq= input('Largest modulation frequency (MHz)? ');
numSweeps= input('How many AOM sweeps were used? ');
sweep= zeros(numSweeps,2);

for j=1:numSweeps
    sweep(j,1)= input(['Start freq. for sweep #',int2str(j),'?: ']);
    sweep(j,2)= input(['End freq. for sweep #',int2str(j),'?: ']);
end

sweepspeed= input('How fast were the sweeps (MHz/s)? ');

disp(['Saving file in current directory: ' pwd ])
pathOK         = input('Is that ok (Y/N)?','s');
if(strcmp(pathOK,'Y') || strcmp(pathOK,'y'))
    userpath   = pwd;
else
    userpath   = input('Please enter the desired directory','s');
    cd (userpath)
end

save('config.mat','step','minprom','mindist','startfreq','endfreq',...
    'sweep','sweepspeed');