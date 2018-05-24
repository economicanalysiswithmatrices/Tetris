function varargout = Tetrisguibase2(varargin)
% TETRISGUIBASE2 MATLAB code for Tetrisguibase2.fig
%      TETRISGUIBASE2, by itself, creates a new TETRISGUIBASE2 or raises the existing
%      singleton*.
%
%      H = TETRISGUIBASE2 returns the handle to a new TETRISGUIBASE2 or the handle to
%      the existing singleton*.
%
%      TETRISGUIBASE2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TETRISGUIBASE2.M with the given input arguments.
%
%      TETRISGUIBASE2('Property','Value',...) creates a new TETRISGUIBASE2 or raises the existing singleton*.  Starting from the left, property value pairs are applied to the GUI before
%      Tetrisguibase2_OpeningFcn gets called.  An unrecognized property name or invalid value makes property application stop.  All inputs are passed to Tetrisguibase2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Tetrisguibase2

% Last Modified by GUIDE v2.5 12-Jan-2018 00:42:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Tetrisguibase2_OpeningFcn, ...
                   'gui_OutputFcn',  @Tetrisguibase2_OutputFcn, ...
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


% --- Executes just before Tetrisguibase2 is made visible.
function Tetrisguibase2_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Tetrisguibase2 (see VARARGIN)

% Choose default command line output for Tetrisguibase2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Tetrisguibase2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

set(hObject, 'KeyPressFcn', @(H, E)my_KeyPressFcn(H, E))


% --- Outputs from this function are returned to the command line.
function varargout = Tetrisguibase2_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function my_KeyPressFcn(~, eventdata)
global Abp
global Abt
global BcSquare
global BcLong
global BcT
global BcSR
global BcL
global BcLR
global y
global BcS
global fallproc
global GPMstatic
global OAbp
global Handlearray
global moving
global GPMlast
switch eventdata.Key
    case 'rightarrow'
        if moving==0 %a move cannot be being considered
        if fallproc==0 %a fall cannot be being considered
            moving=1; %A move is now being considered
        Abpchecked=Abp+[1,1,1,1;0,0,0,0]; %the abp checked value is the abp moved one step to the right
        GPMmove=GPMstatic; %the GPMmove is set to the GPMstatic (the GPM if no active blocks are considered)
        Moveable=1; %start under the assumption it is a valid move
            for l=1:4
        if GPMmove(Abpchecked(2,l),Abpchecked(1,l))~=1 %uses the active block position to reference the GPM and check if any of the tiles are not empty. If they are closed, eg not 1, the active block position is now considered overlapping a filled square. As a result, this is considered not a moveable action command
            Moveable=0; %This sets Moveable to 0, signaling its not a acceptable move
            disp('invalid move') %debug code, not for players to see (wont apear on gui)
        end
            end
        if Moveable==1 %if all four checks pass, this is still 1 and the movement can take place
            GPM=GPMstatic; %set our GPM to the static GPM
            Abp=Abp+[1,1,1,1;0,0,0,0]; %set the real Active block position to the Active block position moved one right
            UAbp=Abp; %Updated Active block position is the new active block position
            for q=1:4
    GPM(Abp(2,q),Abp(1,q))=Abt; %edit the gpm by filling every square referenced by the active block position to the type of block the active block is
            end
            for apbleft=1:4  
set(Handlearray{(OAbp(2,apbleft)-3),(OAbp(1,apbleft)-3)}, 'BackgroundColor','black'); %set its old co ordinates to black, because the edges are 3 thick the first pannel in the pannel handle array relates to the GPM(4,4) as a result there is minus 3 on both dimensions. (4,4)-(3,3)=(1,1)
            end
for apbnew=1:4
    if Abt==2 %if active block type is 2, we know (see lower) it is a square block. And so we know to colour these squares red.
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','red');
    end
    if Abt==3
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','blue'); 
    end
    if Abt==4
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','green'); 
    end
    if Abt==5
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','cyan'); 
    end
    if Abt==6
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','magenta');
    end
    if Abt==7
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','yellow'); 
    end
