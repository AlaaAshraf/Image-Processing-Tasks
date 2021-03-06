function varargout = YinYang(varargin)
% YINYANG MATLAB code for YinYang.fig
%      YINYANG, by itself, creates a new YINYANG or raises the existing
%      singleton*.
%
%      H = YINYANG returns the handle to a new YINYANG or the handle to
%      the existing singleton*.
%
%      YINYANG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in YINYANG.M with the given input arguments.
%
%      YINYANG('Property','Value',...) creates a new YINYANG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before YinYang_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to YinYang_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help YinYang

% Last Modified by GUIDE v2.5 25-Nov-2016 15:17:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @YinYang_OpeningFcn, ...
                   'gui_OutputFcn',  @YinYang_OutputFcn, ...
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


% --- Executes just before YinYang is made visible.
function YinYang_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to YinYang (see VARARGIN)

% Choose default command line output for YinYang
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes YinYang wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = YinYang_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btn_OpenImage.
function btn_OpenImage_Callback(hObject, eventdata, handles)
% hObject    handle to btn_OpenImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imagePath = uigetfile();
handles.Image = imread(imagePath);
% Set current drawing axes to "axes1"
axes(handles.axes1);
% Display the image
imshow(handles.Image);

% Save the handles structure.
guidata(hObject, handles);


% --- Executes on button press in btn_YinYang.??
function btn_YinYang_Callback(hObject, eventdata, handles)
% hObject    handle to btn_YinYang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[YinImage, YangImage] = SplitYinYang(handles.Image);
figure, imshow(YinImage);
figure, imshow(YangImage);
