files=dir('afc*.trc');
[~,idx]=sort_nat({files.name});
files= files(idx);

f= linspace(0.1,20,200);

% figure
% hold on

for j=1:length(files)
    data= readbin(files(j).name,true);
%     plot(data.x,data.y+(j-1))

    cd textFiles;
    txtFile= [num2str(j/10,'%0.1f') 'MHz.txt'];
    writematrix(data.x,data.y,txtFile);
end

plot(f,powers27/max(powers27),'*b')