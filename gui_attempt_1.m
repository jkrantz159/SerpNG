function varargout = gui_attempt_1(varargin)
% GUI_ATTEMPT_1 MATLAB code for gui_attempt_1.fig
%      GUI_ATTEMPT_1, by itself, creates a new GUI_ATTEMPT_1 or raises the existing
%      singleton*.
%
%      H = GUI_ATTEMPT_1 returns the handle to a new GUI_ATTEMPT_1 or the handle to
%      the existing singleton*.
%
%      GUI_ATTEMPT_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ATTEMPT_1.M with the given input arguments.
%
%      GUI_ATTEMPT_1('Property','Value',...) creates a new GUI_ATTEMPT_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_attempt_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_attempt_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_attempt_1

% Last Modified by GUIDE v2.5 18-Jun-2015 16:02:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_attempt_1_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_attempt_1_OutputFcn, ...
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


% --- Executes just before gui_attempt_1 is made visible.
function gui_attempt_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_attempt_1 (see VARARGIN)

% Choose default command line output for gui_attempt_1
handles.output = hObject;

% handles.xmax=10;
% handles.ymax=10;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_attempt_1 wait for user response (see UIRESUME)
% uiwait(handles.gui_attempt_1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_attempt_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function DataPathName_Callback(hObject, eventdata, handles)
% hObject    handle to DataPathName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DataPathName as text
%        str2double(get(hObject,'String')) returns contents of DataPathName as a double

% % Retrieve file path
% handles.location=get(hObject,'String')
% 
% % Update handles structure
% guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function DataPathName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DataPathName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GetData.
function GetData_Callback(hObject, eventdata, handles)
% hObject    handle to GetData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Load data from given file path
[zval,x_pixel,y_pixel]=DataEntryGUI(handles.location);
[x_pixel,y_pixel,z,zfilled]=SurfacingGUI(x_pixel,y_pixel,zval);


surf((1:x_pixel),(1:y_pixel),zfilled)
shading interp
view(0,90)
colorbar
title('Missing points interpolated')

xlim([0 640]);
ylim([0 480]);
axis equal;



handles.z=z;
handles.zfilled=zfilled;
handles.x_pixel=x_pixel;
handles.y_pixel=y_pixel;
% Update handles structure
guidata(hObject,handles);



function LeftValue_Callback(hObject, eventdata, handles)
% hObject    handle to LeftValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LeftValue as text
%        str2double(get(hObject,'String')) returns contents of LeftValue as a double

handles.left=str2double(get(hObject,'String'));
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function LeftValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LeftValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function RightValue_Callback(hObject, eventdata, handles)
% hObject    handle to RightValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of RightValue as text
%        str2double(get(hObject,'String')) returns contents of RightValue as a double
handles.right=str2double(get(hObject,'String'));
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function RightValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RightValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TopValue_Callback(hObject, eventdata, handles)
% hObject    handle to TopValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TopValue as text
%        str2double(get(hObject,'String')) returns contents of TopValue as a double
handles.top=str2double(get(hObject,'String'));
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function TopValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TopValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function BottomValue_Callback(hObject, eventdata, handles)
% hObject    handle to BottomValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BottomValue as text
%        str2double(get(hObject,'String')) returns contents of BottomValue as a double
handles.bottom=str2double(get(hObject,'String'));
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function BottomValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BottomValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function InterpFig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InterpFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate InterpFig


% --- Executes on selection change in zoomlevel.
function zoomlevel_Callback(hObject, eventdata, handles)
% hObject    handle to zoomlevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns zoomlevel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from zoomlevel

selection = get(hObject,'Value');
if selection == 1
    handles.xratio=707/640;
    handles.yratio=532/480
elseif selection == 2
    handles.xratio=707/640 .* 2;
    handles.yratio=532/480 .* 2
elseif selection == 3
    handles.xratio=707/640 .* 2 ./ 5;
    handles.yratio=532/480 .* 2 ./ 5
else
    error('No zoom level selected')
end

% Update handles structure
guidata(hObject,handles);


    
% --- Executes during object creation, after setting all properties.
function zoomlevel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zoomlevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Ratios for 20x zoom level (default, most commonly used)
handles.xratio=707/640;
handles.yratio=532/480;
handles.zratio=1;

% Update handles structure
guidata(hObject,handles);

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in interpmethodmenu.
function interpmethodmenu_Callback(hObject, eventdata, handles)
% hObject    handle to interpmethodmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns interpmethodmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from interpmethodmenu

selection = get(hObject,'Value');
if selection == 2
    handles.interpmethod=1;
elseif selection == 3
    handles.interpmethod=2;
elseif selection == 4
    handles.interpmethod=3;
elseif selection == 5
    handles.interpmethod=4;
else
    error('Select an interpolation method')
end

% Update handles structure
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function interpmethodmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interpmethodmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.interpmethod=1;

% Update handles structure
guidata(hObject,handles);


% --- Executes on button press in select_data_button.
function select_data_button_Callback(hObject, eventdata, handles)
% hObject    handle to select_data_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Select data file
handles.location=uigetfile('*.*');
handles.location=strcat('Zygo\',handles.location);

set(handles.file_name,'String',handles.location);

%Update handles structure
guidata(hObject,handles);


% --- Executes on button press in SetBoundaries.
function SetBoundaries_Callback(hObject, eventdata, handles)
% hObject    handle to SetBoundaries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.cut=[handles.left,handles.right,handles.bottom,handles.top,0];
[zmask,zfit]=MaskingGUI(handles.zfilled,handles.cut,handles.interpmethod,handles.x_pixel,handles.y_pixel,handles.z);

surf((1:handles.x_pixel),(1:handles.y_pixel),zmask)
shading interp
view(0,90)
colorbar
title({'Cut 1';'Spot removed'})

xlim([0 640]);
ylim([0 480]);
axis equal;

handles.zmask=zmask;
handles.zfit=zfit;
guidata(hObject,handles);


% --- Executes on button press in CalcVolume.
function CalcVolume_Callback(hObject, eventdata, handles)
% hObject    handle to CalcVolume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[handles.sumvol,handles.avgdepth]=CalculateVolumeGUI(handles.x_pixel,handles.y_pixel,handles.zfit,handles.cut,handles.xratio,handles.yratio,handles.zratio);

handles.sumvol
handles.avgdepth

set(handles.Vol_Output,'String',handles.sumvol);
set(handles.AvgDep_Output,'String',handles.avgdepth);

%Update handles structure
guidata(hObject,handles);
