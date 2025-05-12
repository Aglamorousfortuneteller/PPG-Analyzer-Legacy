function varargout = project(varargin)
% PROJECT MATLAB code for project.fig
% Last Modified by GUIDE v2.5 21-Jun-2018 05:41:33

% --- Initialization code
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @project_OpeningFcn, ...
                   'gui_OutputFcn',  @project_OutputFcn, ...
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

% --- Executes just before project is made visible.
function project_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = project_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
clc;
folderproject = pwd;

[file, folderpath] = uigetfile({'*.mat'}, 'Select a signal file to process');
if isequal(file, 0)
    msgbox('Select a file!', 'Error', 'error');
    return;
end
disp(fullfile(folderpath, file));

% Create folders
if ~exist('programfiles', 'dir')
    mkdir('programfiles');
end
if ~exist('processeddata', 'dir')
    mkdir('processeddata');
end

selectedfile = fullfile(folderpath, file);
command = sprintf('load(''%s'')', selectedfile);
evalin('base', command);

% Save command and file info
cd(folderproject)
cd programfiles
save('command.mat', 'file');
load(selectedfile, '-mat')
save('data.mat', 'Mesure', 'Time', 'Fs')

% Create individual processed data folder
cd(folderproject)
cd processeddata
foldername = file;
if ~exist(foldername, 'dir')
    mkdir(foldername);
else
    warning('Directory already exists: %s', foldername);
end
cd(foldername)
QWERTY = 0;
save('denoised.mat', 'QWERTY');
save('signal.mat', 'Mesure', 'Time', 'Fs')

cd(folderproject)
plot(Time, Mesure, 'Color', [.61 .51 .74])
xlabel('time, sec')
ylabel('amplitude, Volt')
xlim([0 length(Mesure)/Fs])
title(sprintf('The graph of the %s signal', file), 'FontSize', 14)
grid on

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
folderproject = pwd;
cd('programfiles')
load('command.mat')
load('data.mat')
cd(folderproject)
folder = sprintf('%s', file);
W1 = 0.5 / Fs;
W2 = 4 / Fs;
[b, a] = butter(2, [W1, W2]);
band_pass_data = filtfilt(b, a, Mesure);

plot(Time, band_pass_data, 'Color', [.61 .51 .74])
xlabel('time, sec')
ylabel('amplitude, Volt')
xlim([0 length(Mesure)/Fs])
title(sprintf('The graph of the filtered %s signal', file), 'FontSize', 14)
grid on

cd('programfiles')
save('data.mat', 'Mesure', 'band_pass_data', 'Time', 'Fs')

cd(folderproject)
cd processeddata
cd(folder)
save('filtered.mat', 'band_pass_data', 'Time', 'Fs')
cd(folderproject)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
waveletAnalyzer

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
folderproject = pwd;
cd('programfiles')
load('command.mat')
folder = file;
cd(folderproject)
cd processeddata
cd(folder)
load('signal.mat')
load('filtered.mat')
load('denoised.mat')

variables = who('-file', 'denoised.mat');
isThere = ismember('denoised', variables);

if isThere
    denoised = denoised';
    save('denoised.mat', 'denoised', 'Time', 'Fs');
    
    figure(20)
    subplot(3,1,1)
    plot(Time, Mesure, 'Color', [.61 .51 .74])
    title(sprintf('The graph of the %s signal', file), 'FontSize', 14)
    xlabel('time, sec')
    ylabel('amplitude, Volt')
    xlim([0 length(Mesure)/Fs])
    grid on
    
    subplot(3,1,2)
    plot(Time, band_pass_data, 'Color', [.61 .51 .74])
    title(sprintf('The graph of the filtered %s signal', file), 'FontSize', 14)
    xlabel('time, sec')
    ylabel('amplitude, Volt')
    xlim([0 length(Mesure)/Fs])
    grid on
    
    subplot(3,1,3)
    plot(Time, denoised, 'Color', [.61 .51 .74])
    title(sprintf('The graph of the wavelet processed %s signal', file), 'FontSize', 14)
    xlabel('time, sec')
    ylabel('amplitude, Volt')
    xlim([0 length(Mesure)/Fs])
    grid on
else
    figure(20)
    subplot(2,1,1)
    plot(Time, Mesure, 'Color', [.61 .51 .74])
    title(sprintf('The graph of the %s signal', file), 'FontSize', 14)
    xlabel('time, sec')
    ylabel('amplitude, Volt')
    xlim([0 length(Mesure)/Fs])
    grid on
    
    subplot(2,1,2)
    plot(Time, band_pass_data, 'Color', [.61 .51 .74])
    title(sprintf('The graph of the filtered %s signal', file), 'FontSize', 14)
    xlabel('time, sec')
    ylabel('amplitude, Volt')
    xlim([0 length(Mesure)/Fs])
    grid on
end
cd(folderproject)

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
folderproject = pwd;
cd('programfiles')
load('command.mat')
folder = file;
cd(folderproject)
cd processeddata
cd(folder)
load('signal.mat')
load('filtered.mat')
load('denoised.mat')
cd(folderproject)
run('ppganalyzer.m')
