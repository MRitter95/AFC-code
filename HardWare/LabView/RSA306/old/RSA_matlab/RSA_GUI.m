function varargout = RSA_GUI(varargin)
% RSA_GUI MATLAB code for RSA_GUI.fig
%      RSA_GUI, by itself, creates a new RSA_GUI or raises the existing
%      singleton*.
%
%      H = RSA_GUI returns the handle to a new RSA_GUI or the handle to
%      the existing singleton*.
%
%      RSA_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RSA_GUI.M with the given input arguments.
%
%      RSA_GUI('Property','Value',...) creates a new RSA_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RSA_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RSA_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RSA_GUI

% Last Modified by GUIDE v2.5 17-Mar-2017 13:36:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RSA_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @RSA_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before RSA_GUI is made visible.
function RSA_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RSA_GUI (see VARARGIN)

% Choose default command line output for RSA_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes RSA_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RSA_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear all
clc

a = instrfind;
delete(a)
clear a

visa_brand = 'tek';
visa_address_rsa = 'GPIB8::1::INSTR';
buffer = 1000 * 1024;
rsa = visa(visa_brand, visa_address_rsa, 'InputBufferSize', buffer, ...
      'OutputBufferSize', buffer);
fopen(rsa);
%get(rsa)
dataAccum = [];
pts = [801  2401  4001  8001 10401 16001 32001 64001]; % but only these actually work
whichpt = 2;
   fwrite(rsa, ['SENSE:SPECTRUM:POINTS:COUNT P', num2str(pts(whichpt))]);
   SpecPts = query(rsa, 'SENSE:SPECTRUM:POINTS:COUNT?');
   fwrite(rsa, 'SENSe:IQVTime:MAXTracepoints NEV');%%%%%%%%%%%%%%%%%%%
   fwrite(rsa, 'SENSe:ANALysis:LENGth 4ms'); 
   AnalLength = query(rsa, 'SENSe:ANALysis:LENGth:ACT?'); 
   fprintf('Num of Spectrum Pts= %s  Analysis Length(s) %s',SpecPts,AnalLength);
   fwrite(rsa, 'SENSe:IQVTime:MAXTracepoints ONEK');%%%%%%%%%%%%%%%%%%%
   query(rsa, 'SENSe:IQVTime:MAXTracepoints?');%%%%%%%%%%%%%%%%%%%
   %fprintf('\nNum of Spectrum Pts= %f  \nAnalysis Length(s) %f',SpecPts,AnalLength);
   for j =1:10
    fwrite(rsa, 'FETCH:SPECTRUM:TRACE1?');
    [data,datacount] = binblockread(rsa,'float');
    datraw = query(rsa, 'FETCH:SPECTRUM:TRACE1?');

    fwrite(rsa,'FETCH:IQVTime:I?');
    [dataIbin,dataIbincount] = binblockread(rsa,'float');
    datIraw = query(rsa,'FETCH:IQVTime:I?'); 
    fwrite(rsa,'FETCH:IQVTime:Q?');
    dataQbin = binblockread(rsa,'float');
    
    fprintf('trace %d, length of IQVT %d \n',j, length(dataIbin));%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure(1)
        subplot(2,1,1)
        hold off
        plot(dataIbin);
        hold on
        plot(dataQbin);
% dataI = (query(rsa,'READ:IQVTime:I?'));%%%%%%%%%%%%%%%%
% length(dataI)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Start_Freq = str2double(query(rsa, 'SENSE:SPECTRUM:FREQUENCY:START?'));
    Start_Freq = Start_Freq./1e6;
    Stop_Freq = str2double(query(rsa, 'SENSE:SPECTRUM:FREQUENCY:STOP?'));
    Stop_Freq = Stop_Freq./1e6;
    Freq = linspace(Start_Freq, Stop_Freq, pts(whichpt))';
    
    if j == 1
        dataAccum = data;
    else
        dataAccum = dataAccum*(j-1)/j + data/j;
    end
    
    subplot(2,1,2)
    hold off
    plot(Freq, data)
    hold on
    plot(Freq, dataAccum,'-r')
    xlim([Start_Freq Stop_Freq]);
    %ylim([-100 -30]);
    ylabel('Power (dBm)'); xlabel('Frequency (MHz)');
    title(sprintf('Accumulated %d traces', j));
    drawnow
    shg
    
    % Calculate RF Power
%     Powerdbm = 10*log10(10*(dataIbin.^2 + dataQbin.^2));
%     figure (2)
%     plot(Powerdbm)

end
toc






% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fclose(rsa);
delete(rsa);
clear rsa;