if Abt==8
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor',[0.74 0.34 0.98]);                            
end
end
GPMlast=GPM; %set the GPMlast (the last GPM that passed the checks of can the active block make the transformation) to the current gpm just used.
OAbp=Abp; %the OAbp Old Active block position is set to the current active block position 
        end
        end
        moving=0; %with that done, regardless of if it succeeded or passed the checks, now movement is not taking place.
        end


    case 'leftarrow' %This is just the left arrow version of the code for the right arrow.
        if moving==0
        if fallproc==0
            moving=1; 
        Abpchecked=Abp-[1,1,1,1;0,0,0,0];
        GPMmove=GPMstatic;
        Moveable=1; 
            for l=1:4
        if GPMmove(Abpchecked(2,l),Abpchecked(1,l))~=1 
            Moveable=0; 
            disp('invalid move') %debug code
        end
            end
        if Moveable==1
            GPM=GPMstatic;
            Abp=Abp-[1,1,1,1;0,0,0,0];
            UAbp=Abp;
            for q=1:4
    GPM(Abp(2,q),Abp(1,q))=Abt; 
            end
            for apbleft=1:4  
set(Handlearray{(OAbp(2,apbleft)-3),(OAbp(1,apbleft)-3)}, 'BackgroundColor','black'); 
            end
for apbnew=1:4
    if Abt==2
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','red');
    end
    if Abt==3
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','blue'); 
    end
    if Abt==4
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','green'); 
    end
    if Abt==5
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','cyan'); 
    end
    if Abt==6
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','magenta');
    end
    if Abt==7
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','yellow'); 
    end
if Abt==8
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor',[0.74 0.34 0.98]);                            
end
end
GPMlast=GPM;
OAbp=Abp;
        end
        end
        moving=0;
        end

    case 'uparrow'
        if moving==0
        if fallproc==0
            moving=1; %A move is being considered
            Abpchecked=0;
        rotatable=1; %this assumes a rotation would actualy do anything to change the shape. 
        if Abt==BcSquare
            rotatable=0; %if it is a square, a 2x2, rotation has literaly no effect so it is considered not rotatable.
        end
        if Abt==BcT %if the Active block type is a Block catagory T
             if y==1 %y is its orientation currently
             Abpchecked=Abp+[-1,0,0,0;1,0,0,0]; %so if y is one, the rotation tryping to be carried out is this, hence we set Active block position checked to abp +...
             
             elseif y==2
             Abpchecked=Abp+[0,0,-1,0;0,0,-1,0];
            
             elseif y==3
             Abpchecked=Abp+[0,0,0,1;0,0,0,-1];
             
             elseif y==4
             Abpchecked=Abp+[1,0,1,-1;-1,0,1,1];
           
             end
        end
         if Abt==BcLong
             if y==1
             Abpchecked=Abp+[1,0,-1,-2;-1,0,1,2];
             
             elseif y==2
             Abpchecked=Abp+[-1,0,1,2;2,1,0,-1];
             elseif y==3
             Abpchecked=Abp+[1,0,-1,-2;-1,0,1,2];
             
             elseif y==4
             Abpchecked=Abp+[-1,0,1,2;2,1,0,-1];
             end
         end
          if Abt==BcS
              if y==1
              Abpchecked=Abp+[-1,0,1,2;1,0,1,0];
              
              elseif y==2
              Abpchecked=Abp+[1,0,-1,-2;0,1,0,1];
              
              elseif y==3
              Abpchecked=Abp+[-2,-1,0,1;1,0,1,0];
              
              elseif y==4
              Abpchecked=Abp+[2,1,0,-1;0,1,0,1];
              
              end
          end
          if Abt==BcSR
              if y==1
              Abpchecked=Abp+[-1,0,1,2;0,1,0,1];
              
               elseif y==2
              Abpchecked=Abp+[1,0,-1,-2;1,0,1,0];
              
              elseif y==3
              Abpchecked=Abp+[-2,-1,0,1;0,1,0,1];
              
              elseif y==4
              Abpchecked=Abp+[2,1,0,-1;1,0,1,0];
              end
          end
          if Abt==BcL
              if y==1
              Abpchecked=Abp+[-2,0,1,1;-1,-1,0,0];
              elseif y==2
              Abpchecked=Abp+[2,1,0,-1;0,1,0,-1];
              elseif y==3
              Abpchecked=Abp+[-1,-1,0,2;0,0,1,1];
              elseif y==4
              Abpchecked=Abp+[1,0,-1,-2;1,0,-1,0];
              end
          end
          if Abt==BcLR
              if y==1
              Abpchecked=Abp+[-1,-1,0,0;-2,0,1,1];
              elseif y==2
              Abpchecked=Abp+[1,0,-1,0;1,0,-1,-2];
              elseif y==3
              Abpchecked=Abp+[0,0,1,1;-1,-1,0,2];
              elseif y==4
              Abpchecked=Abp+[0,1,0,-1;2,1,0,-1];
              end
          end
                  GPMmove=GPMstatic; %set the Global positioning matric to the Static Global Positioning Matrix
                  if rotatable==1 %if it is rotatable (NOT A SQUARE!)
        Moveable=1; %start under the assumption it is a valid move
            for l=1:4
        if GPMmove(Abpchecked(2,l),Abpchecked(1,l))~=1 %checks if any of the squares it would rotate into are filled (not 1)
            Moveable=0; %This sets Moveable to 0, signaling its not a acceptable move
            disp('invalid move') %debug code
        end
            end
                  
            if Moveable==1 %if it passes the movable check
                if y==1 %if its current rotation is 1
                    y=y+1; %it has rotated from 1 to 2
                elseif y==2
                    y=y+1; %from 2 to 3
                elseif y==3
                    y=y+1; %from 3 to 4
                elseif y==4
                    y=y-3; %from 4 to 1
                end
            GPM=GPMstatic; %set the GPM to the static GPM
            Abp=Abpchecked; %now the active block position is the one we checked and passed the checks above.
            UAbp=Abp; %the Updated Active block position is the Current Active block position
            for q=1:4
    GPM(Abp(2,q),Abp(1,q))=Abt; %fill the squares of the GPM that corispond to the Abp in with the current blocks type number
            end
            for apbleft=1:4  
