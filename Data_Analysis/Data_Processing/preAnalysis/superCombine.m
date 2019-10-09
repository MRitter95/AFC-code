function []=superCombine(exptype, userpath)
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
combineFiles(exptype, fullfile(userpath, '0\'))
cd('../1')
combineFiles(exptype, fullfile(userpath, '1\'))