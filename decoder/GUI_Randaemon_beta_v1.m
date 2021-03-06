function varargout = GUI_Randaemon_beta_v1(varargin)
% GUI_RANDAEMON_BETA_V1 MATLAB code for GUI_Randaemon_beta_v1.fig
%      GUI_RANDAEMON_BETA_V1, by itself, creates a new GUI_RANDAEMON_BETA_V1 or raises the existing
%      singleton*.
%
%      H = GUI_RANDAEMON_BETA_V1 returns the handle to a new GUI_RANDAEMON_BETA_V1 or the handle to
%      the existing singleton*.
%
%      GUI_RANDAEMON_BETA_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_RANDAEMON_BETA_V1.M with the given input arguments.
%
%      GUI_RANDAEMON_BETA_V1('Property','Value',...) creates a new GUI_RANDAEMON_BETA_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Randaemon_beta_v1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Randaemon_beta_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Randaemon_beta_v1

% Last Modified by GUIDE v2.5 27-Jan-2015 15:15:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Randaemon_beta_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Randaemon_beta_v1_OutputFcn, ...
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

% --- Executes just before GUI_Randaemon_beta_v1 is made visible.
function GUI_Randaemon_beta_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Randaemon_beta_v1 (see VARARGIN)

%%%%%%%%%%%%%%%%%%%%%%%%% added by Chen Yi %%%%%%%%%%%%%%%%%
% configure serial port
global start_byte_1 start_byte_2 end_byte_1 end_byte_2 MAX_PacLen;
%
start_byte_1=hex2dec('FE');
start_byte_2=hex2dec('3F');
end_byte_1=hex2dec('FC');
end_byte_2=hex2dec('1F');
MAX_PacLen=256;
%%%%%%% initiation
global TimeResolution SampleLength OperationPrd TimeNEU TimeSettle N_ReadOut;
global sel_ReadOut_2PC;
TimeResolution=0.2e-3;
SampleLength=2000e-3/0.2e-3;
OperationPrd=20e-3;
TimeNEU=10e-3;
TimeSettle=5e-3;
N_ReadOut=101;
sel_ReadOut_2PC=[2:101];

global Monkey Distri N_Moves sel_input;
Monkey='K';
Distri=1;
N_Moves=12;
sel_input=[];  % select among 0-127

% % global sel_output Bin_out SavePosition;
% % sel_output=0;
% % load(strcat(SavePosition,'OutputChannelSelection'));    % load sel_output;
% % Bin_out=zeros(1,128);
% % Bin_out(sel_output+1)=1;

global CA CB ext_ctrl;
CA=2;CB=2;
ext_ctrl=0;

global ImagePosition PC;
PC=1;
if PC
%     DataPosition='D:\Dropbox\OK-AMS035-Oct13\20140609\';
    DataPosition='D:\Dropbox\CY\decoder\Randaemon_beta\EventData\';
    SavePosition='D:\Dropbox\CY\decoder\Randaemon_beta\Results\';
    ImagePosition='D:\Dropbox\CY\decoder\hands_images\';
else
%     DataPosition='C:Users\ChenYi\Dropbox\OK-AMS035-Oct13\20140609\';
    DataPosition='C:\Users\Chen Yi\Dropbox\CY\decoder\Randaemon_beta\EventData\';
    SavePosition='C:\Users\Chen Yi\Dropbox\CY\decoder\Randaemon_beta\Results\';
    ImagePosition='C:\Users\Chen Yi\Dropbox\CY\decoder\hands_images\';
end

global NL E1 F1 E2 F2 E3 F3 E4 F4 E5 F5 EL FL;
global FingerImage FingerStatus TypeInTrial;
NL=imread(strcat(ImagePosition,'NL.JPG'));
E1=imread(strcat(ImagePosition,'E1.JPG'));
F1=imread(strcat(ImagePosition,'F1.JPG'));
E2=imread(strcat(ImagePosition,'E2.JPG'));
F2=imread(strcat(ImagePosition,'F2.JPG'));
E3=imread(strcat(ImagePosition,'E3.JPG'));
F3=imread(strcat(ImagePosition,'F3.JPG'));
E4=imread(strcat(ImagePosition,'E4.JPG'));
F4=imread(strcat(ImagePosition,'F4.JPG'));
E5=imread(strcat(ImagePosition,'E5.JPG'));
F5=imread(strcat(ImagePosition,'F5.JPG'));
EL=imread(strcat(ImagePosition,'EL.JPG'));
FL=imread(strcat(ImagePosition,'FL.JPG'));
FingerImage=cell(13,1);
FingerImage{1}=NL;
FingerImage{2}=F1;
FingerImage{3}=E1;
FingerImage{4}=F2;
FingerImage{5}=E2;
FingerImage{6}=F3;
FingerImage{7}=E3;
FingerImage{8}=F4;
FingerImage{9}=E4;
FingerImage{10}=F5;
FingerImage{11}=E5;
FingerImage{12}=FL;
FingerImage{13}=EL;

FingerStatus=cell(13,1);
FingerStatus{1}='no movement';
FingerStatus{2}='Thumb flexes';
FingerStatus{3}='Thumb extends';
FingerStatus{4}='Index flexes';
FingerStatus{5}='Index extends';
FingerStatus{6}='Middle flexes';
FingerStatus{7}='Middle extends';
FingerStatus{8}='Ring flexes';
FingerStatus{9}='Ring extends';
FingerStatus{10}='Little flexes';
FingerStatus{11}='Little extends';
FingerStatus{12}='Wrist flexes';
FingerStatus{13}='Wrist extends';

