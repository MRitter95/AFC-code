clc
clear all

addpath('C:\Program Files\Microsoft SDKs\Windows\v6.0A\bin')
% addpath('C:\Tektronix\RSA_API\lib\x64')
% addpath('C:\Program Files (x86)\IVI Foundation\IVI\Components\MATLAB\+instrument\+driver')
makemid('RSA306')
RSA = icdevice('RSA306.mdd')


% connect(RSA)
% disconnect(RSA)
% delete(RSA)
% clear('RSA')