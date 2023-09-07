function [sys,x0,str,ts]=s_function(t,x,u,flag)
switch flag,
    case 0,
        [sys,x0,str,ts]=mdlInitializeSizes;
    case 1,
        sys=mdlDerivatives(t,x,u);
    case 3,
        sys=mdlOutputs(t,x,u);
    case {2, 4, 9 }
        sys = [];
    otherwise
        error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates = 2;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 2;
sizes.NumInputs = 1;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0.3 -0.6];
str=[];
ts=[];

function sys=mdlDerivatives(t,x,u)
g=9.8;m = 2;M = 8;l=0.5;a = 1/(M+m);
S=l*(4/3-a*m*l*(cos(x(1))^2));
fx=g*sin(x(1))-a*m*l*x(2)^2*sin(2*x(1))/2;
fx=fx/S;
gx=-cos(x(1))*a;
gx=gx/S;
sys(1)=x(2);
sys(2)=fx + gx*u;

function sys=mdlOutputs(t,x,u)
g=9.8;m = 2;M = 8;l=0.5;a = 1/(M+m);
S=l*(4/3-a*m*l*(cos(x(1))^2));
fx=g*sin(x(1))-a*m*l*x(2)^2*sin(2*x(1))/2;
fx=fx/S;
gx=-cos(x(1))*a;
gx=gx/S;
sys(1)=x(1);
sys(2)=x(2);