set(Handlearray{(OAbp(2,apbleft)-3),(OAbp(1,apbleft)-3)}, 'BackgroundColor','black'); %set its old co ordinates to black
            end
for apbnew=1:4
    if Abt==2
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','red'); %Left in despite squares never rotating
    end
    if Abt==3
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','blue'); %as with left and right, if the Active block type is 3, set the pannels representing its position on the gpm to blue
    end
    if Abt==4
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','green'); 
    end
    if Abt==5
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','cyan'); 
    end
    if Abt==6
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','magenta');
    end
    if Abt==7
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','yellow'); 
    end
if Abt==8
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor',[0.74 0.34 0.98]);                            
end
end
GPMlast=GPM; 
OAbp=Abp;
            end
                  end
        end
        moving=0;
        end


    case 'downarrow'
if moving==0
        if fallproc==0
            moving=1; %A move is being considered
        Abpchecked=Abp+[0,0,0,0;1,1,1,1];
        GPMmove=GPMstatic;
        Moveable=1; %start under the assumption it is a valid move
            for l=1:4
        if GPMmove(Abpchecked(2,l),Abpchecked(1,l))~=1 
            Moveable=0; 
            disp('invalid move') %debug code
        end
            end
        if Moveable==1
            GPM=GPMstatic;
            Abp=Abp+[0,0,0,0;1,1,1,1];
            UAbp=Abp;
            for q=1:4
    GPM(Abp(2,q),Abp(1,q))=Abt; 
            end
            for apbleft=1:4  
set(Handlearray{(OAbp(2,apbleft)-3),(OAbp(1,apbleft)-3)}, 'BackgroundColor','black'); 
            end
for apbnew=1:4
    if Abt==2
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','red');
    end
    if Abt==3
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','blue'); 
    end
    if Abt==4
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','green'); 
    end
    if Abt==5
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','cyan'); 
    end
    if Abt==6
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','magenta');
    end
    if Abt==7
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','yellow'); 
    end
if Abt==8
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor',[0.74 0.34 0.98]);                            
end
end
GPMlast=GPM;
OAbp=Abp;
        end
        end
        moving=0;
end
        case 'p'
        disp('paused')
        waitforbuttonpress %allows you to pause the game without blocks falling further. However, when you unpause time will have continued ticking for the time between block falls, so it will imidiately fall one layer reducing the ability to cheat by spamming pause.
end


% --- Executes on button press in pushbutton.
function pushbutton_Callback(hObject, ~, handles)

if exist('HighScore.mat', 'file') ~= 2 %checks if the hiscore file exists, if exist returns 2 if its a file, so this is a if not exist
    high_score = 0; %sets hiscore to 0 if it doesn't exist, as hiscore is zero if it doesn't exist
    save('HighScore.mat', 'high_score') %then saves the hiscore file with a hiscore of 0 for the future
else
    load('HighScore.mat') %if the file does exist, it loads the file.
end

