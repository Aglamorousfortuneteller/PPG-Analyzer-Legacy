function varargout = ppganalyzer(varargin)
% PPGANALYZER MATLAB code for ppganalyzer.fig
% Edit the above text to modify the response to help ppganalyzer

% Last Modified by GUIDE v2.5 15-Jun-2018 04:59:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ppganalyzer_OpeningFcn, ...
                   'gui_OutputFcn',  @ppganalyzer_OutputFcn, ...
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

% --- Executes just before ppganalyzer is made visible.
function ppganalyzer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ppganalyzer (see VARARGIN)

% Choose default command line output for ppganalyzer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using ppganalyzer.
if strcmp(get(hObject,'Visible'),'off')
end
set(handles.pushbutton3, 'UserData', 0);

% UIWAIT makes ppganalyzer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ppganalyzer_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
cla(handles.axes1)
cla(handles.axes2)
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folderproject=pwd;
cd(folderproject)
axes(handles.axes1);
popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
case 1
cd(folderproject)
cd programfiles
load('command.mat')
folder=sprintf('%s',file);
cd(folderproject)
cd processeddata
cd(folder)
load('signal.mat')
cd(folderproject)
plot(Time,Mesure,'Color',[.61 .51 .74]);
str1 = sprintf('The graph of the %s signal', file);
title(str1,'FontSize',14);
R=length(Mesure)/Fs;
xlim([0 R]);
grid on;
xlabel('time, sec') % x-axis label
ylabel('amplitude, Volt') % y-axis label
DATA=Mesure;
Time=Time;
Fs=Fs;
    case 2
cd(folderproject)
cd programfiles
load('command.mat')
folder=sprintf('%s',file);
cd(folderproject)
cd processeddata
cd(folder)
load('filtered.mat')
cd(folderproject)
plot(Time,band_pass_data,'Color',[.61 .51 .74]);
str2 = sprintf('The graph of the filtered %s signal', file);
title(str2,'FontSize',14);
R=length(band_pass_data)/Fs;
xlim([0 R]);
grid on;
xlabel('time, sec') % x-axis label
ylabel('amplitude, Volt') % y-axis label
DATA=band_pass_data;
Time=Time;
Fs=Fs;
    case 3
cd(folderproject)
cd programfiles
load('command.mat')
folder=sprintf('%s',file);
cd(folderproject)
cd processeddata
cd(folder)
load('denoised.mat')
variables = who('-file', 'denoised.mat');
isitThere = ismember('denoised', variables);
    if(isitThere == 1)
plot(Time,denoised,'Color',[.61 .51 .74]);
str3 = sprintf('The graph of the wavelet processed %s signal', file);
title(str3,'FontSize',14);
R=length(denoised)/Fs;
xlim([0 R]);
grid on;
xlabel('time, sec') % x-axis label
ylabel('amplitude, Volt') % y-axis label
DATA=denoised;
Time=Time;
Fs=Fs;
    else
fff = msgbox('Use wavelet to process data first', 'Error','error');
cla(handles.axes1)
DATA=0;
Time=0;
Fs=0;
    end
end
cd(folderproject)
cd programfiles
save('prf.mat','DATA','Time','Fs')
cd(folderproject)
dcm_obj = datacursormode;
set(dcm_obj,'UpdateFcn',@myupdatefcn)

% Click on line to select data point

function txt = myupdatefcn(empt,event_obj)
pos = get(event_obj,'Position');
txt = {['time: ',num2str(pos(1),4)],...
    ['amplitude: ',num2str(pos(2),4)]};


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
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

set(hObject, 'String', {'signal', 'filtered', 'denoised'});



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
folderproject=pwd;
cd(folderproject)
axes(handles.axes2);
cd programfiles
load('prf.mat')
cd(folderproject)
 A = get(handles.edit1,'String'); %edit1 being Tag of ur edit box
 if isempty(A)
   aaa = msgbox('Enter Text first', 'Error','error');
 else
   A=str2double(A);
 end
 B = get(handles.edit2,'String'); %edit1 being Tag of ur edit box
 if isempty(B)
   bbb = msgbox('Enter Text first', 'Error','error');
 else
   B=str2double(B);
 end
