function varargout = simple_gui(varargin)
% SIMPLE_GUI MATLAB code for simple_gui.fig
%      SIMPLE_GUI, by itself, creates a new SIMPLE_GUI or raises the existing
%      singleton*.
%
%      H = SIMPLE_GUI returns the handle to a new SIMPLE_GUI or the handle to
%      the existing singleton*.
%
%      SIMPLE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMPLE_GUI.M with the given input arguments.
%
%      SIMPLE_GUI('Property','Value',...) creates a new SIMPLE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before simple_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to simple_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help simple_gui

% Last Modified by GUIDE v2.5 20-Nov-2016 02:37:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @simple_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @simple_gui_OutputFcn, ...
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


% --- Executes just before simple_gui is made visible.
function simple_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to simple_gui (see VARARGIN)

% Choose default command line output for simple_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes simple_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Set the "SelectedChannel" variable to the current selected item 
str = get(handles.popChannel,'String') ;
val = get(handles.popChannel,'Value');
handles.SelectedChannel = str{val};

% Set the "Result" variable to empty
handles.Result = [];
% Save the handles structure.
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = simple_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnOpenImage.
function btnOpenImage_Callback(hObject, eventdata, handles)
% hObject    handle to btnOpenImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Open the image and save it in the "handles" struct
imagePath = uigetfile();
handles.Image = imread(imagePath);
% Set current drawing axes to "axes1"
axes(handles.axes1);
% Display the image
imshow(handles.Image);

% Enable the other buttons
set(handles.btnApply, 'Enable', 'on');
set(handles.btnBrightness, 'Enable', 'on');
set(handles.btnDisplayChannel, 'Enable', 'on');
set(handles.btnTranslate, 'Enable', 'on');

% Save the handles structure.
guidata(hObject, handles);

% --- Executes on button press in btnSaveImage.
function btnSaveImage_Callback(hObject, eventdata, handles)
% hObject    handle to btnSaveImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnDisplayChannel.
function btnDisplayChannel_Callback(hObject, eventdata, handles)
% hObject    handle to btnDisplayChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Result = GetImageChannel(handles.Image, handles.SelectedChannel); 

% Set current drawing axes to "axes2"
axes(handles.axes2);
imshow(handles.Result);

% Save the handles structure.
guidata(hObject, handles);

% --- Executes on selection change in popChannel.
function popChannel_Callback(hObject, eventdata, handles)
% hObject    handle to popChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popChannel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popChannel
str = get(hObject,'String') ;
val = get(hObject,'Value');
handles.SelectedChannel = str{val};

% Save the handles structure.
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in btnBrightness.
function btnBrightness_Callback(hObject, eventdata, handles)
% hObject    handle to btnBrightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get brightness offset value from textbox
txtVal = get(handles.txtOffset, 'String');
offset = str2num(txtVal) ;

% Call the function
handles.Result = Brightness(handles.Image, handles.BrightChannel, offset);

% Save the handles structure.
guidata(hObject, handles);

% Set current drawing axes to "axes2"
axes(handles.axes2);
imshow(handles.Result);



function txtOffset_Callback(hObject, eventdata, handles)
% hObject    handle to txtOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtOffset as text
%        str2double(get(hObject,'String')) returns contents of txtOffset as a double


% --- Executes during object creation, after setting all properties.
function txtOffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnApply.
function btnApply_Callback(hObject, eventdata, handles)
% hObject    handle to btnApply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (isempty(handles.Result))
    return;
end

% Set original "Image" to the "Result" image
handles.Image = handles.Result;

% Set current drawing axes to "axes1"
axes(handles.axes1);
imshow(handles.Image);

% Save the handles structure.
guidata(hObject, handles);


% --- Executes on button press in btnTranslate.
function btnTranslate_Callback(hObject, eventdata, handles)
% hObject    handle to btnTranslate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get X offset from textbox
% Get brightness offset value from textbox
txtVal = get(handles.txtXOffset, 'String');
Xoffset = str2num(txtVal) ;

% Call the function
handles.Result = Translate(handles.Image, Xoffset);

% Set current drawing axes to "axes2"
axes(handles.axes2);
imshow(handles.Result);

% Save the handles structure.
guidata(hObject, handles);



function txtXOffset_Callback(hObject, eventdata, handles)
% hObject    handle to txtXOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtXOffset as text
%        str2double(get(hObject,'String')) returns contents of txtXOffset as a double


% --- Executes during object creation, after setting all properties.
function txtXOffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtXOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popBrightChannel.
function popBrightChannel_Callback(hObject, eventdata, handles)
% hObject    handle to popBrightChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popBrightChannel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popBrightChannel
str = get(hObject,'String') ;
val = get(hObject,'Value');
handles.BrightChannel = str{val};

% Save the handles structure.
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popBrightChannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popBrightChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
str = get(hObject,'String') ;
val = get(hObject,'Value');
handles.BrightChannel = str{val};