% hObject    handle to pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% reset focus
ReleaseFocusFromAnyUI(hObject)
global Handlearray %This is a 20 by 10 array of handles for the 20 by 10 grid of panels in the gui that constitute the 'pixels as it were' of the tetris game board. Did try for a for loop to construct but it was much quicker in the end to just write them all out.
global moving %is a move being considered?
global Abt %Active Block Type
moving=0; %upon starting, set the variable for is a move being considered currently to 0, representing, no.
gamego=1; %Start the while loop that runs the game going (see further down)
Handlearray={handles.uipanel1,handles.uipanel2,handles.uipanel3,handles.uipanel4,handles.uipanel5,handles.uipanel6,handles.uipanel7,handles.uipanel8,handles.uipanel9, handles.uipanel10;
    handles.uipanel11,handles.uipanel12,handles.uipanel13,handles.uipanel14,handles.uipanel15,handles.uipanel16,handles.uipanel17,handles.uipanel18,handles.uipanel19, handles.uipanel20;
    handles.uipanel21,handles.uipanel22,handles.uipanel23,handles.uipanel24,handles.uipanel25,handles.uipanel26,handles.uipanel27,handles.uipanel28,handles.uipanel29, handles.uipanel30;
    handles.uipanel31,handles.uipanel32,handles.uipanel33,handles.uipanel34,handles.uipanel35,handles.uipanel36,handles.uipanel37,handles.uipanel38,handles.uipanel39, handles.uipanel40;
    handles.uipanel41,handles.uipanel42,handles.uipanel43,handles.uipanel44,handles.uipanel45,handles.uipanel46,handles.uipanel47,handles.uipanel48,handles.uipanel49, handles.uipanel50;
handles.uipanel51,handles.uipanel52,handles.uipanel53,handles.uipanel54,handles.uipanel55,handles.uipanel56,handles.uipanel57,handles.uipanel58,handles.uipanel59, handles.uipanel60;
handles.uipanel61,handles.uipanel62,handles.uipanel63,handles.uipanel64,handles.uipanel65,handles.uipanel66,handles.uipanel67,handles.uipanel68,handles.uipanel69, handles.uipanel70;
handles.uipanel71,handles.uipanel72,handles.uipanel73,handles.uipanel74,handles.uipanel75,handles.uipanel76,handles.uipanel77,handles.uipanel78,handles.uipanel79, handles.uipanel80;
handles.uipanel81,handles.uipanel82,handles.uipanel83,handles.uipanel84,handles.uipanel85,handles.uipanel86,handles.uipanel87,handles.uipanel88,handles.uipanel89, handles.uipanel90;
handles.uipanel91,handles.uipanel92,handles.uipanel93,handles.uipanel94,handles.uipanel95,handles.uipanel96,handles.uipanel97,handles.uipanel98,handles.uipanel99, handles.uipanel100;
handles.uipanel101,handles.uipanel102,handles.uipanel103,handles.uipanel104,handles.uipanel105,handles.uipanel106,handles.uipanel107,handles.uipanel108,handles.uipanel109, handles.uipanel110;
    handles.uipanel111,handles.uipanel112,handles.uipanel113,handles.uipanel114,handles.uipanel115,handles.uipanel116,handles.uipanel117,handles.uipanel118,handles.uipanel119, handles.uipanel120;
    handles.uipanel121,handles.uipanel122,handles.uipanel123,handles.uipanel124,handles.uipanel125,handles.uipanel126,handles.uipanel127,handles.uipanel128,handles.uipanel129, handles.uipanel130;
    handles.uipanel131,handles.uipanel132,handles.uipanel133,handles.uipanel134,handles.uipanel135,handles.uipanel136,handles.uipanel137,handles.uipanel138,handles.uipanel139, handles.uipanel140;
    handles.uipanel141,handles.uipanel142,handles.uipanel143,handles.uipanel144,handles.uipanel145,handles.uipanel146,handles.uipanel147,handles.uipanel148,handles.uipanel149, handles.uipanel150;
handles.uipanel151,handles.uipanel152,handles.uipanel153,handles.uipanel154,handles.uipanel155,handles.uipanel156,handles.uipanel157,handles.uipanel158,handles.uipanel159, handles.uipanel160;
handles.uipanel161,handles.uipanel162,handles.uipanel163,handles.uipanel164,handles.uipanel165,handles.uipanel166,handles.uipanel167,handles.uipanel168,handles.uipanel169, handles.uipanel170;
handles.uipanel171,handles.uipanel172,handles.uipanel173,handles.uipanel174,handles.uipanel175,handles.uipanel176,handles.uipanel177,handles.uipanel178,handles.uipanel179, handles.uipanel180;
handles.uipanel181,handles.uipanel182,handles.uipanel183,handles.uipanel184,handles.uipanel185,handles.uipanel186,handles.uipanel187,handles.uipanel188,handles.uipanel189, handles.uipanel190;
handles.uipanel191,handles.uipanel192,handles.uipanel193,handles.uipanel194,handles.uipanel195,handles.uipanel196,handles.uipanel197,handles.uipanel198,handles.uipanel199, handles.uipanel200};

