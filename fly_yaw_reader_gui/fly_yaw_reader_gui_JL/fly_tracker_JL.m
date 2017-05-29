function varargout = fly_tracker_JL(varargin)
% FLY_TRACKER_JL MATLAB code for fly_tracker_JL.fig
%      FLY_TRACKER_JL, by itself, creates a new FLY_TRACKER_JL or raises the existing
%      singleton*.
%
%      H = FLY_TRACKER_JL returns the handle to a new FLY_TRACKER_JL or the handle to
%      the existing singleton*.
%
%      FLY_TRACKER_JL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLY_TRACKER_JL.M with the given input arguments.
%
%      FLY_TRACKER_JL('Property','Value',...) creates a new FLY_TRACKER_JL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fly_tracker_JL_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fly_tracker_JL_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fly_tracker_JL

% Last Modified by GUIDE v2.5 24-May-2017 15:55:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fly_tracker_JL_OpeningFcn, ...
                   'gui_OutputFcn',  @fly_tracker_JL_OutputFcn, ...
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


% --- Executes just before fly_tracker_JL is made visible.
function fly_tracker_JL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fly_tracker_JL (see VARARGIN)

% Choose default command line output for fly_tracker_JL
handles.output = hObject;

% UIWAIT makes fly_tracker_JL wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Prompt for an experiment directory
dname = uigetdir('X:\Jenny\FSB\Data\Behavior', 'Please chose an experiment directory.');
handles.experiment_dir = dname;

ghandles = guihandles(hObject);
set(ghandles.experiment_dir_edit, 'String', dname);

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = fly_tracker_JL_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in experiment_dir_button.
function experiment_dir_button_Callback(hObject, eventdata, handles)
% hObject    handle to experiment_dir_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dname = uigetdir('X:\Jenny\FSB\Data\Behavior');
handles.experiment_dir = dname;

ghandles = guihandles(hObject);
set(ghandles.experiment_dir_edit, 'String', dname);

% Update handles structure
guidata(hObject, handles);



function experiment_dir_edit_Callback(hObject, eventdata, handles)
% hObject    handle to experiment_dir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of experiment_dir_edit as text
%        str2double(get(hObject,'String')) returns contents of experiment_dir_edit as a double


% --- Executes during object creation, after setting all properties.
function experiment_dir_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to experiment_dir_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pre_stim_edit_Callback(hObject, eventdata, handles)
% hObject    handle to pre_stim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pre_stim_edit as text
%        str2double(get(hObject,'String')) returns contents of pre_stim_edit as a double


% --- Executes during object creation, after setting all properties.
function pre_stim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pre_stim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stim_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stim_edit as text
%        str2double(get(hObject,'String')) returns contents of stim_edit as a double


% --- Executes during object creation, after setting all properties.
function stim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function post_stim_edit_Callback(hObject, eventdata, handles)
% hObject    handle to post_stim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of post_stim_edit as text
%        str2double(get(hObject,'String')) returns contents of post_stim_edit as a double


% --- Executes during object creation, after setting all properties.
function post_stim_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to post_stim_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inter_trial_period_edit_Callback(hObject, eventdata, handles)
% hObject    handle to inter_trial_period_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inter_trial_period_edit as text
%        str2double(get(hObject,'String')) returns contents of inter_trial_period_edit as a double


% --- Executes during object creation, after setting all properties.
function inter_trial_period_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inter_trial_period_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in stim_type_menu.
function stim_type_menu_Callback(hObject, eventdata, handles)
% hObject    handle to stim_type_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns stim_type_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stim_type_menu


% --- Executes during object creation, after setting all properties.
function stim_type_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stim_type_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in using_2p_button.
function using_2p_button_Callback(hObject, eventdata, handles)
% hObject    handle to using_2p_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of using_2p_button



function task_file_edit_Callback(hObject, eventdata, handles)
% hObject    handle to task_file_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of task_file_edit as text
%        str2double(get(hObject,'String')) returns contents of task_file_edit as a double


% --- Executes during object creation, after setting all properties.
function task_file_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to task_file_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in task_file_button.
function task_file_button_Callback(hObject, eventdata, handles)
% hObject    handle to task_file_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName] = uigetfile('X:\Jenny\FSB\Data\Behavior\task_files\*.txt','Select a task file');

handles.taskfile_path = [PathName '\' FileName];

ghandles = guihandles(hObject);
set(ghandles.task_file_edit, 'String', handles.taskfile_path);

guidata(hObject, handles);

% --- Executes on button press in run_button.
function run_button_Callback(hObject, eventdata, handles)
% hObject    handle to run_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ghandles = guihandles(hObject);

task_filepath = get(ghandles.task_file_edit, 'String');
if( isempty(task_filepath) == 1 )
    errordlg('Please set the task file path.')
    return;
end
% trial variables
run_obj.trial_t = str2num(get(ghandles.trial_length_edit, 'String'));
run_obj.inter_trial_t = str2num(get(ghandles.inter_trial_period_edit, 'String'));

% odor variables
run_obj.pre_stim_t = str2num(get(ghandles.pre_stim_edit, 'String'));
run_obj.stim_t = str2num(get(ghandles.stim_edit, 'String'));

% panel variables
run_obj.number_frames = str2num(get(ghandles.number_frames_edit, 'String'));
run_obj.pattern_number = str2num(get(ghandles.pattern_number_edit, 'String'));

% 2p variable
run_obj.using_2p = get(ghandles.using_2p_button, 'Value');

contents = get(ghandles.stim_type_menu,'String'); 
run_obj.stim_type = contents; % contents{get(ghandles.stim_type_menu,'Value')};

run_obj.experiment_dir = handles.experiment_dir;
run_obj.session_id = str2num(get(ghandles.session_id_edit, 'String'));
run_obj.sessiod_id_hdl = ghandles.session_id_edit;
run_obj.taskfile_path = task_filepath;

start_trials_JL(run_obj);

guidata(hObject, handles);

function session_id_edit_Callback(hObject, eventdata, handles)
% hObject    handle to session_id_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of session_id_edit as text
%        str2double(get(hObject,'String')) returns contents of session_id_edit as a double


% --- Executes during object creation, after setting all properties.
function session_id_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to session_id_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pattern_number_edit_Callback(hObject, eventdata, handles)
% hObject    handle to pattern_number_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pattern_number_edit as text
%        str2double(get(hObject,'String')) returns contents of pattern_number_edit as a double


% --- Executes during object creation, after setting all properties.
function pattern_number_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pattern_number_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function number_frames_edit_Callback(hObject, eventdata, handles)
% hObject    handle to number_frames_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of number_frames_edit as text
%        str2double(get(hObject,'String')) returns contents of number_frames_edit as a double


% --- Executes during object creation, after setting all properties.
function number_frames_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to number_frames_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function trial_length_edit_Callback(hObject, eventdata, handles)
% hObject    handle to trial_length_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trial_length_edit as text
%        str2double(get(hObject,'String')) returns contents of trial_length_edit as a double


% --- Executes during object creation, after setting all properties.
function trial_length_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trial_length_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stop_button.
function stop_button_Callback(hObject, eventdata, handles)
% hObject    handle to stop_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global session_obj;
session_obj.stop();
release( session_obj );
disp(['Stopped acquisition.']);


% --- Executes on button press in init_ball_button.
function init_ball_button_Callback(hObject, eventdata, handles)
% hObject    handle to init_ball_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
init_ball_parameters_JL(handles.experiment_dir);
