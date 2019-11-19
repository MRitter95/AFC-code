%This quick script will plot all the C1 traces with a given name and show
%them on the same plot. 
%Input: userpath, path to traces
%Input: step, vertical shift used to plot consecutive traces
%Output: none, generates a figure

function [] = quickscopeplotter (userpath, step)

%% Get user input
if(nargin<1)
    disp(['Using the current directory: ' pwd])
    pathOK       = input('Is that ok (Y/N)?','s');
    if(strcmp(pathOK,'Y') || strcmp(pathOK,'y'))
        userpath = pwd;
    else
        userpath = input('Please enter the desired directory','s');
    end
    step         = input('Step size (vertical shift on plots)');
end
disp(['Processing data from: ' userpath])

files=dir('C1*.trc');
figure
hold on
for i=1:length(files)
wave=ReadLeCroyBinaryWaveform(files(i).name);
plot(wave.y+1.5*i)
end
