function varargout = statisticstool(varargin)
% STATISTICSTOOL MATLAB code for statisticstool.fig
%      STATISTICSTOOL, by itself, creates a new STATISTICSTOOL or raises the existing
%      singleton*.
%
%      H = STATISTICSTOOL returns the handle to a new STATISTICSTOOL or the handle to
%      the existing singleton*.
%
%      STATISTICSTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STATISTICSTOOL.M with the given input arguments.
%
%      STATISTICSTOOL('Property','Value',...) creates a new STATISTICSTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before statisticstool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to statisticstool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help statisticstool

% Last Modified by GUIDE v2.5 21-Jun-2018 05:41:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @statisticstool_OpeningFcn, ...
                   'gui_OutputFcn',  @statisticstool_OutputFcn, ...
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


% --- Executes just before statisticstool is made visible.
function statisticstool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to statisticstool (see VARARGIN)

% Choose default command line output for statisticstool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes statisticstool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = statisticstool_OutputFcn(hObject, eventdata, handles) 
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
folderproject=pwd;
cd(folderproject)
[filestat,folderpathstat] = uigetfile({'*.mat'},...
    'Select a signal file to show statistics');
if isequal(filestat,0)
   f = msgbox('Select a file!', 'Error','error');
else
   disp([fullfile(path,filestat)]);
end
selectedfilestat = fullfile(folderpathstat,filestat);
commandstat = sprintf('load(''%s'')', selectedfilestat);
evalin('base', commandstat);
cd(folderproject)
cd programfiles
save('commandstat.mat');
load(selectedfilestat,'-mat');
folderstat=sprintf('%s',filestat);
cd(folderproject)
cd processeddata
cd(folderstat)
load(['wavesfull' num2str(filestat)]);
cd extracteddata
load('full.mat');
cd(folderproject)
figure
n=length(W);
a=1:0.1:10;
folderstat=sprintf('%s',filestat);
cd(folderproject)
cd processeddata
cd(folderstat)
cd extracteddata
for i=1:n
A=load('full.mat','%s',['crest_time' num2str(i)]);
Crest_time(i)=getfield(A,['crest_time' num2str(i)]);
plottext1=['Crest time=' num2str(Crest_time(i))];

B=load('full.mat','%s',['dicrotic_amplitude' num2str(i)]);
DA(i)=getfield(B,['dicrotic_amplitude' num2str(i)]);
plottext2=['Dicrotic Amplitude=' num2str(DA(i))];

C=load('full.mat','%s',['dicrotic_amplitude_low' num2str(i)]);
DN(i)=getfield(C,['dicrotic_amplitude_low' num2str(i)]);
plottext3=['Dicrotic notch=' num2str(DN(i))];

D=load('full.mat','%s',['dicrotic_wave_time' num2str(i)]);
DWT(i)=getfield(D,['dicrotic_wave_time' num2str(i)]);
plottext4=['Dicrotic wave time=' num2str(DWT(i))];

E=load('full.mat','%s',['dicrotic_wave_time_low' num2str(i)]);
DNT(i)=getfield(E,['dicrotic_wave_time_low' num2str(i)]);
plottext5=['Dicrotic notch time=' num2str(DNT(i))];

F=load('full.mat','%s',['interwave_distance' num2str(i)]);
IntD(i)=getfield(F,['interwave_distance' num2str(i)]);
plottext6=['Interwave distance=' num2str(IntD(i))];

G=load('full.mat','%s',['interwave_time' num2str(i)]);
IntT(i)=getfield(G,['interwave_time' num2str(i)]);
plottext7=['Interwave time=' num2str(IntT(i))];

H=load('full.mat','%s',['relative_crest_time' num2str(i)]);
Rct(i)=getfield(H,['relative_crest_time' num2str(i)]);
plottext8=['Related crest time=' num2str(Rct(i))];

J=load('full.mat','%s',['relative_dicrotic_wave_amplitude' num2str(i)]);
RDWa(i)=getfield(J,['relative_dicrotic_wave_amplitude' num2str(i)]);
plottext9=['Related dicrotic wave \newline amplitude=' num2str(RDWa(i))];