start=A;
ending=B;
idx = (Time>start-1/Fs) & (Time<ending);
time1=(start:1/Fs:ending)';
out1 = DATA(idx);
pks=findpeaks(out1(1:(round(0.5*(length(out1))))));
minimums=-1*findpeaks(-1*(out1(1:(find(out1==pks(1))))));
if(length(minimums)==0)
mmm = msgbox('Impossible to recognise pulse wave, choose another one', 'Error','error');
else
systolic_amplitude=abs(pks(1)-minimums(1));
set(handles.edit3, 'String', systolic_amplitude);
sys_time=time1(find(out1==pks(1)));
pulse_start=time1(find(out1==max(minimums)));
crest_time=sys_time-pulse_start;
set(handles.edit6, 'String',crest_time);
pks1=findpeaks(out1((round(0.5*(length(out1)))):(length(out1))));
dicrotic_amplitude=abs(max(pks1)-minimums(1));
set(handles.edit4, 'String', dicrotic_amplitude);
dic_time=time1(find(out1==max(pks1)));
dicrotic_amplitude_low=min((-1*findpeaks(-1*(out1(find(out1==pks(1)):find(out1==max(pks1)))))))-max(minimums);
dic_time_low=time1(find(out1==min((-1*findpeaks(-1*(out1(find(out1==pks(1)):find(out1==max(pks1)))))))));
dicrotic_wave_time_low=dic_time_low-pulse_start;
dicrotic_wave_time=dic_time-pulse_start;
set(handles.edit7, 'String',dicrotic_wave_time);
minimums2=-1*findpeaks(-1*(out1((find(out1==max(pks1)):(find(out1==out1(length(out1))))))));
if(length(minimums2)==0)
mmmm = msgbox('Impossible to recognise pulse wave, choose another one', 'Error','error');
else
pulse_end=time1(find(out1==max(minimums2)));
total_pulse_duration=pulse_end-pulse_start;
set(handles.edit8, 'String',total_pulse_duration);
out=((systolic_amplitude+out1)/max(systolic_amplitude+out1));
t=time1((out>0.8&out<0.81)==1);
interwave_time=t(length(t))-t(1);
set(handles.edit5, 'String',interwave_time);
plot(time1,out1(1:length(time1)),'Color',[.61 .51 .74])
title('Extracted pulse')
xlim([time1(1) time1(length(time1))]);
ylim([(min(out1)-0.25) (max(out1)+0.1)]);
grid on;
xlabel('time, sec') % x-axis label
ylabel('amplitude, Volt') % y-axis label
hold on
plot([sys_time sys_time], [minimums(1) pks(1)],'k') % Plot Vertical Line
text(sys_time,((pks(1)-(pks(1)+abs(minimums(1))/2))),'SA')
plot([pulse_start sys_time], [minimums(1) minimums(1)],'k')
text(((sys_time+pulse_start)/2),minimums(1)+.05,'CT')
plot([dic_time dic_time], [minimums(1) max(pks1)],'k')
text(dic_time-.01,((max(pks1)-abs(minimums(1))/3)),'DA(a)')


plot([dic_time_low dic_time_low], ...
    [max(minimums) min((-1*findpeaks(-1*(out1(find(out1==pks(1)):find(out1==max(pks1)))))))],'k')
text(dic_time_low-.01,((max(pks1)-abs(minimums(1))/2)),'DA(b)')

