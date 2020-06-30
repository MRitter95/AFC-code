freqs= 0.1:0.1:20;

figure(6)
hold on

rfcs= [];
for j=1:200
    meh= readbin(strcat('rfc',num2str(j/10,'%0.1f'),'MHz.bin'),'false');
    rfcs= [rfcs;avgByNs(meh.y',25)'];
    plot(meh.x,meh.y+400*freqs(j)-min(meh.y),'Color',[0.85,0.3250,0.0980]);
end
yticks(freqs*400);
yticklabels(freqs);

%%
f= avgByNs(meh.x',25)';

figure(7)
xlim([0.05,3.25]);
hold on

echoVals= zeros(200,200);
timeVals= zeros(1,200);
markerSizes= timeVals;
for j=1:200
    [t,echo,echoVal,timeVal,markerSize]= echoFromComb(f,rfcs(j,:));
    echoVals(j,:)= echoVal;
    timeVals(j)= timeVal;
    markerSizes(j)= markerSize;
    plot(t,echo+(2e-8)*freqs(j),'Color',[0.85,0.3250,0.0980]);
end
yticks(freqs*2e-8);
yticklabels(freqs);

%%
markerSizes= markerSizes/max(markerSizes);

figure(8)
plot(freqs,markerSizes,'Color',[0.85,0.3250,0.0980]);

%%
figure(9)
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
    [0.85,0.3250,0.0980],'LineWidth',1.5);

%%
figure(10)
echoVals= flipud(echoVals'/max(echoVals,[],'all'));
map= cat(3,1-0.15*echoVals,1-0.675*echoVals,1-0.902*echoVals);
imshow(map)
pbaspect([1 1 1])