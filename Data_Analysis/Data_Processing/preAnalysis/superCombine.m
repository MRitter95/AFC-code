function []=superCombine(userpath)
if(nargin<1)
    userpath=pwd;
    disp(['No directory provided, using current directory: ' pwd])
end
cd(userpath)
cd('0')
combineFiles()
cd('../1')
combineFiles()