plot([pulse_start dic_time], [minimums(1) minimums(1)],'k:')
plot([pulse_start dic_time], [minimums(1)-.08 minimums(1)-.08],'k')
text(((dic_time+pulse_start)/2),minimums(1)-.04,'DWT')
plot([pulse_start pulse_end], [minimums(1)-.19 minimums(1)-.19],'k')
text(((pulse_end+pulse_start)/2),minimums(1)-.15,'TPD')
plot([pulse_start pulse_start], [minimums(1) minimums(1)-.19],'k:')
plot([dic_time dic_time], [max(pks1) minimums(1)-.08],'k:')
plot([pulse_end pulse_end], [minimums2(1) minimums(1)-.19],'k:')
plot([t(1) t(length(t))], ...
 [max(out1(find((out>0.8&out<0.81)==1))) max(out1(find((out>0.8&out<0.81)==1)))],'k-.')
text(((t(length(t))+t(1))/2),max(out1(find((out>0.8&out<0.81)==1)))+.05,'Iwt')
hold off

relative_crest_time=crest_time/total_pulse_duration;
set(handles.edit9, 'String',relative_crest_time);
interwave_distance=interwave_time/total_pulse_duration;
set(handles.edit10, 'String',interwave_distance);
relative_dicrotic_wave_amplitude=dicrotic_amplitude/systolic_amplitude;
set(handles.edit11, 'String',relative_dicrotic_wave_amplitude);
time_delay_parameter=dic_time-crest_time;
set(handles.edit12, 'String',time_delay_parameter);
set(handles.edit13, 'String',dicrotic_amplitude_low);
set(handles.edit14, 'String',dicrotic_wave_time_low);

cd(folderproject)
cd programfiles
save('exwavedat.mat','out1','time1')
save('extdata.mat','systolic_amplitude','crest_time','dicrotic_amplitude',...
    'dicrotic_wave_time','interwave_time','total_pulse_duration',...
    'relative_crest_time','interwave_distance',...
    'relative_dicrotic_wave_amplitude','time_delay_parameter', ...
    'dicrotic_amplitude_low','dicrotic_wave_time_low')
cd(folderproject)
end
end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

counter = get(hObject, 'UserData') + 1;
set(hObject, 'UserData', counter);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folderproject=pwd;
cd(folderproject)
cd programfiles
load('exwavedat.mat','out1','time1')
load('extdata.mat','systolic_amplitude','crest_time','dicrotic_amplitude',...
    'dicrotic_wave_time','interwave_time','total_pulse_duration',...
    'relative_crest_time','interwave_distance',...
    'relative_dicrotic_wave_amplitude','time_delay_parameter', ...
    'dicrotic_amplitude_low','dicrotic_wave_time_low');
load('command.mat');
folder=sprintf('%s',file);
cd(folderproject)
cd processeddata
cd(folder)
mkdir extracteddata
cd extracteddata
fname = sprintf('extracteddata%d.mat', counter);
save(fname,'systolic_amplitude','crest_time','dicrotic_amplitude',...
    'dicrotic_wave_time','interwave_time','total_pulse_duration',...
    'relative_crest_time','interwave_distance',...
    'relative_dicrotic_wave_amplitude','time_delay_parameter','dicrotic_amplitude_low','dicrotic_wave_time_low');
cd(folderproject)
cd processeddata
cd(folder)
mkdir waves
cd waves
wavename= sprintf('wave%d.mat', counter);
save(wavename,'out1','time1')
cd(folderproject)


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, ~)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folderproject=pwd;
cd(folderproject)
cd programfiles
load('command.mat')
folder=sprintf('%s',file);
cd(folderproject)
cd processeddata
cd(folder)
if ~exist('waves', 'dir')
    warning('Directory "waves" does not exist. Creating it now.');
    mkdir('waves');
end
cd('waves')

y=dir('*.mat');
for j=1:length(y)
W(j)=load(['wave' num2str(j) '.mat']);
end
cd(folderproject)
cd processeddata
cd(folder)
filefullname=sprintf('wavesfull%s',file);
save(filefullname,'W')
cd(folderproject)
close ppganalyzer
