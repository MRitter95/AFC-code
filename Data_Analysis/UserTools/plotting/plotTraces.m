files1= dir('C1*.trc');
files2= dir('C3*.trc');
[~,idx1]=sort_nat({files1.name});
[~,idx2]=sort_nat({files2.name});
files1= files1(idx1);
files2= files2(idx2);

% close all
figure(100)
hold on

% figure(3)
% hold on

%manually found start and end of sweep

% pkhts= zeros(length(files1),1);
for j=1:length(files1)
    echo= ReadLeCroyBinaryWaveform(files1(j).name);
    probe= ReadLeCroyBinaryWaveform(files2(j).name);
% 
%     t= afc.x(lo:hi)-min(afc.x(lo:hi));
%     f= t*160/0.004;
%     y= abs(afc.y(lo:hi)-0.1*log(probe.y(lo:hi)));
%     py= probe.y(lo:hi);
%     ffx= (0:1:length(f)-1)*length(f)/(1.6e8);
%     ffy= abs(fftshift(fft(y)));
%     
%     
    t= echo.x;
    y= echo.y;
    z= probe.y;
%     if j==1
%         spacing= max(y)-min(y);
%     end
    spacing=1;
    
    figure(100)
%     plot(avgByNs(t,10),avgByNs(y,10)+(j-1)*spacing,'r');
%     plot(t,5*smooth(y,14)+(j-1)*spacing,'Color',[0, 0.4470, 0.7410]);
%     plot(t,5*y+(j-1)*spacing,'Color',[0.8500, 0.3250, 0.0980]);
    plot(t,5*smooth(y,100)+(j-1)*spacing,'Color',[0, 0.4470, 0.7410])
    
%     figure(2)
%     plot(t,z+2*(j-1)*spacing,'b');
    
%     figure(3)
%     plot(t,py+1.3*(j-1)*pspacing)
    
%     pkhts(j)= max(afc.y)-min(afc.y);
%     cd textFiles;
%     txtFile= [num2str(j/10,'%0.1f') 'MHz.txt'];
%     writematrix(data.x,data.y,txtFile);
end
