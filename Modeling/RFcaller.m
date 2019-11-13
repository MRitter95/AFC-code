% Script to call RFpoweranalysis on all the folders
% Needs to be modified to work in arbitrary folders

function [] = RFcaller(userpath, threshold, isRFC)

if(nargin<1)
    disp(['Using the current directory: ' pwd ])
    pathOK=input('Is that ok (Y/N)?','s');
    if(strcmp(pathOK,'Y')||strcmp(pathOK,'y'))
        userpath=pwd;
    else
        userpath=input('Please enter the desired directory','s');
    end
    RFCstat=input('rfc data? (Y/N)','s');
    if(strcmp(RFCstat,'Y')||strcmp(RFCstat,'y'))
        isRFC='true';
    else
        isRFC='false';
    end
    threshold=input('Threshold');
end

disp(['Processing data from: ' userpath])
cd (userpath)

[modfreqs10, power10]=RFpoweranalysis('10MHz/0', threshold, isRFC);
[modfreqs20, power20]=RFpoweranalysis('20MHz/0', threshold, isRFC);
[modfreqs30, power30]=RFpoweranalysis('30MHz/0', threshold, isRFC);
[modfreqs40, power40]=RFpoweranalysis('40MHz/0', threshold, isRFC);

figure
hold on
if(strcmp(isRFC,'true'))
    plot(modfreqs10, power10.^2)
    plot(modfreqs20, power20.^2)
    plot(modfreqs30, power30.^2)
    plot(modfreqs40, power40.^2)
else
    plot(modfreqs10, power10)
    plot(modfreqs20, power20)
    plot(modfreqs30, power30)
    plot(modfreqs40, power40)
end
legend('10 MHz','20 MHz', '30 MHz', '40 MHz');
title(['RF power with ' num2str(threshold) ' dB threshold'])