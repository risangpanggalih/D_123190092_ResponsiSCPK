function varargout = ResponsiSAW_123190092_D(varargin)
% RESPONSISAW_123190092_D MATLAB code for ResponsiSAW_123190092_D.fig
%      RESPONSISAW_123190092_D, by itself, creates a new RESPONSISAW_123190092_D or raises the existing
%      singleton*.
%
%      H = RESPONSISAW_123190092_D returns the handle to a new RESPONSISAW_123190092_D or the handle to
%      the existing singleton*.
%
%      RESPONSISAW_123190092_D('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSISAW_123190092_D.M with the given input arguments.
%
%      RESPONSISAW_123190092_D('Property','Value',...) creates a new RESPONSISAW_123190092_D or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ResponsiSAW_123190092_D_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ResponsiSAW_123190092_D_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ResponsiSAW_123190092_D

% Last Modified by GUIDE v2.5 26-Jun-2021 06:28:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ResponsiSAW_123190092_D_OpeningFcn, ...
                   'gui_OutputFcn',  @ResponsiSAW_123190092_D_OutputFcn, ...
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


% --- Executes just before ResponsiSAW_123190092_D is made visible.
function ResponsiSAW_123190092_D_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ResponsiSAW_123190092_D (see VARARGIN)

% Choose default command line output for ResponsiSAW_123190092_D
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ResponsiSAW_123190092_D wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ResponsiSAW_123190092_D_OutputFcn(hObject, eventdata, handles) 
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
opts = detectImportOptions('no2.xlsx');
opts.SelectedVariableNames = (1);
data1 = readmatrix('no2.xlsx',opts);

opts = detectImportOptions('no2.xlsx');
opts.SelectedVariableNames = (3:8);
data2 = readmatrix('no2.xlsx',opts);

data = [data1 data2];
set(handles.uitable1,'data',data);


opts = detectImportOptions('no2.xlsx');
opts.SelectedVariableNames = (3:8);
x = readmatrix('no2.xlsx',opts);
k=[0,1,1,1,1,1]; %atribut tiap-tiap kriteria
w=[0.30,0.20,0.23,0.10,0.07,0.10]; %Nilai bobot tiap kriteria

%Normalisasi matriks
[m n]=size (x); %matriks m x n dengan ukuran sebanyak variabel x (input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
for j=1:n,
    if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
        R(:,j)=x(:,j)./max(x(:,j));
    else
        R(:,j)=min(x(:,j))./x(:,j);
    end;
end;

%Proses perangkingan
for i=1:m,
 V(i)= sum(w.*R(i,:));
end;

VT=V.';
VT=num2cell(VT);
opts = detectImportOptions('no2.xlsx');
opts.SelectedVariableNames = (2);
x2= readtable('no2.xlsx',opts);
x2 = table2cell(x2);
x2=[x2 VT];
x2=sortrows(x2,-2);
x2 = x2(:,1);

set(handles.uitable2, 'data', x2);
