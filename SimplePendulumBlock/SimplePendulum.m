function SimplePendulum(block)
  setup(block);
%endfunction
%
function setup(block)
  %% Register number of dialog parameters
  block.NumDialogPrms = 3;
  %% Register number of input and output ports
  block.NumInputPorts  = 1;
  block.NumOutputPorts = 1;
  %% Setup functional port properties to dynamically inherited.
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;
  block.InputPort(1).Dimensions        = 1;
  block.InputPort(1).DirectFeedthrough = false;
  block.OutputPort(1).Dimensions       = 1;
  %% Set block sample time to continuous
  block.SampleTimes = [0 0];
  %% Setup Dwork
  block.NumContStates = 2;
  %% Register methods
  block.RegBlockMethod('InitializeConditions',@InitConditions);
  block.RegBlockMethod('Outputs',@Output);
  block.RegBlockMethod('Derivatives',@Derivative);
%endfunction
function InitConditions(block)
  %% Initialize Dwork
  block.ContStates.Data(1) =0;
    block.ContStates.Data(2) =0;
%endfunction
function Output(block)
  block.OutputPort(1).Data = block.ContStates.Data(1);
%endfunction
function Derivative(block)
     Ip = block.DialogPrm(1).Data;
     mp = block.DialogPrm(2).Data;
     lc=block.DialogPrm(3).Data;
     Torque=block.InputPort(1).Data;
     x1= block.ContStates.Data(1);
     x2= block.ContStates.Data(2);
     block.Derivatives.Data(1) = x2;
     block.Derivatives.Data(2) = -x1/(Ip+mp*lc^2) ;
%endfunction
