freqs= 0.1:0.1:20;

figure(1)
hold on

ofcs= [];
for j=1:200
    blah= readbin(strcat('ofc',num2str(j/10,'%0.1f'),'MHz.bin'),'false');
    ofcs= [ofcs;avgByNs(blah.y',25)'];
    plot(blah.x,blah.y+400*freqs(j)-min(blah.y),'Color',[0,0.4470,0.7410]);
end
yticks(freqs*400);
yticklabels(freqs);

%%
f= avgByNs(blah.x',25)';

figure(2)
xlim([0.05,3.25]);
hold on

echoVals= zeros(200,200);
timeVals= zeros(1,200);
markerSizes= timeVals;
for j=1:200
    [t,echo,echoVal,timeVal,markerSize]= echoFromComb(f,ofcs(j,:));
    echoVals(j,:)= echoVal;
    timeVals(j)= timeVal;
    markerSizes(j)= markerSize;
    plot(t,echo+(2e-8)*freqs(j),'Color',[0,0.4470,0.7410]);
end
yticks(freqs*2e-8);
yticklabels(freqs);

%%
markerSizes= markerSizes/max(markerSizes);

figure(3)
plot(freqs,markerSizes);

%%
figure(4)
hold on
xlim([0,21]);
ylim([0,3.5]);
markerSizes= 500*markerSizes;
time= 1./f;
for i=1:10
    plot(f,i*time,...
        f,time/i,'Color',0.1*(i-1)*[1,1,1],'LineWidth',2/i);
end
scatter(freqs,timeVals,markerSizes,'MarkerEdgeColor',...
    [0,0.4470,0.7410],'LineWidth',1.5);

%%
figure(5)
echoVals= flipud(echoVals'/max(echoVals,[],'all'));
map= cat(3,1-1*echoVals,1-0.5530*echoVals,1-0.259*echoVals);
imshow(map)
pbaspect([1 1 1])