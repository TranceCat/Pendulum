clear;
mp=1;
lc=0.5;
Ip=mp*lc/12; 
KGain=1;
Torque = 0;%StepValue
tspan =[0 10];
optionvec = simset('MaxStep',0.05);
optionvec = simset(optionvec,'InitialState',[1 0]);

[t,x] = sim('SimplePendulumBlock',tspan,optionvec);
figure(1)
plot(t,x(:,1),'k',t,x(:,2),'k');