% RunHangingPendulum.m
% I needed to "open" (click on the filename so that a window showed the
% the blockdiagram defined by) the file HangingPendulum.mdl
% before I could run this file successfully.
% This m-file is a  modification of the m-file RunCartWithHangingPendulum.m
% The author of that file is Matz Lenells, 091212, modified 2010 May 24
% The same author for this file.
% Date 2012 Dec 08
% The mdl-file HangingPendulum
% defines an open system  represented as a block diagram where the
% output signal of the process block is the angle of the pendulum. The
% input signal is the torque to the pendulum.
% The program, which defines this simulation study consists of:
% 1) this m-file, called "RunHangingPendulum.m"
% 2) the mdl-file, called "HangingPendulum.mdl"
% 3) the s-function, called "sfcn2_HangingPendulum.m"
% The intention is that the text files of the two m-files, the block
% diagram given by the mdl-file,  and the default values
% for the blocks define in a unique way the simulation study.
% This file, "RunHangingPendulum.m", defines many  parameters of the
% simulation.
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
parNameValStruct.StateSaveName      = 'myx'; %
parNameValStruct.SaveState      = 'on';         %
%parNameValStruct.OutputSaveName     = 'y1';
% This command is for the case when one uses outports. Outport, see
% Simulink->Sinks->Out1.
parNameValStruct.SaveOutput      = 'on';        %Is not used.
parNameValStruct.StopTime  = '6';
x0 = [0.05; 0.2]; %One could write  x0String directly because we
% use the parameter x0 only when we define x0String.
x0String = strcat(' [',num2str(x0(1)),' ; ', num2str(x0(2)),' ] ');
set_param('HangingPendulum2', 'LoadInitialState', 'on');
% Here follows an explanation of how you could know that you should use the
% identifier 'LoadInitialState' or why you should send the command 'on'.
% If you do not care about this knowledge  you can just skip this comment.
% The window showing the block diagram "HangingPendulum.mdl" has
% a menu row. Click on "Simulation" --> "Configuration Parameters"
% A pane shows up. Select "Data Import/Export". We want to assign the value
% for the initial state in this m-file. This is only possible if the square
% button is ticked on. One way tog get knowledge about the identifier of
% parameter holding the tick value of this square is to hold the mouse
% pointer on the text "Initial state". Make a right mouse click. Then a
% small pane holding the text "What's This?". Click on the text. Then a
% shows up named "Initial state". Half a page down you find
% "Command-Line Information". There you find that the identifier of the
% parameter holding the tick valuey is "LoadInitialState".
% This should be explanation enough.
parNameValStruct.InitialState =x0String;
% You could equally well write
% parNameValStruct.InitialState ='[0.1; 0]'; %tested this 2012 Dec 12
set_param('HangingPendulum2/sfcn2HangingPendulum',...
    'Parameters', 'm, lc, b, Jc, g');
set_param('HangingPendulum2/Step', 'Time', 'Step_time');
% To find the name "HangingPendulum2/Step" open the file
% HangingPendulum2.mdl. Highlight the block "Step". In command
% window do the command:
% >>gcb %Get pathname of current block
% The answer is HangingPendulum2/Step
% Double click on the block "Step". Then a dialog window appears.
% Four text lines are open for writing, each one with its own head line. In
% this case "Step time:", ... , "Sample time:".
% In the text line one can write a real value or an identifier of a parameter
% of a real value. In this way the user can assign a value to a parameter
% whose usage corresponds to the head line of the text line. The identifier
% of the last mentioned parameter is found by use of
% "Help" --> "Product help". Write then  "/Simulink/User's Guide/Simulink
% Reference/Model and Block Parameters/Block-Specific Parameters"
% in the search line.
% You will come to a page where all but half a page of the top is a very
% long list of names of identifiers. At the top, click on
% "Sources Library Block Parameters".
% Then scroll down to the head line "Step". There you see that the
% identifier of the parameter associated with the head line "Step time" is
% "Time". As I see it the name of the identifier should be possible to
% derive from the head line "Step time" but it is not.
% The parameter "Time" is assigned the value of the parameter "StepTime".
set_param('HangingPendulum2/Step', 'Before', 'Initial_value');
set_param('HangingPendulum2/Step', 'After', 'Final_value');
set_param('HangingPendulum2/Step', 'SampleTime', 'Sample_time');
set_param('HangingPendulum2/To Workspace','SaveFormat','Array');
simout = sim('HangingPendulum2', parNameValStruct);
t=simout.get('t');
myx=simout.get('myx');
plot(t,myx(:,1),'k',t,myx(:,2),'b');
%print -depsc /Users/matz/MinaMBPDokument/Reglerteknik/MagisterVxu/...
%  ht2009ED4114/Labbar/HangingPendulum/CartWithHangingPendulumPlotAut
titlestr =strcat('Initial state x0=',x0String);
title(strcat(titlestr,' x1 is black, x2 is blue'));
figure(2)
uloc=simout.get('u').signals.values;
plot(t,uloc);
title('Input signal u to the process');
figure(3)
yloc = simout.get('y');
plot(t,yloc);
title('Output signal y from the process');
% web([docroot '/toolbox/simulink/slref/f23-20073.html'])
%http://www.mathworks.com/access/helpdesk/help/toolbox/simulink/slref/f23-2
%0073.html
