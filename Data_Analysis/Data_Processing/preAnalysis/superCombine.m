function []=superCombine(exptype, userpath)
startpath=pwd;
if(nargin<1)
    disp(['Using the current directory: ' pwd ])
    pathOK=input('Is that ok (Y/N)?','s');
    if(strcmp(pathOK,'Y'))
        userpath=pwd;
    else
        userpath=input('Please enter the desired directory','s');
    end
    exptype=input('afc or echo data?','s');
end
cd(userpath)
cd('0')
combineFiles(exptype, fullfile(userpath, '0\'), 600, 1)
cd('../1')
combineFiles(exptype, fullfile(userpath, '1\'), 600, 1)

cd(startpath)