K=load('full.mat','%s',['systolic_amplitude' num2str(i)]);
SA(i)=getfield(K,['systolic_amplitude' num2str(i)]);
plottext10=['Systolic Amplitude=' num2str(SA(i))];

L=load('full.mat','%s',['time_delay_parameter' num2str(i)]);
Tdp(i)=getfield(L,['time_delay_parameter' num2str(i)]);
plottext11=['Time delay parameter=' num2str(Tdp(i))];

M=load('full.mat','%s',['total_pulse_duration' num2str(i)]);
TPD(i)=getfield(M,['total_pulse_duration' num2str(i)]);
plottext12=['Total pulse duration=' num2str(TPD(i))];
    row1=subplot(3,n,i);
    plot(W(i).time1,W(i).out1(1:length(W(i).time1)), 'Color',[.61 .51 .74])
    xlim([W(i).time1(1) W(i).time1(length(W(i).time1))]);
ylim([(min(W(i).out1)-0.25) (max(W(i).out1)+0.1)]);
grid on
    p=i+n;
    row2=subplot(3,n,p);
text(-0.1,1.1,plottext10,'FontSize',7);
text(-0.1,1,plottext1,'FontSize',7);
text(-0.1,0.9,plottext2,'FontSize',7);
text(-0.1,0.8,plottext3,'FontSize',7);
text(-0.1,.7,plottext4,'FontSize',7);
text(-0.1,.6,plottext5,'FontSize',7);
text(-0.1,.5,plottext6,'FontSize',7);
text(-0.1,.4,plottext7,'FontSize',7);
text(-0.1,.3,plottext8,'FontSize',7);
text(-0.1,.15,plottext9,'FontSize',7);
text(-0.1,0,plottext11,'FontSize',7);
text(-0.1,-.1,plottext12,'FontSize',7);
axis off
end
subplot(3,n,2*i+1)
text(-0.1,1.15,'Mean value','FontWeight','bold');
text(-0.1,1.05,['Systolic wave amplitude mean value=' num2str(mean_sys)],'FontSize',8);
text(-0.1,.95,['Dicrotic wave amplitude mean value=' num2str(mean_dicrotic_ampl)],'FontSize',8);
text(-0.1,.85,['Dicrotic notch amplitude mean value=' num2str(mean_dicrotic_ampl_low)],'FontSize',8);
text(-0.1,.75,['Dicrotic wave time mean value=' num2str(mean_dicrotic_wave_t)],'FontSize',8);
text(-0.1,.65,['Dicrotic notch time mean value=' num2str(mean_dicrotic_wave_tl)],'FontSize',8);
text(-0.1,.55,['Interwave distance mean value=' num2str(mean_interwave_distance)],'FontSize',8);
text(-0.1,.45,['Interwave time mean value=' num2str(mean_interwave_time)],'FontSize',8);
text(-0.1,.35,['Relative crest time mean value=' num2str(mean_relative_crest_time)],'FontSize',8);
text(-0.1,.22,['Relative dicrotic wave \newline amplitude mean value=' num2str(mean_relative_dicrotic_wave_amplitude)],'FontSize',8);
text(-0.1,.08,['Crest time mean value=' num2str(mean_rest_time)],'FontSize',8);
text(-0.1,-.02,['Time delay parameter mean value=' num2str(mean_time_delay_parameter)],'FontSize',8);
text(-0.1,-.12,['Total pulse duration mean value=' num2str(mean_total_pul)],'FontSize',8);
axis off
subplot(3,n,3*i-round(n/1.5))
text(n/4,1.15,'Standart deviation value','FontWeight','bold');
text(n/4,1.05,['Systolic wave amplitude standart deviation value='...
    num2str(std_sys)],'FontSize',8);
text(n/4,.95,['Dicrotic wave amplitude standart deviation value='...
    num2str(std_dicrotic_ampl)],'FontSize',8);
