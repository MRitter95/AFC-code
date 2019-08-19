clc
clear all

% addpath('.')
addpath('C:\Users\Lab\Desktop\RSA_matlab')
% addpath('C:\Program Files\Tektronix\SignalVu-PC\RSA')
addpath('C:\Tektronix\RSA_API\lib\x64')
% addpath('C:\Tektronix\RSA_API\include')

% unloadlibrary('RSA300API')

libisloaded('RSA300API')
libisloaded('RSA_API')
% loadlibrary('RSA_API')
% loadlibrary('RSA300API_thunk_pcwin64','RSA300API.h')
RSA = icdevice('RSA306_Driver_3_4_0253')

libisloaded('RSA300API')
libisloaded('RSA_API')

% RSA300API_prototype_pcwin64
% DEVICE_Search
% openDevice(RSA)
% get(RSA,'Identify')
% Search(RSA)
connect(RSA)
% disconnect(RSA)
% delete(RSA)
% clear('RSA')