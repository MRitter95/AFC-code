%This script plots the output from the plotdifs script. The script expects
%the workspace to be saved from the result of the computation (this could
%probably be improved but it's how it works for now)

disp(['Using the current directory: ' pwd ]);
pathOK=input('Is that ok (Y/N)?','s');
if(strcmp(pathOK,'Y'))
    userpath=pwd;
else
    userpath=input('Please enter the desired directory','s');
end
load('plotdiff_output.mat')
for i=1:20 %Go through 20 frequencies
    for j=1:10 %Show slices of 1MHz at a time
        %depending on data, might want to skip first or last entry
        figure(2*i)
        hold on
        plot(log10(diff{j+(i-1)*10}(1:end-1))) 
        figure(2*i+1)
        hold on
        plot(log10(difflast{j+(i-1)*10}(1:end-1))) 
    end
    title(sprintf(strcat(expdate,' Starting at %.1f MHz going to %.1f MHz'),(i-1)+0.1,i))
    axis([-inf,inf,-inf,inf])
    legend({folders(1+10*(i-1):10+10*(i-1)).name})
end