NextArray={handles.Next1,handles.Next2,handles.Next3,handles.Next4;handles.Next5,handles.Next6,handles.Next7,handles.Next8;
    handles.Next9,handles.Next10,handles.Next11,handles.Next12;handles.Next13,handles.Next14,handles.Next15,handles.Next16};
%Array of handles that make up the 4x4 next shape screen in the top left
NbSquare=[1,1,1,1;1,2,2,1;1,2,2,1;1,1,1,1]; %used to colour the Next shape screen (see lower).
NbLong=[1,1,1,1;1,1,1,1;3,3,3,3;1,1,1,1];
NbT=[1,4,1,1;1,4,4,1;1,4,1,1;1,1,1,1];
NbS=[1,1,1,1;1,5,5,1;1,1,5,5;1,1,1,1];
NbSr=[1,1,1,1;1,1,6,6;1,6,6,1;1,1,1,1];
NbL=[1,1,1,1;1,7,7,7;1,7,1,1;1,1,1,1];
NbLR=[1,1,1,1;8,8,8,1;1,1,8,1;1,1,1,1];
disp('Tetromino Onslaught Commenced') %debug code
for j=1:20 
    for i=1:10
%Start by setting the entire play areas 'pixel panels' to black
set(Handlearray{j,i}, 'BackgroundColor','black');
    end
end
global Abp %Active block position variable
global BcSquare %Block catagory Square
global BcT %Block catagory T
global BcS %Block catagory S
global BcLong %Block catagory Long
global BcSR %Block catagory S Reversed
global BcL %Block catagory L
global BcLR %Block catagory L Reversed
global y %Rotation State
global Score %Score!
global scorestring %Num2str of Score variable
global fallproc %Is a potential block fall currently being processed?
global GPMstatic %The static Global Positioning Matrix (no active blocks)
global OAbp %The Old Active block position (the one just processed)
global GPMlast %The Last GPMstatic+active block position on the GPM that was moved into
Score = 0; %set Score to 0 to start
scorestring=num2str(Score); %set the score string up
timer=1; %Timer is set to 1 second per move initialy
set(handles.text3, 'string',scorestring); %set the Text in the Score area of the GUI to the score string
set(handles.text4, 'string',num2str(high_score)); %set the Text in the Score area of the GUI to the score string
AbpSquare=[8,8,9,9;4,5,4,5]; %this is a square blocks initial spawn position
AbpLong=[7,8,9,10;4,4,4,4]; % this is a long straight blocks initial spawn position
AbpT=[8,8,9,8;4,5,5,6]; %this is a T blocks initial spawn position
AbpS=[9,8,8,7;5,5,4,4]; % this is a left pointing when long horizontal S style blocks initial spawn position
AbpSR=[9,8,8,7;4,4,5,5]; % this is a right pointing when long horizontal S style blocks initial spawn position
AbpL=[9,8,7,7;4,4,4,5]; %this is a long L blocks initial spawn position
AbpLR=[10,10,9,8;5,4,4,4]; % this is a long Reversed L blocks initial spawn position
BcSquare=2; %Catagory value for squares (used in colouring panels)
BcLong=3; %Catagory value for longs
BcT=4; %Catagory value for Ts
BcS=5; %Catagory value for Ss
BcSR=6; %Catagory value for SRs
BcL=7; %Catagory value for Ls
BcLR=8; %Catagory value for LRs
Nextshape=randi(7); %Next shape randomly selects the next shape up
if Nextshape==1 %if the next shape up is a 1
        Abp=AbpSquare; %Active block position set to Square initial
        Abt=BcSquare; % Active block Catagory set to square
end
if Nextshape==2
            Abp=AbpLong;
            Abt=BcLong;
end
if Nextshape==3
            Abp=AbpT;
            Abt=BcT;
end
if Nextshape==4
            Abp=AbpS;
            Abt=BcS;
end
if Nextshape==5
            Abp=AbpSR;
            Abt=BcSR;
end
if Nextshape==6
            Abp=AbpL;
            Abt=BcL;
end
if Nextshape==7
            Abp=AbpLR;
            Abt=BcLR;
end
GPMstatic=ones(23,16);%the gp static consists of the gp without any moving blocks impacting it
GPMstatic(1,:)=[100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100]; %represents part of the board top
GPMstatic(2,:)=[100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100];%represents part of the board top
GPMstatic(3,:)=[100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100];%represents part of the board top
GPMstatic(24,:)=[100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100];%represents part of the board floor
GPMstatic(25,:)=[100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100];%represents part of the board floor
GPMstatic(26,:)=[100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100];%represents part of the floor of the gameboard for the purpose of comparsons (see lower)
Sidespre=ones(26,1); 
Sides=Sidespre*100; %creates a 26x1 matrix of 100s
GPMstatic(:,1)=Sides; %represents part of the board edge
GPMstatic(:,2)=Sides;%represents part of the board edge
GPMstatic(:,3)=Sides;%represents part of the board edge
GPMstatic(:,14)=Sides;%represents part of the board edge
GPMstatic(:,15)=Sides;%represents part of the board edge
GPMstatic(:,16)=Sides;%represents part of the board edge
Nextup=0; %Refrenced later, set to a default 0
newblock=1;%Refrenced later, set to a default 1 at start

