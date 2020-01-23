cd C:\Users\labadmin\Desktop\Data\CavityPressure
format ='%d-%d-%d %d:%d:%f\t%f';
fID=fopen('2019-12-09.txt');
rawdata=fscanf(fID, format, [7,Inf]);

pressure=rawdata(7,:);
init=rawdata(:,1);
mins=60;
hours=60*mins;
days=24*hours;
months=30*days;
years=365*days;
time=(rawdata(1,:)-init(1))*years+(rawdata(2,:)-init(2))*months+(rawdata(3,:)...
    -init(3))*days+(rawdata(4,:)-init(4))*hours+(rawdata(5,:)-init(5))*mins+(rawdata(6,:)-init(6));
figure
plot(time,pressure);
ylim([0,5]);