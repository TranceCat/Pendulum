function sfcn2_HangingPendulum(block)
%%S-function modeling   a hanging pendulum
%Author Matz Lenells 2012 Dec 07,
setup(block);
%endfunction
function setup(block)
  %% Register number of dialog parameters
  block.NumDialogPrms = 5;
  %% Register number of input and output ports
  block.NumInputPorts  = 1;
  block.NumOutputPorts = 1;
  %% Setup functional port properties to dynamically inherited.
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;
  block.InputPort(1).Dimensions        = 1;
  block.InputPort(1).DirectFeedthrough = false;
  block.OutputPort(1).Dimensions = 1;
  %block.OutputPort(2).Dimensions = 1;
  %block.OutputPort(3).Dimensions = 1;
  %block.OutputPort(4).Dimensions = 1;
  %% Set block sample time to continuous
  block.SampleTimes = [0 0];
  %% Setup Dwork
  block.NumContStates = 2;
  %% Register methods
% block.RegBlockMethod('SetInputPortSamplingMode',@SetInpPortFrameData);
  block.RegBlockMethod('InitializeConditions',@InitConditions);
  block.RegBlockMethod('Outputs',@Output);
  block.RegBlockMethod('Derivatives',@Derivative);
%endfunction
%function SetInpPortFrameData(block, idx, fd)
  % Set the block sampling mode to Frame or Sample depending on the
  % sampling mode of the input signal.
 % block.InputPort(idx).SamplingMode  = fd;
  %block.OutputPort(1).SamplingMode = fd;
 %endfunction
function InitConditions(block)
  %% Initialize Dwork
  block.ContStates.Data(1) = 0;
  block.ContStates.Data(2) = 0;
%endfunction
function Output(block)
  block.OutputPort(1).Data = block.ContStates.Data(1);
 %endfunction
function Derivative(block)
     m = block.DialogPrm(1).Data;
     lc = block.DialogPrm(2).Data;
     b= block.DialogPrm(3).Data;
     Jc=block.DialogPrm(4).Data;
     g=block.DialogPrm(5).Data;
     J=Jc+m*lc^2;
     a21=-m*lc*g/J;
     a22=-b/J;
     b2= 1/J;
     u =  block.InputPort(1).Data;
     x3= block.ContStates.Data(1);
     x4= block.ContStates.Data(2);
     block.Derivatives.Data(1) = x4;
     block.Derivatives.Data(2) = a21*sin(x3)+a22*x4+b2*u;
%endfunction