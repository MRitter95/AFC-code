% Script to call RFpoweranalysis on all the folders
% Needs to be modified to work in arbitrary folders
threshold=-70;
[modfreqs10, power10]=RFpoweranalysis('10MHz/0', threshold);
[modfreqs20, power20]=RFpoweranalysis('20MHz/0', threshold);
[modfreqs30, power30]=RFpoweranalysis('30MHz/0', threshold);
[modfreqs40, power40]=RFpoweranalysis('40MHz/0', threshold);

figure
hold on
plot(modfreqs10, power10)
plot(modfreqs20, power20)
plot(modfreqs30, power30)
plot(modfreqs40, power40)
legend('10 MHz','20 MHz', '30 MHz', '40 MHz');
title(['RF power with -' num2str(threshold) ' dB threshold'])