Nextshape=randi(7); %Nextshape is the next type of shape up. Used in order to display in the top left the upcoming shape
GPM=GPMstatic; %our GPM is equal to the static GPM as a baseline
%Randomly choose a new Next shape.
if Nextshape==1 %if Next shape type is 1, this is a square
        Nextshapedesign=NbSquare; %the design for the next shape in this case for the preview, is the square
end
if Nextshape==2
        Nextshapedesign=NbLong;
end
if Nextshape==3
        Nextshapedesign=NbT;
end
if Nextshape==4
        Nextshapedesign=NbS;
end
if Nextshape==5
        Nextshapedesign=NbSr;
end
if Nextshape==6
        Nextshapedesign=NbL;
end
if Nextshape==7
        Nextshapedesign=NbLR;
end
        for jo=1:4
    for io=1:4 
            if Nextshapedesign(jo,io)==1  %Using the design for the next shape, colours the Next Shape Screen to represent a preview of the next shape up.
set(NextArray{jo,io}, 'BackgroundColor','black');
            end
            if Nextshapedesign(jo,io)==2
set(NextArray{jo,io}, 'BackgroundColor','red');
            end
    if Nextshapedesign(jo,io)==3
set(NextArray{jo,io}, 'BackgroundColor','blue'); 
    end
    if Nextshapedesign(jo,io)==4
set(NextArray{jo,io}, 'BackgroundColor','green'); 
    end
    if Nextshapedesign(jo,io)==5
set(NextArray{jo,io}, 'BackgroundColor','cyan'); 
    end
     if Nextshapedesign(jo,io)==6
set(NextArray{jo,io}, 'BackgroundColor','magenta');
    end
    if Nextshapedesign(jo,io)==7
set(NextArray{jo,io}, 'BackgroundColor','yellow'); 
    end
    if Nextshapedesign(jo,io)==8
set(NextArray{jo,io}, 'BackgroundColor',[0.74 0.34 0.98]);                            
    end
    end
        end
while gamego==1 %Loops infinitely until this is set to 0 by a game over
    if newblock==1 %If we just got a new block, check to see if spawn position overlaps other current blocks. If so, the game is over
        y=1; %if we just got a new block, it is by default spawned at rotation =1 (the default rotation)
        for lu=1:4
        if GPM(Abp(2,lu),Abp(1,lu))~=1 %1 means nothing present. Hence if not 1, there is a block present in this tile
            gamego=0;% End the loop once we reach the bottom of it
            disp('Game Over!') %used in chat for debugging.
            GPMdeath=GPMlast %see in the consol for debugging the GPM sans your new block is how you ended up dieing
        end
        end
        NoOAbp=1; %if the block is newly spawned. There is no old active block position for this shape.
    end
    if gamego==1 %if the block spawned on another, then none of this is done as the game is over/it would overwrite other current blocks present
    newblock=0; %Now we have tested for if the new block spawned on a current placed block, we turn this check off untill its turned back on by another newly spawned block
    GPM=GPMstatic; %set the current GPM to the static GPM
    
    for l=1:4
        if GPM(Abp(2,l),Abp(1,l))~=1 %uses the active block position to reference the GPM and check if any of the tiles are not empty. If they are closed, the active block position is now considered overlapping a filled square. As a result, the previous cycles active block position is considered the final viable position for the block and is where it will stop at. A new block will be spawned
            Nextup=1; %This sets Nextup to 1, signaling its time for the next block, as the current block cannot go to this new active block position
            disp('Next Block Up!') %debug code
        end
    end
    if Nextup~=1 %This only runs if Nextup is not equal to 1. The active block can occupy the new ABP
    for q=1:4
    GPM(Abp(2,q),Abp(1,q))=Abt; %edit the GPM for the current active block square being considered to the active block square type.
    end
    
    UAbp=Abp; %the new Abp being considered considered the updated Abp, and will be what is coloured in
    if NoOAbp==0 %if this shape is not newly spawned at the top of the screen