TypeInTrial=cell(13,1);
TypeInTrial{1}='no movement';
TypeInTrial{2}='Thumb flexed';
TypeInTrial{3}='Thumb extended';
TypeInTrial{4}='Index flexed';
TypeInTrial{5}='Index extended';
TypeInTrial{6}='Middle flexed';
TypeInTrial{7}='Middle extended';
TypeInTrial{8}='Ring flexed';
TypeInTrial{9}='Ring extended';
TypeInTrial{10}='Little flexed';
TypeInTrial{11}='Little extended';
TypeInTrial{12}='Wrist flexed';
TypeInTrial{13}='Wrist extended';


%%%%%%%%%%%%%%%%%%%%%%%%% added by Chen Yi %%%%%%%%%%%%%%%%%

% Choose default command line output for GUI_Randaemon_beta_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using GUI_Randaemon_beta_v1.
if strcmp(get(hObject,'Visible'),'off')
    axes(handles.axes_SPK);
    cla;
    % plot(handles.axes_SPK,T_tmp','-b','LineWidth',2);
    T_tmp=zeros(40,10000);
    plot(T_tmp','-b','LineWidth',2);
    % % % hold on;
    ylim([0 40]);
    xlim([0 10000]);
    set(gca,'YTick',0:10:40);
    set(gca,'YTickLabel',{'','10','20','30','40'},'FontSize',14);
    set(gca,'XTick',0:2500:10000);
    set(gca,'XTickLabel',{'0','0.5','1','1.5','2'},'FontSize',14);
    ylabel('Input Spikes','FontSize',14);
    xlabel('Time (s)','FontSize',14);
    
    axes(handles.axes_ELMOutput);
    cla;
    % plot(handles.axes_SPK,T_tmp','-b','LineWidth',2);
%     T_tmp=zeros(1,10000);
    plot(0,0,'-b','LineWidth',2);
    % % % hold on;
    ylim([0 1.5]);
    xlim([0 100]);
    set(gca,'YTick',0:0.5:1.5);
    set(gca,'YTickLabel',{'','','1',''},'FontSize',14);
    set(gca,'XTick',0:25:100);
    set(gca,'XTickLabel',{'0','0.5','1','1.5','2'},'FontSize',14);
    ylabel('Decoder Output','FontSize',14);
%     xlabel('Time (s)','FontSize',14);

    axes(handles.axes_LH);
    cla;
%     g = imread(strcat(ImagePosition,'NL.JPG'));
    imshow(NL);
    
%     axes(handles.axes_RH);
%     cla;
%     g = imread(strcat(ImagePosition,'NR.JPG'));
%    imshow(g);
 
end

% UIWAIT makes GUI_Randaemon_beta_v1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Randaemon_beta_v1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%% added by Chen Yi %%%%%%%%%%%%%%%%%
% global uart;
% if strcmp(uart.Status,'open')
%     fclose(uart);
% end
%%%%%%%%%%%%%%%%%%%%%%%%% added by Chen Yi %%%%%%%%%%%%%%%%%

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_baud_Callback(hObject, eventdata, handles)
% hObject    handle to edit_baud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global baud PortNumber uart;
baud = str2double(get(hObject,'String'));
uart=serial(strcat('COM',PortNumber),'BaudRate',baud,'DataBits',8,'StopBits',1);%creat a serial port object
% Hints: get(hObject,'String') returns contents of edit_baud as text
%        str2double(get(hObject,'String')) returns contents of edit_baud as a double


% --- Executes during object creation, after setting all properties.
function edit_baud_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_baud (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global baud;
baud = 9600;
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbutton_OpenCOM.
function pushbutton_OpenCOM_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_OpenCOM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global uart;
% if strcmp(uart.Status,'open')
%     fclose(uart);
% end
if strcmp(uart.Status,'closed')
    fclose(uart);
end
fopen(uart);
if strcmp(uart.Status,'open')
    set(handles.text_COMStatus, 'String', 'Connected!')
else
    set(handles.text_COMStatus, 'String', 'Failed!')
end


% --- Executes on button press in pushbutton_CloseCOM.
function pushbutton_CloseCOM_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_CloseCOM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global uart;
fclose(uart);
if strcmp(uart.Status,'closed')
    set(handles.text_COMStatus, 'String', 'Closed!')
else
    set(handles.text_COMStatus, 'String', 'Failed!')
end

% --- Executes on selection change in popupmenu_COM.
function popupmenu_COM_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_COM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global uart
global PortNumber uart baud;
contents = cellstr(get(hObject,'String'));
PortNumber = contents(get(hObject,'Value'));
% uart=serial(strcat('COM',PortNumber),'BaudRate',4800,'DataBits',8,'StopBits',1);%creat a serial port object
uart=serial(strcat('COM',PortNumber),'BaudRate',baud,'DataBits',8,'StopBits',1);%creat a serial port object


% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_COM contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_COM


% --- Executes during object creation, after setting all properties.
function popupmenu_COM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_COM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_ActiveMode.
function checkbox_ActiveMode_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ActiveMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mode
mode = get(hObject,'Value');   
    
% Hint: get(hObject,'Value') returns toggle state of checkbox_ActiveMode



function edit_InputDim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_InputDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global NumberOfNeurons;
NumberOfNeurons = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of edit_InputDim as text
%        str2double(get(hObject,'String')) returns contents of edit_InputDim as a double


% --- Executes during object creation, after setting all properties.
function edit_InputDim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_InputDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global NumberOfNeurons;
NumberOfNeurons =40;
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_DecodeMode.
function popupmenu_DecodeMode_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_DecodeMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DecodeMode;  % 0-random projection, 1-OM, 2-MC, 3-combined
contents = cellstr(get(hObject,'String'));
switch contents{get(hObject,'Value')}
    case 'OM'
        DecodeMode = 1;
    case 'MC'
        DecodeMode = 2;
    case 'COMB'
        DecodeMode = 3;
end
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_DecodeMode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_DecodeMode


% --- Executes during object creation, after setting all properties.
function popupmenu_DecodeMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_DecodeMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global DecodeMode;
DecodeMode = 1;  % 0-random projection, 1-OM, 2-MC, 3-combined
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_HiddenDim_Callback(hObject, eventdata, handles)
% hObject    handle to edit_HiddenDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global N_HLN;
N_HLN = str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of edit_HiddenDim as text
%        str2double(get(hObject,'String')) returns contents of edit_HiddenDim as a double


% --- Executes during object creation, after setting all properties.
function edit_HiddenDim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_HiddenDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global N_HLN;
N_HLN = 60;
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_DelayTime.
function popupmenu_DelayTime_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_DelayTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SDL;
contents = cellstr(get(hObject,'String'));
switch contents{get(hObject,'Value')}
    case '20 ms'
        SDL=0;
    case '40 ms'
        SDL=1;
    case '60 ms'
        SDL=2;
    case '80 ms'
        SDL=3;
    case '100 ms'
        SDL=4;
end
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_DelayTime contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_DelayTime


% --- Executes during object creation, after setting all properties.
function popupmenu_DelayTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_DelayTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global SDL;
SDL = 0;
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_DelayCh.
function popupmenu_DelayCh_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_DelayCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global N_delay;
contents = cellstr(get(hObject,'String'));
N_delay=str2double(contents{get(hObject,'Value')});
        
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_DelayCh contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_DelayCh


% --- Executes during object creation, after setting all properties.
function popupmenu_DelayCh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_DelayCh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global N_delay;
N_delay = 0;
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Bias_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Bias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global bias_current;
bias_current=str2double(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of edit_Bias as text
%        str2double(get(hObject,'String')) returns contents of edit_Bias as a double


% --- Executes during object creation, after setting all properties.
function edit_Bias_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Bias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global bias_current;
bias_current = 0;
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_HiddenNOB.
function popupmenu_HiddenNOB_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_HiddenNOB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global NOB_CNT;
contents = cellstr(get(hObject,'String'));
NOB_CNT = str2double(contents{get(hObject,'Value')}) - 6;
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_HiddenNOB contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_HiddenNOB


% --- Executes during object creation, after setting all properties.
function popupmenu_HiddenNOB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_HiddenNOB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global RES;
RES = 4;
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_ActiveOn.
function checkbox_ActiveOn_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ActiveOn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global active;
active = get(hObject,'Value');
% Hint: get(hObject,'Value') returns toggle state of checkbox_ActiveOn


% --- Executes on button press in pushbutton_SetDecoder.
function pushbutton_SetDecoder_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SetDecoder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global uart;
global start_byte_1 start_byte_2 end_byte_1 end_byte_2;
global N_delay DataPosition Monkey N_Moves NumberOfNeurons Distri
global sel_input bias_current;
global RES SDL CA CB ext_ctrl active mode;

global sel_output Bin_out SavePosition;
load(strcat(SavePosition,'OutputChannelSelection'));    % load sel_output;
Bin_out=zeros(1,128);
Bin_out(sel_output+1)=1;

if strcmp(uart.Status, 'closed')
    set(handles.text_Status, 'String', 'Device not connected!');
else
    DataFile=strcat('decoder_test_AMS035_',Monkey,num2str(N_Moves),'_',num2str(NumberOfNeurons),'_Distri_',num2str(Distri),'_OM.mat');
    if N_delay==1
        load(strcat(DataPosition,DataFile));
        sel_input=input_ch_set{1};
    end
    if N_delay==2
        load(strcat(DataPosition,DataFile));
        sel_input=input_ch_set{2};
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    spi_data=SPI_data_MSP430_AMS035(sel_input, bias_current, sel_output);
    %         ddata=SPI_data_MSP430_AMS035(127,    63,   127);
    %                   Sext0-127,B0-5,NEU_S 0-127. 262-bit in total

    switch_data=Switch_MSP430_AMS035(RES, SDL, CA, CB, ext_ctrl, active, mode);

    command=hex2dec('81');
    package=[start_byte_1 start_byte_2 command spi_data switch_data end_byte_1 end_byte_2]';
    spi_data=spi_data';
    fwrite(uart,package,'uchar');
    pause(0.1);

    [rtn_package_header(1:3),count] = fread(uart,3,'uchar');
    [rtn_package,count] = fread(uart,rtn_package_header(3),'uchar');
    spi_data_rtn=rtn_package(35:67);

    % clc;
    spi_rtn_tmp=zeros(1,8*length(spi_data_rtn));
    for i=1:length(spi_data_rtn)
        spi_rtn_tmp((i-1)*8+1:i*8)=bitget(spi_data_rtn(i),[8:-1:1]);
    end
    if (spi_rtn_tmp(end)==0)&&(spi_rtn_tmp(end-1)==0)
        spi_rtn_tmp2=[0 0 spi_rtn_tmp(1:end-2)];
        spi_rtn_final=((2.^(7:-1:0))*reshape(spi_rtn_tmp2,8,33))';

        if isempty(find(spi_rtn_final~=spi_data,1))
%             disp('SPI setting correct');
            set(handles.text_Status, 'String', 'Decoder setting completed!');
        else
%             disp('Decoder setting failed');
            set(handles.text_Status, 'String', 'Decoder setting failed!');
        end
    else
%         disp('SPI setting fails');
        set(handles.text_Status, 'String', 'Decoder setting failed!')
    end
end

% --- Executes on button press in pushbutton_Train.
function pushbutton_Train_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Train (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SavePosition;
global uart;
global start_byte_1 start_byte_2 end_byte_1 end_byte_2 MAX_PacLen;
command=hex2dec('84');  % loading OM and MC weights, OM goes first

global RES_OutputWeight_OM;
% MC weights
load(strcat(SavePosition,'OutputWeight_MC_16bit_signed.mat'));
% OM weights
load(strcat(SavePosition,'OutputWeight_OM_16bit_signed.mat'));

% load OM weights into MSP430; OM always goes first
LoadingWeightsType=0;   % 0 for loading OM weights; 1 for loading MC weights; OM always goes firstly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OutputWeights=OutputWeights_OM;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NumberOfOutputNeurons=size(OutputWeights,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global NumberOfOutputNeurons_OM;
NumberOfOutputNeurons_OM=NumberOfOutputNeurons;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global sel_output;
NumberOfWeights=length(sel_output)*NumberOfOutputNeurons;
NumberOfBytesInWeights=NumberOfWeights*NOB_Weight/8;

OutputWeights=reshape(OutputWeights,1,NumberOfWeights);
WeightsInByte=zeros(1,NumberOfBytesInWeights);
for i=1:length(OutputWeights)
    WeightsInByte(i*2)=floor(OutputWeights(i)/256);
    WeightsInByte(i*2-1)=OutputWeights(i)-WeightsInByte(i*2)*256;
end

Package_LoadWeights_Srt=uint8([start_byte_1 start_byte_2 command 0 NumberOfOutputNeurons LoadingWeightsType end_byte_1 end_byte_2]');
NumberOfDataFrame=ceil(NumberOfBytesInWeights/(MAX_PacLen-2));
Package_LoadWeights=cell(NumberOfDataFrame,1);
for i=1:NumberOfDataFrame
    data=WeightsInByte((i-1)*(MAX_PacLen-2)+1:min(i*(MAX_PacLen-2),NumberOfBytesInWeights));
    Package_LoadWeights{i}=uint8([start_byte_1 start_byte_2 command i data end_byte_1 end_byte_2]');
end
Package_LoadWeights_End=uint8([start_byte_1 start_byte_2 command 255 end_byte_1 end_byte_2]');

LoadStrTime=cputime;
fwrite(uart,Package_LoadWeights_Srt,'uchar');

pause(0.001);
[rtn_package_header(1:3),count] = fread(uart,3,'uchar');
[rtn_package_str,count] = fread(uart,rtn_package_header(3),'uchar');
LoadingCheck=zeros(NumberOfDataFrame+2,1);
if ((rtn_package_str(1)==command)&&(rtn_package_str(2)==0)&&(256*rtn_package_str(4)+rtn_package_str(3)==length(Package_LoadWeights_Srt)-4))
    LoadingCheck(1)=1;
end
%
rtn_package=zeros(4,NumberOfDataFrame);
for i=1:NumberOfDataFrame
    fwrite(uart,Package_LoadWeights{i},'uchar');
    pause(0.005);
    [rtn_package_header(1:3),count] = fread(uart,3,'uchar');
    [rtn_package(:,i),count] = fread(uart,rtn_package_header(3),'uchar');
    if ((rtn_package(1,i)==command)&&(rtn_package(2,i)==i)&&(256*rtn_package(4,i)+rtn_package(3,i)==length(Package_LoadWeights{i})-4))
        LoadingCheck(i+1)=1;
    end
end

fwrite(uart,Package_LoadWeights_End,'uchar');
pause(0.005);
[rtn_package_header(1:3),count] = fread(uart,3,'uchar');
[rtn_package_end,count] = fread(uart,rtn_package_header(3),'uchar');
if ((rtn_package_end(1)==command)&&(rtn_package_end(2)==255)&&(256*rtn_package_end(4)+rtn_package_end(3)==NumberOfBytesInWeights))
    LoadingCheck(end)=1;
end
LoadEndTime=cputime;
LoadingTime=LoadEndTime-LoadStrTime;
if (sum(LoadingCheck)==NumberOfDataFrame+2)
%     disp('Data Loading Succeeds!');
    set(handles.text_Status, 'String', 'OM weights loading completed!');
else
%     disp('Data Loading Fails!');
    set(handles.text_Status, 'String', 'OM weights loading failed!');
end
% disp(LoadingTime);
% set(handles.text_Status, 'String', num2str(LoadingTime));

%
% load MC weights into MSP; OM always goes first
LoadingWeightsType=1;   % 0 for loading OM weights; 1 for loading MC weights; OM always goes firstly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
OutputWeights=OutputWeights_MC;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NumberOfOutputNeurons=size(OutputWeights,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global NumberOfOutputNeurons_MC;
NumberOfOutputNeurons_MC=NumberOfOutputNeurons;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NumberOfWeights=length(sel_output)*NumberOfOutputNeurons;
NumberOfBytesInWeights=NumberOfWeights*NOB_Weight/8;

OutputWeights=reshape(OutputWeights,1,NumberOfWeights);
WeightsInByte=zeros(1,NumberOfBytesInWeights);
for i=1:length(OutputWeights)
    WeightsInByte(i*2)=floor(OutputWeights(i)/256);
    WeightsInByte(i*2-1)=OutputWeights(i)-WeightsInByte(i*2)*256;
end

Package_LoadWeights_Srt=uint8([start_byte_1 start_byte_2 command 0 NumberOfOutputNeurons LoadingWeightsType end_byte_1 end_byte_2]');
NumberOfDataFrame=ceil(NumberOfBytesInWeights/(MAX_PacLen-2));
Package_LoadWeights=cell(NumberOfDataFrame,1);
for i=1:NumberOfDataFrame
    data=WeightsInByte((i-1)*(MAX_PacLen-2)+1:min(i*(MAX_PacLen-2),NumberOfBytesInWeights));
    Package_LoadWeights{i}=uint8([start_byte_1 start_byte_2 command i data end_byte_1 end_byte_2]');
end
Package_LoadWeights_End=uint8([start_byte_1 start_byte_2 command 255 end_byte_1 end_byte_2]');

LoadStrTime=cputime;
fwrite(uart,Package_LoadWeights_Srt,'uchar');

pause(0.001);
[rtn_package_header(1:3),count] = fread(uart,3,'uchar');
[rtn_package_str,count] = fread(uart,rtn_package_header(3),'uchar');
LoadingCheck=zeros(NumberOfDataFrame+2,1);
if ((rtn_package_str(1)==command)&&(rtn_package_str(2)==0)&&(256*rtn_package_str(4)+rtn_package_str(3)==length(Package_LoadWeights_Srt)-4))
    LoadingCheck(1)=1;
end
%
rtn_package=zeros(4,NumberOfDataFrame);
for i=1:NumberOfDataFrame
    fwrite(uart,Package_LoadWeights{i},'uchar');
    pause(0.005);
    [rtn_package_header(1:3),count] = fread(uart,3,'uchar');
    [rtn_package(:,i),count] = fread(uart,rtn_package_header(3),'uchar');
    if ((rtn_package(1,i)==command)&&(rtn_package(2,i)==i)&&(256*rtn_package(4,i)+rtn_package(3,i)==length(Package_LoadWeights{i})-4))
        LoadingCheck(i+1)=1;
    end
end

fwrite(uart,Package_LoadWeights_End,'uchar');
pause(0.005);
[rtn_package_header(1:3),count] = fread(uart,3,'uchar');
[rtn_package_end,count] = fread(uart,rtn_package_header(3),'uchar');
if ((rtn_package_end(1)==command)&&(rtn_package_end(2)==255)&&(256*rtn_package_end(4)+rtn_package_end(3)==NumberOfBytesInWeights))
    LoadingCheck(end)=1;
end
LoadEndTime=cputime;
LoadingTime=LoadEndTime-LoadStrTime;
if (sum(LoadingCheck)==NumberOfDataFrame+2)
%     disp('Data Loading Succeeds!');
    set(handles.text_Status, 'String', 'MC weights loading completed!');
else
%     disp('Data Loading Fails!');
    set(handles.text_Status, 'String', 'MC weights loading failed!');
end
% disp(LoadingTime);
% set(handles.text_Status, 'String', num2str(LoadingTime));



% --- Executes on button press in pushbutton_PickTrial.
function pushbutton_PickTrial_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PickTrial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DataPosition;
global uart start_byte_1 start_byte_2 end_byte_1 end_byte_2 MAX_PacLen;
global Monkey N_Moves NumberOfNeurons Distri;

DataFile=strcat('decoder_test_AMS035_',Monkey,num2str(N_Moves),'_',num2str(NumberOfNeurons),'_Distri_',num2str(Distri),'_MC.mat');
load(strcat(DataPosition,DataFile));
DataFile=strcat('decoder_test_AMS035_',Monkey,num2str(N_Moves),'_',num2str(NumberOfNeurons),'_Distri_',num2str(Distri),'_OM.mat');
load(strcat(DataPosition,DataFile));


global T_TGT_OM sel_ReadOut_2PC;
T_TGT_OM=zeros(length(T_Target_OM)*length(sel_ReadOut_2PC),1);
for i=1:length(T_Target_OM)
    T_TGT_OM((i-1)*length(sel_ReadOut_2PC)+1:i*length(sel_ReadOut_2PC))=T_Target_OM{i};
end

global FinalOutput_OM T_Output_ON_OM CntEvent;
FinalOutput_OM=zeros(length(T_Target_OM)*length(sel_ReadOut_2PC),1);
T_Output_ON_OM=zeros(1,length(T_Target_OM)*length(sel_ReadOut_2PC));
[CntEvent,~]=RandDistr(1:60,1);
%
%%%%%%%%%%%%%%% loading trial %%%%%%%%%%%%%%%%%%%%%%%%%

% disp('On-line Testing');
% disp('CntEvent=');disp(CntEvent);
set(handles.text_Status, 'String', 'On-line decoding, Event No.');
set(handles.text_Status, 'String', num2str(CntEvent));

Event_tmp=T_EventData_OM{CntEvent,1};
FirstEventTime_high8=floor(Event_tmp(1,1)/256);
FirstEventTime_low8=Event_tmp(1,1)-FirstEventTime_high8*256;
if(FirstEventTime_low8==0)
    FirstEventTime_low8=FirstEventTime_low8+1;
end
FirstEventAddr=Event_tmp(1,2);
Event=zeros(size(Event_tmp,1)-1,size(Event_tmp,2));
Event(:,1)=diff(Event_tmp(:,1));
Event(:,2)=Event_tmp(2:end,2);

command=hex2dec('82');

global SampleLength;

SampleLength_high8=floor(SampleLength(1,1)/256);
SampleLength_low8=SampleLength(1,1)-SampleLength_high8*256;
Package_LoadData_Srt=uint8([start_byte_1 start_byte_2 command 0 SampleLength_high8 SampleLength_low8...
                            FirstEventTime_high8 FirstEventTime_low8 FirstEventAddr...
                            end_byte_1 end_byte_2]');
EventCount=size(Event_tmp,1);
NumberOfDataFrame=ceil(2*(EventCount-1)/(MAX_PacLen-2));
Package_LoadData=cell(NumberOfDataFrame,1);
for i=1:NumberOfDataFrame
    bg=(i-1)*(MAX_PacLen-2)/2+1;
    stop=min(i*(MAX_PacLen-2)/2,size(Event,1));
    data=reshape((Event(bg:stop,:))',1,2*(stop-bg+1));
    Package_LoadData{i}=uint8([start_byte_1 start_byte_2 command i data end_byte_1 end_byte_2]');
end
Package_LoadData_End=uint8([start_byte_1 start_byte_2 command 255 end_byte_1 end_byte_2]');

LoadStrTime=cputime;
fwrite(uart,Package_LoadData_Srt,'uchar');
%
pause(0.001);
[rtn_package_header(1:3),count] = fread(uart,3,'uchar');
[rtn_package_str,count] = fread(uart,rtn_package_header(3),'uchar');
LoadingCheck=zeros(NumberOfDataFrame+2,1);
if ((rtn_package_str(1)==command)&&(rtn_package_str(2)==0)&&(256*rtn_package_str(4)+rtn_package_str(3)==length(Package_LoadData_Srt)-4))
    LoadingCheck(1)=1;
end
%
rtn_package=zeros(4,NumberOfDataFrame);
for i=1:NumberOfDataFrame
    fwrite(uart,Package_LoadData{i},'uchar');
    pause(0.005);
    [rtn_package_header(1:3),count] = fread(uart,3,'uchar');
    [rtn_package(:,i),count] = fread(uart,rtn_package_header(3),'uchar');
    if ((rtn_package(1,i)==command)&&(rtn_package(2,i)==i)&&(256*rtn_package(4,i)+rtn_package(3,i)==length(Package_LoadData{i})-4))
        LoadingCheck(i+1)=1;
    end
end

fwrite(uart,Package_LoadData_End,'uchar');
pause(0.005);
[rtn_package_header(1:3),count] = fread(uart,3,'uchar');
[rtn_package_end,count] = fread(uart,rtn_package_header(3),'uchar');
if ((rtn_package_end(1)==command)&&(rtn_package_end(2)==255)&&(256*rtn_package_end(4)+rtn_package_end(3)==2*(EventCount-1)))
    LoadingCheck(end)=1;
end
LoadEndTime=cputime;
LoadingTime=LoadEndTime-LoadStrTime;
if (sum(LoadingCheck)==NumberOfDataFrame+2)
%     disp('Data Loading Succeeds!');
    set(handles.text_Status, 'String', 'Trial loading completed!');
else
%     disp('Data Loading Fails!');
    set(handles.text_Status, 'String', 'Trial loading failed!');
end
% disp(LoadingTime);
%%%%%%%%%%%%%%% loading trial %%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% display trial %%%%%%%%%%%%%%%%%%%%%%%%%
set(handles.text_FingerStatus, 'String', '');
set(handles.text_MoveType, 'String', '');

global T_tmp;
tmp=(size(T_pre_OM{CntEvent},1)-1:-1:0)';
T_tmp=T_pre_OM{CntEvent}+tmp(:,ones(1,size(T_pre_OM{CntEvent},2))); 
% T_tmp=zeros(40,10000);
% for i=1:40
%     T_tmp(i,:)=0.5+0.5*sin((1:10000)/10000*2*pi)+i-1;
% end
% T_tmp=0.5+0.5*sin((0:0.005:1)*2*pi);
axes(handles.axes_SPK);
cla;
% plot(handles.axes_SPK,T_tmp','-b','LineWidth',2);
plot(T_tmp','-b','LineWidth',2);
% % % hold on;
ylim([0 40]);
xlim([0 10000]);
set(gca,'YTick',0:10:40);
set(gca,'YTickLabel',{'','10','20','30','40'},'FontSize',14);
set(gca,'XTick',0:2500:10000);
set(gca,'XTickLabel',{'0','0.5','1','1.5','2'},'FontSize',14);
ylabel('Input Spikes','FontSize',14);
xlabel('Time (s)','FontSize',14);

global TypeInTrial;
set(handles.text22, 'String', TypeInTrial(T_Target_MC{CntEvent}+1));

% % % set(gca,'FontSize',22,'FontName','Times New Roman');
% % set(gca,'FontSize',18);
% for i=2:size(T_pre_OM{CntEvent},1)
%     plot(handles.axes_SPK,T_pre_OM{CntEvent}(i,:)+i-1,'LineWidth',2);
% %     hold on;
% end


%%%%%%%%%%%%%%% display trial %%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton_StartDecoding.
function pushbutton_StartDecoding_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_StartDecoding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% testing
global DataPosition;
global uart start_byte_1 start_byte_2 end_byte_1 end_byte_2 MAX_PacLen;
global Bin_out;
command=hex2dec('85');
NeuronOutputSelection=(2.^(0:7))*reshape(Bin_out,8,16);

global TimeResolution SampleLength OperationPrd TimeNEU TimeSettle N_ReadOut;
global sel_ReadOut_2PC;
% OperationPrd=20e-3;
% TimeNEU=10e-3;
% TimeSettle=5e-3;
% TimeResolution=0.2e-3;
Reserved=0;
% N_ReadOut=101;
% parameters loading
ParaLoad=2;
NumberOfOutputNeurons=1;

global DecodeMode;
DecodeMode=3; % 0-random projection, 1-OM, 2-MC, 3-combined

global RES_OutputWeight_OM;
Thr_OM=0.6;
Thr_OM=round(Thr_OM/RES_OutputWeight_OM);

Thr_OM_Byte3=floor(Thr_OM/16777216);
Thr_OM_Byte2=floor(mod(Thr_OM,16777216)/65536);
Thr_OM_Byte1=floor(mod(Thr_OM,65536)/256);
Thr_OM_Byte0=mod(Thr_OM,256);
Thr_OM_4Bytes=[Thr_OM_Byte0 Thr_OM_Byte1 Thr_OM_Byte2 Thr_OM_Byte3];

hyster_prd=10;
pos_cnt=5;
OMPrd=10;
RefraPrd=16;


TestPackage_ParaLoad=uint8([start_byte_1 start_byte_2 command ParaLoad DecodeMode ...
                            NumberOfOutputNeurons N_ReadOut NeuronOutputSelection ...
                            OperationPrd/TimeResolution TimeSettle/TimeResolution ...
                            TimeNEU/TimeResolution Thr_OM_4Bytes hyster_prd pos_cnt...
                            OMPrd RefraPrd end_byte_1 end_byte_2]');
% 12: total number of targets
fwrite(uart,TestPackage_ParaLoad,'uchar');
%
pause(0.001);
[rtn_package_header(1:3),count] = fread(uart,3,'uchar');
[rtn_package_test_para,count] = fread(uart,rtn_package_header(3),'uchar');
if rtn_package_test_para==1
%     disp('Testing Parameters Loading is done!');
    set(handles.text_Status, 'String', 'Decoding parameters loading completed!');
else
%     disp('Testing Parameters Loading Fails!');
    set(handles.text_Status, 'String', 'Decoding parameters loading failed!');
end
%

set(handles.text_MoveType, 'String', '');
% testing starts
command=hex2dec('85');
ParaLoad=0;
TargetLabel=1;
pause(0.05);

TestPackage_Trigger=uint8([start_byte_1 start_byte_2 command ParaLoad TargetLabel end_byte_1 end_byte_2]');
fwrite(uart,TestPackage_Trigger,'uchar');

global FingerImage FingerStatus TypeInTrial;
global T_tmp;

N_FinalOuput=1;
FinalOutput_MC=zeros(1,length(sel_ReadOut_2PC));
FinalOutput_OM=zeros(1,length(sel_ReadOut_2PC));
max_ReadOut_2PC=max(sel_ReadOut_2PC);
min_ReadOut_2PC=min(sel_ReadOut_2PC);
ind_ReadOut_2PC=1;
while(N_FinalOuput <= N_ReadOut)
    while( uart.BytesAvailable<1 )   
    end
    [rtn_package_finaloutput(N_FinalOuput),~] = fread(uart,1,'uchar');
%     rtn_package_finaloutput(N_FinalOuput)
    if (N_FinalOuput>=min_ReadOut_2PC)&&(N_FinalOuput<=max_ReadOut_2PC)

        if (rtn_package_finaloutput(N_FinalOuput)>0)
            FinalOutput_OM(ind_ReadOut_2PC)=1;
            FinalOutput_MC(ind_ReadOut_2PC)=rtn_package_finaloutput(N_FinalOuput);
        end
        axes(handles.axes_LH);
        cla;
        imshow(FingerImage{FinalOutput_MC(ind_ReadOut_2PC)+1});
        set(handles.text_FingerStatus, 'String', FingerStatus{FinalOutput_MC(ind_ReadOut_2PC)+1});

        axes(handles.axes_SPK);
        cla;            
        plot(T_tmp','-b','LineWidth',2);
        hold on;
        plot([ind_ReadOut_2PC-1 ind_ReadOut_2PC-1]*100,[0 40],'--r','LineWidth',2)
        plot([ind_ReadOut_2PC ind_ReadOut_2PC]*100,[0 40],'--r','LineWidth',2)
        ylim([0 40]);
        xlim([0 10000]);
        set(gca,'YTick',0:10:40);
        set(gca,'YTickLabel',{'','10','20','30','40'},'FontSize',14);
        set(gca,'XTick',0:2500:10000);
        set(gca,'XTickLabel',{'0','0.5','1','1.5','2'},'FontSize',14);
        ylabel('Input Spikes','FontSize',14);
        xlabel('Time (s)','FontSize',14);
%         
        axes(handles.axes_ELMOutput);
        cla;            
        plot(0:ind_ReadOut_2PC,[0 FinalOutput_OM(1:ind_ReadOut_2PC)],'-b','LineWidth',2);
        ylim([0 1.5]);
        xlim([0 100]);
        set(gca,'YTick',0:0.5:1.5);
        set(gca,'YTickLabel',{'','','1',''},'FontSize',14);
        set(gca,'XTick',0:25:100);
        set(gca,'XTickLabel',{'0','0.5','1','1.5','2'},'FontSize',14);
        ylabel('Decoder Output','FontSize',14);
        
        ind_ReadOut_2PC=ind_ReadOut_2PC+1;
    end
    N_FinalOuput=N_FinalOuput+1;
end
MoveTypeInTheTrial=zeros(12,1);
ind_move=find(FinalOutput_MC>0);
for i=1:length(ind_move)
    MoveTypeInTheTrial(FinalOutput_MC(ind_move(i)))=MoveTypeInTheTrial(FinalOutput_MC(ind_move(i)))+1;
end
[~,max_MoveType]=max(MoveTypeInTheTrial);
set(handles.text_MoveType, 'String', TypeInTrial(max_MoveType+1));

pause(0.05);
[rtn_package_header(1:3),count] = fread(uart,3,'uchar');
[rtn_package_test,count] = fread(uart,rtn_package_header(3),'uchar');
if ((rtn_package_test(1)==N_ReadOut) && (256*rtn_package_test(3)+rtn_package_test(2)==N_ReadOut*NumberOfOutputNeurons))
%     disp('Testing is done!');
    set(handles.text_Status, 'String', 'Decoding completed!');
else
%     disp('Testing Fails!');
    set(handles.text_Status, 'String', 'Decoding failed!');
end
% FinalOutput_OM((CntEvent-1)*length(sel_ReadOut_2PC)+1:CntEvent*length(sel_ReadOut_2PC))=rtn_package_finaloutput(sel_ReadOut_2PC);



% --- Executes on button press in pushbutton_Reset.
function pushbutton_Reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function checkbox_ActiveMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkbox_ActiveMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global mode;
mode = 0;


% --- Executes during object creation, after setting all properties.
function checkbox_ActiveOn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkbox_ActiveOn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global active;
active = 0;


% --- Executes on button press in checkbox_PC.
function checkbox_PC_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_PC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global PC DataPosition SavePosition ImagePosition;
PC = get(hObject,'Value'); %1 for desktop, 0 for laptop
if PC
%     DataPosition='D:\Dropbox\OK-AMS035-Oct13\20140609\';
    DataPosition='D:\Dropbox\CY\decoder\Randaemon_beta\EventData\';
    SavePosition='D:\Dropbox\CY\decoder\Randaemon_beta\Results\';
    ImagePosition='D:\Dropbox\CY\decoder\hands_images\';
else
%     DataPosition='C:Users\ChenYi\Dropbox\OK-AMS035-Oct13\20140609\';
    DataPosition='C:\Users\ChenYi\Dropbox\CY\decoder\Randaemon_beta\EventData\';
    SavePosition='C:\Users\ChenYi\Dropbox\CY\decoder\Randaemon_beta\Results\';
    ImagePosition='C:\Users\ChenYi\Dropbox\CY\decoder\hands_images\';
end
% Hint: get(hObject,'Value') returns toggle state of checkbox_PC


% --- Executes during object creation, after setting all properties.
function checkbox_PC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkbox_PC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global PC DataPosition SavePosition;
PC = 1; %1 for desktop, 0 for laptop
if PC
%     DataPosition='D:\Dropbox\OK-AMS035-Oct13\20140609\';
    DataPosition='D:\Dropbox\CY\decoder\Randaemon_beta\EventData\';
    SavePosition='D:\Dropbox\CY\decoder\Randaemon_beta\Results\';
else
%     DataPosition='C:Users\ChenYi\Dropbox\OK-AMS035-Oct13\20140609\';
    DataPosition='C:\Users\ChenYi\Dropbox\CY\decoder\Randaemon_beta\EventData\';
    SavePosition='C:\Users\ChenYi\Dropbox\CY\decoder\Randaemon_beta\Results\';
end



% --- Executes during object creation, after setting all properties.
function text_Status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_Status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called





% --- Executes during object creation, after setting all properties.
function text_COMStatus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_COMStatus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


function [spi_data]=SPI_data_MSP430_AMS035(sel_input, bias_current, sel_output)

Bin_bias=bitget(bias_current,[1:1:6]);
Bin_in=zeros(1,128);
Bin_out=zeros(1,128);
Bin_in(sel_input+1)=1;
Bin_out(sel_output+1)=1;

Bin_all=[Bin_in Bin_bias Bin_out 0 0];
Bin_all_matrix=reshape(Bin_all, 8, 33);
weights=2.^(0:7);
spi_data_tmp=weights*Bin_all_matrix;
spi_data=spi_data_tmp(end:-1:1);

function [switch_data]=Switch_MSP430_AMS035(RES, SDL, CA, CB, ext_ctrl, active, mode)
switch_data=[RES*4+CA SDL*32+CB*8+ext_ctrl*4+active*2+mode];

function[v1,v2]=RandDistr(input,l_v1)
% randomly distribute value saved in input into v1 and v2 in sizes of l_v1
% and length(input)-l_v2 respectively

l_v=length(input);
ind1=zeros(1,l_v);
ind2=ones(1,l_v);
for i=1:1:l_v1
    tmp=randi([1 l_v],1);
    while ind1(tmp)
        tmp=randi([1 l_v],1);
    end
    ind1(tmp)=1;
    ind2(tmp)=0;
end
v1=input(find(ind1));
v2=input(find(ind2));


% --- Executes on button press in pushbutton_AutoRun.
function pushbutton_AutoRun_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_AutoRun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes_SPK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_SPK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_SPK