% Save the handles structure.
guidata(hObject, handles);
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scaleX_Callback(hObject, eventdata, handles)
% hObject    handle to scaleX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.scaleX = str2double(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of scaleX as text
%        str2double(get(hObject,'String')) returns contents of scaleX as a double


% --- Executes during object creation, after setting all properties.
function scaleX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scaleX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.scaleX = str2double(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scaleY_Callback(hObject, eventdata, handles)
% hObject    handle to scaleY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.scaleY = str2double(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of scaleY as text
%        str2double(get(hObject,'String')) returns contents of scaleY as a double


% --- Executes during object creation, after setting all properties.
function scaleY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scaleY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.scaleY = str2double(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function rotationAngle_Callback(hObject, eventdata, handles)
% hObject    handle to rotationAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.rotateAngle = str2num(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of rotationAngle as text
%        str2double(get(hObject,'String')) returns contents of rotationAngle as a double


% --- Executes during object creation, after setting all properties.
function rotationAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rotationAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.rotateAngle = str2num(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnRotate.


function shearX_Callback(hObject, eventdata, handles)
% hObject    handle to shearX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of shearX as text
%        str2double(get(hObject,'String')) returns contents of shearX as a double
handles.shearX = str2num(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function shearX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shearX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.shearX = str2num(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function shearY_Callback(hObject, eventdata, handles)
% hObject    handle to shearY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.shearY = str2num(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of shearY as text
%        str2double(get(hObject,'String')) returns contents of shearY as a double


% --- Executes during object creation, after setting all properties.
function shearY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shearY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.shearY = str2num(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnTransform.
function btnTransform_Callback(hObject, eventdata, handles)
% hObject    handle to btnTransform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Scale = [handles.scaleX,0,0; 0,handles.scaleY,0; 0,0,1];
Rotate = [cosd(handles.rotateAngle),sind(handles.rotateAngle),0;-sind(handles.rotateAngle),cosd(handles.rotateAngle),0;0,0,1];
Shear = [1,handles.shearY,0;handles.shearX,1,0;0,0,1];
W=Shear*Rotate*Scale;
handles.Result = GeometricLinearTransformation(handles.Image, W);

% Set current drawing axes to "axes2"
axes(handles.axes2);
imshow(handles.Result);
figure,imshow(handles.Result);
% Save the handles structure.
guidata(hObject, handles);



function gamma_Callback(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.gamma = str2num(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of gamma as text
%        str2double(get(hObject,'String')) returns contents of gamma as a double


% --- Executes during object creation, after setting all properties.
function gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.gamma = str2num(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnGamma.
function btnGamma_Callback(hObject, eventdata, handles)
% hObject    handle to btnGamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Result = Gamma(handles.Image, handles.gamma);

% Set current drawing axes to "axes2"
axes(handles.axes2);
imshow(handles.Result);
figure,imshow(handles.Result);
% Save the handles structure.
guidata(hObject, handles);


% --- Executes on button press in btnOpenImage2.
function btnOpenImage2_Callback(hObject, eventdata, handles)
% hObject    handle to btnOpenImage2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Open the image and save it in the "handles" struct
imagePath = uigetfile();
handles.Image2 = imread(imagePath);
% Set current drawing axes to "axes1"
axes(handles.axes2);
% Display the image
imshow(handles.Image2);

% Save the handles structure.
guidata(hObject, handles);


% --- Executes on button press in btnAddImages.
function btnAddImages_Callback(hObject, eventdata, handles)
% hObject    handle to btnAddImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Result = AddTwoImages(handles.Image, handles.Image2, handles.fraction);
figure,imshow(handles.Result);
% Save the handles structure.
guidata(hObject, handles);



function fraction_Callback(hObject, eventdata, handles)
% hObject    handle to fraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.fraction = str2num(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of fraction as text
%        str2double(get(hObject,'String')) returns contents of fraction as a double


% --- Executes during object creation, after setting all properties.
function fraction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fraction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.fraction = str2num(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnSubImages.
function btnSubImages_Callback(hObject, eventdata, handles)
% hObject    handle to btnSubImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Result = SubTwoImages(handles.Image, handles.Image2, handles.fraction);
figure,imshow(handles.Result);
% Save the handles structure.
guidata(hObject, handles);



function desiredWidth_Callback(hObject, eventdata, handles)
% hObject    handle to desiredWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.desiredWidth = str2num(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of desiredWidth as text
%        str2double(get(hObject,'String')) returns contents of desiredWidth as a double


% --- Executes during object creation, after setting all properties.
function desiredWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to desiredWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.desiredWidth = str2num(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function desiredHeight_Callback(hObject, eventdata, handles)
% hObject    handle to desiredHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.desiredHeight = str2num(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of desiredHeight as text
%        str2double(get(hObject,'String')) returns contents of desiredHeight as a double


% --- Executes during object creation, after setting all properties.
function desiredHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to desiredHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.desiredHeight = str2num(get(hObject,'String'));

% Save the handles structure.
guidata(hObject, handles);
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnAlign.
function btnAlign_Callback(hObject, eventdata, handles)
% hObject    handle to btnAlign (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Result = Align(handles.Image, handles.desiredWidth, handles.desiredHeight);

% Set current drawing axes to "axes2"
axes(handles.axes2);
imshow(handles.Result);
size(handles.Result)
figure,imshow(handles.Result);
% Save the handles structure.
guidata(hObject, handles);


% --- Executes on button press in btnExtract.
function btnExtract_Callback(hObject, eventdata, handles)
% hObject    handle to btnExtract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RGB = repmat(handles.Image,[1 1 3]);
[Endpoints, Bifurcations] = ExtractMinutiae(RGB);
red = uint8([255 0 0]);  % [R G B]; class of red must match class of I
markerInserter = vision.MarkerInserter('Shape','Circle','BorderColor','Custom','CustomBorderColor',red);

J = step(markerInserter, RGB, int32(Endpoints.'));
%blue = uint8([0 0 255]);  % [R G B]; class of red must match class of I
%markerInserter = vision.MarkerInserter('Shape','Circle','BorderColor','Custom','CustomBorderColor',blue);

%J = step(markerInserter, RGB, int32(Bifurcations.'));
figure,imshow(J);


% --- Executes on button press in btnShape.
function btnShape_Callback(hObject, eventdata, handles)
% hObject    handle to btnShape (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[SegmentedSign, SignShape] = SegmentSign(handles.Image);
figure,imshow(SegmentedSign);


