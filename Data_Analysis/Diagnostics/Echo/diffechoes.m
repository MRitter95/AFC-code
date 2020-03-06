
function [ints] = diffechoes (userpath)

currentdir=pwd;
if(nargin<1)
    disp(['Using the current directory: ' pwd ])
    pathOK=input('Is that ok (Y/N)?','s');
    if(strcmp(pathOK,'Y'))
        userpath=pwd;
    else
        userpath=input('Please enter the desired directory: ','s');
    end
end
disp(['Processing data from: ' userpath])
cd (userpath)

files=dir('C1*.trc');

init=ReadLeCroyBinaryWaveform(files(end).name);
[p,l,w]=findpeaks(init.y,'MinPeakProminence',0.03,...
    'MinPeakHeight', 0.04,'MinPeakDistance', 1000);
startpts=l-round(w);
endpts=l+round(w);
ints=zeros(length(p),length(files));
for i=1:length(files)
wave=ReadLeCroyBinaryWaveform(files(i).name);
    for j=1:length(p)
        ints(j,i)=trapz(wave.y(startpts(j):endpts(j)));
    end
end

cd(currentdir)