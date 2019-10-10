for i=1:20
figure(i)
hold on
for j=1:10
plot(difference{j+(i-1)*10}(1:end-1))
end
title(sprintf('Starting at %.1f MHz going to %.1f MHz',(i-1)+0.1,i))
legend({folders(1+10*(i-1):10+10*(i-1)).name})
end