text(n/4,.85,['Dicrotic notch amplitude standart deviation value='...
    num2str(std_dicrotic_ampl_low)],'FontSize',8);
text(n/4,.75,['Dicrotic wave time standart deviation value='...
    num2str(std_dicrotic_wave_t)],'FontSize',8);
text(n/4,.65,['Dicrotic notch time standart deviation value='...
    num2str(std_dicrotic_wave_tl)],'FontSize',8);
text(n/4,.55,['Interwave distance standart deviation value='...
    num2str(std_interwave_distance)],'FontSize',8);
text(n/4,.45,['Interwave time standart deviation value='...
    num2str(std_interwave_time)],'FontSize',8);
text(n/4,.35,['Relative crest time standart deviation value='...
    num2str(std_relative_crest_time)],'FontSize',8);
text(n/4,.22,['Relative dicrotic wave \newline amplitude standart deviation value='...
    num2str(std_relative_dicrotic_wave_amplitude)],'FontSize',8);
text(n/4,.08,['Crest time standart deviation value='...
    num2str(std_rest_time)],'FontSize',8);
text(n/4,-.02,['Time delay parameter standart deviation value='...
    num2str(std_time_delay_parameter)],'FontSize',8);
text(n/4,-.12,['Total pulse duration standart deviation value='...
    num2str(std_total_pul)],'FontSize',8);
axis off
subplot(3,n,3*i)
text(-n/5,1.15,'Max value   Min value','FontWeight','bold');
text(-n/5,1.05,['Systolic wave amplitude max value=' num2str(max_sys)...
    '   min value=' num2str(min_sys)],'FontSize',8);
text(-n/5,.95,['Dicrotic wave amplitude max value=' num2str(max_dicrotic_ampl)...
    '   min value=' num2str(min_dicrotic_ampl)],'FontSize',8);
text(-n/5,.85,['Dicrotic notch amplitude max value=' num2str(max_dicrotic_ampl_low)...
    '   min value=' num2str(min_dicrotic_ampl_low)],'FontSize',8);
text(-n/5,.75,['Dicrotic wave time max value=' num2str(max_dicrotic_wave_t)...
    '   min value=' num2str(min_dicrotic_wave_t)],'FontSize',8);
text(-n/5,.65,['Dicrotic notch time max value=' num2str(max_dicrotic_wave_tl)...
    '   min value=' num2str(min_dicrotic_wave_tl)],'FontSize',8);
text(-n/5,.55,['Interwave distance max value=' num2str(max_interwave_distance)...
    '   min value=' num2str(min_interwave_distance)],'FontSize',8);
text(-n/5,.45,['Interwave time max value=' num2str(max_interwave_time)...
    '   min value=' num2str(min_interwave_time)],'FontSize',8);
text(-n/5,.35,['Relative crest time max value=' num2str(max_relative_crest_time)...
    '   min value=' num2str(min_relative_crest_time)],'FontSize',8);
text(-n/5,.25,['Relative dicrotic wave amplitude max value=' num2str(max_relative_dicrotic_wave_amplitude)...
    '   min value=' num2str(min_relative_dicrotic_wave_amplitude)],'FontSize',8);
text(-n/5,.15,['Crest time max value=' num2str(max_rest_time)...
    '   min value=' num2str(min_rest_time)],'FontSize',8);
text(-n/5,.05,['Time delay parameter max value=' num2str(max_time_delay_parameter)...
    '   min value=' num2str(min_time_delay_parameter)],'FontSize',8);
text(-n/5,-0.05,['Total pulse duration max value=' num2str(max_total_pul)...
    '   min value=' num2str(min_total_pul)],'FontSize',8);
axis off
set(gcf, 'Position', get(0, 'Screensize'));
ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0  1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');
T=text(0.45, 0.98,['Statistics for ' num2str(filestat) ' signal']);
s = T.FontWeight;
T.FontWeight = 'bold';
T.FontSize=14;
cd(folderproject)
clear all
clc
dcm_obj = datacursormode;
set(dcm_obj,'UpdateFcn',@myupdatefcn)

