% RunHangingPendulum.m
% This m-file is a  modification of the m-file RunHangingPendulum.m
% Matz Lenells, 2012 Dec 13
% I needed to "open" (click on the filename so that a window showed the
% the blockdiagram defined by) the file HangingPendulum.mdl
% before I could run this file successfully.
clear
clf
Step_time=1;
Initial_value=0;
Final_value=0;
Sample_time=0;
m=1; lc=1;  Jc=0; b=0;
J=Jc+m*lc^2;    g=10;
parNameValStruct.AbsTol  = '1e-6';
parNameValStruct.RelTol  = '1e-6';
parNameValStruct.MaxStep  = '0.5';
parNameValStruct.StartTime  = '0';
parNameValStruct.LimitDataPoints  = 'off';   %Default is '1000'.
parNameValStruct.TimeSaveName  = 't';        %Default is the name 'tout'.
parNameValStruct.StateSaveName = 'myx'; %
parNameValStruct.SaveState = 'on';         %
parNameValStruct.SaveOutput = 'on';        %Is not used.
parNameValStruct.StopTime  = '6';
x0String='[0.05; 0.2]';
set_param('HangingPendulum', 'LoadInitialState', 'on');
parNameValStruct.InitialState =x0String;
set_param('HangingPendulum/Step', 'Time', 'Step_time');
set_param('HangingPendulum/Step', 'Before', 'Initial_value');
set_param('HangingPendulum/Step', 'After', 'Final_value');
set_param('HangingPendulum/Step', 'SampleTime', 'Sample_time');
set_param('HangingPendulum/To Workspace','SaveFormat','Array');
set_param('HangingPendulum/To Workspace1','SaveFormat','Array');
simout = sim('HangingPendulum', parNameValStruct);
t=simout.get('t');
myx=simout.get('myx');
figure(1)
plot(t,myx(:,1),'k',t,myx(:,2),'b');
titlestr =strcat('Initial state x0=',x0String);
title(strcat(titlestr,' x1 is black, x2 is blue'));
figure(2)
plot(t,simout.get('u'));
title('Input signal u to the process');
figure(3)
plot(t,simout.get('y'));
title('Output signal y from the process');