for apbleft=1:4    
set(Handlearray{(OAbp(2,apbleft)-3),(OAbp(1,apbleft)-3)}, 'BackgroundColor','black'); %set its position on the game board to black
end
    end
    if NoOAbp==1 
        NoOAbp=0; %if it is newly spanwed, turn this off for the next iteration, as if it passes the checks to get here, it will be the same block as before, ergo not newly spawned.
    end
for apbnew=1:4
    if Abt==2 %if active block type is 2
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','red'); %set the 'pixel panels' on the game board where it is to red
    end
    if Abt==3
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','blue'); 
    end
    if Abt==4
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','green'); 
    end
    if Abt==5
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','cyan'); 
    end
    if Abt==6
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','magenta');
    end
    if Abt==7
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor','yellow'); 
    end
if Abt==8
set(Handlearray{(UAbp(2,apbnew)-3),(UAbp(1,apbnew)-3)}, 'BackgroundColor',[0.74 0.34 0.98]);                            
end
end
GPMlast=GPM; %GPMlast takes note of the Current GPM affected by the current ABP which has just been coloured
OAbp=Abp; %make a note of the abp just done, it will be used (unless a new shape is spawned in next up) as what to set to back to black (empty tiles)
    end
fallproc=0; %the fall is now not processing, moves can be made
pause(timer) %pause timer seconds. Timer decreases linearly from 1 to 0.1 by 0.01seconds every 100 score. then remains constant at 0.1 (IF YOU GET THERE!)
fallproc=1; %the fall is processing, moves cant now be initiated
while moving==1 %if moving is equal to 1, a move is currently being considered, hence we wait untill it completes, 0.1 second chunks at a time.
    pause(0.1)
end
Abp(2,:)=Abp(2,:)+[1,1,1,1]; %now we can increase the Abp by one
    %end
    if Nextup==1 %If Nextup has been set to one (aka the Abp checked failed because it overlapped static blocks or the bottom of the game board)
        GPMupdating=ones(27,16); %set the updating GPM to ones (the value used for if a cell is blank)
        GPMupdating(2:27,:)=GPMlast; %GPM last will have been the last position for the staticgpm and the active block position which was viable(the active blocks werent overlapping static blocks or edges). We set all but the top of the GPM updating to it. So it has a row of 1s above the top
        GPMupdating(1,:)=[100,100,100,100,100,100,100,100,100,100,100,100,100,100,100,100]; %set the row of 1s at the top of the updating gpm to 100s, the top is now 4 thick.
        pause(1)%pause for 1 second to give players a time to breath and to consider what to do with the upcoming block. also makes any filled lines satisfying to watch pop and vanish
        updated=0; %assume there will be no update to the last gpm (no rows will have been completed)
        for possiblescore=1:4 %do this 4 times, the maximum number of rows that can pop at once is 4, by putting a long 4x1 to complete 4 rows at once.
        for rows=1:20 %there are 20 rows in the game board. check for each of them
            noOnes=1; %set nozeros to 1, assume there are no ones (empty cells)
            for columns=1:10 %for each of the columns of the game board in this row
                if GPMupdating((5+(20-rows)),(columns+3))==1 %check, is this matrix cell filled with a 1?
                    noOnes=0; %if it is, then it is not true there are no ones in this row, so set noOnes to 0
                end
            end
            if noOnes==1 %if after checking every cell in the row all are not 1s, aka have blocks in, the row is filled
                GPMupdating(5:(25-rows),:)=GPMupdating(4:(24-rows),:); %Essentialy everything above the row just considered is copied and pasted one row down. moving everything above the row just deleted down one, deleting the row and moving things down to where they should now be.
                for columns=1:10
                    GPMupdating(5,(columns+3))=1; %because now the top of the board(in GPM updatings case, this is the 5th row)) now is full of 100s representing the top of the board, set these back to 1s, aka empty.
                end
            Score=Score+100; %as a row has just been deleted, increase score by 100
            if Score<= 1000
                timer=(1-(Score/2000));%gradualy reduces the timer by 0.05s per row down to 0.5s
            elseif Score <= 5000 %if score is less than or equal to 9000
            timer=(0.5-((Score-1000)/10000)); %gradualy reduces timer further by 0.1s per row down to 0.1s
            elseif Score >=5001 %if score is greater than or equal to 9001
                timer=0.1; %timer is set to 0.1s. blocks are allready falling quite fast enough!
            end
            scorestring=num2str(Score);%update the score string for the new score
            set(handles.text3, 'string',scorestring);%update the score boxs score that the player sees to the new score string
            if Score > high_score
                set(handles.text4, 'string',scorestring);%update the score boxs score that the player sees to the new score string
                high_score = Score; %set the hi score to the current score, as this run has exceeded the previous record
                save('HighScore.mat', 'high_score') %Since the hiscore has changed, update the Hiscore file.
            end
            disp('Score!') %used for debugging. 
            updated=1; %set updated to 1. signals a update has take place and so we need to recolour the boards pixel panels to represent the deleted rows lower down
            end
        end
        end
        GPMstatic=GPMupdating(2:27,:); %using the GPM updating, minus the top 4th row of top, create the new GPM static.
        GPM=GPMstatic; %set the current GPM to the new GPMstatic
        if updated==1 %if a update did take place (rows were deleted)
            for j=1:20
    for i=1:10 %this double for loop uses the gpm to refresh each and every pannel to its new colours. It checks and changes far more pannels than just moving or spawning a block. 
        if GPM((j+3),(i+3))==1
set(Handlearray{j,i}, 'BackgroundColor','black');
        end
    if GPM((j+3),(i+3))==2
set(Handlearray{j,i}, 'BackgroundColor','red');
    end
    if GPM((j+3),(i+3))==3
set(Handlearray{j,i}, 'BackgroundColor','blue'); 
    end
    if GPM((j+3),(i+3))==4
set(Handlearray{j,i}, 'BackgroundColor','green'); 
    end
    if GPM((j+3),(i+3))==5
set(Handlearray{j,i}, 'BackgroundColor','cyan'); 
    end
     if GPM((j+3),(i+3))==6
set(Handlearray{j,i}, 'BackgroundColor','magenta');
    end
    if GPM((j+3),(i+3))==7
set(Handlearray{j,i}, 'BackgroundColor','yellow'); 
    end
    if GPM((j+3),(i+3))==8
set(Handlearray{j,i}, 'BackgroundColor',[0.74 0.34 0.98]);                            
    end
    end
            end
        end
                    
                
        if Nextshape==1 %if the next shape (the one currently in the top left is set to 1, its a square)
        Abp=AbpSquare; %Active block position set to Square initial
        Abt=BcSquare; % Active block type set to square
        end
        if Nextshape==2
            Abp=AbpLong;
            Abt=BcLong;
        end
        if Nextshape==3
            Abp=AbpT;
            Abt=BcT;
        end
        if Nextshape==4
            Abp=AbpS;
            Abt=BcS;
        end
        if Nextshape==5
            Abp=AbpSR;
            Abt=BcSR;
        end
        if Nextshape==6
            Abp=AbpL;
            Abt=BcL;
        end
        if Nextshape==7
            Abp=AbpLR;
            Abt=BcLR;
        end
        Nextup=0; %Having now spawned the shape in the top left, next up is set to 0 (off)
        newblock=1; %It is a new shape just spawned (used in the game over check)
        Nextshape=randi(7); %Randomly choose a new Next shape.
        if Nextshape==1
        Nextshapedesign=NbSquare;
        end
        if Nextshape==2
        Nextshapedesign=NbLong;
        end
        if Nextshape==3
        Nextshapedesign=NbT;
        end
        if Nextshape==4
        Nextshapedesign=NbS;
        end
        if Nextshape==5
        Nextshapedesign=NbSr;
        end
        if Nextshape==6
        Nextshapedesign=NbL;
        end
        if Nextshape==7
        Nextshapedesign=NbLR;
        end
        for jo=1:4 %and using the next shapes design, redo the next shape preview in the top left
    for io=1:4
            if Nextshapedesign(jo,io)==1
set(NextArray{jo,io}, 'BackgroundColor','black');
            end
    if Nextshapedesign(jo,io)==2
set(NextArray{jo,io}, 'BackgroundColor','red');
    end
    if Nextshapedesign(jo,io)==3
set(NextArray{jo,io}, 'BackgroundColor','blue'); 
    end
    if Nextshapedesign(jo,io)==4
set(NextArray{jo,io}, 'BackgroundColor','green'); 
    end
    if Nextshapedesign(jo,io)==5
set(NextArray{jo,io}, 'BackgroundColor','cyan'); 
    end
     if Nextshapedesign(jo,io)==6
set(NextArray{jo,io}, 'BackgroundColor','magenta');
    end
    if Nextshapedesign(jo,io)==7
set(NextArray{jo,io}, 'BackgroundColor','yellow'); 
    end
    if Nextshapedesign(jo,io)==8
set(NextArray{jo,io}, 'BackgroundColor',[0.74 0.34 0.98]);                            
    end
    end
        end
    end
    end
end

function ReleaseFocusFromAnyUI(uiObj)
set(uiObj, 'Enable', 'off')
drawnow update;
set(uiObj, 'Enable', 'on')