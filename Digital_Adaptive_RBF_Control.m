function [sys,x0,str,ts] = spacemodel(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts]=mdlInitializeSizes
global b c namna
sizes = simsizes;
sizes.NumContStates = 5;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 2;
sizes.NumInputs = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0 = rands(1,5);
str = [];
ts = [0 0];
c=[-1 -0.5 0 0.5 1;
   -1 -0.5 0 0.5 1];
b=1.2;
namna=10;

function sys=mdlDerivatives(t,x,u)
global b c namna
xd=sin(t);
dxd=cos(t);

x1=u(2);
x2=u(3);
e=x1-xd;
de=x2-dxd;
s=namna*e+de;

W=[x(1) x(2) x(3) x(4) x(5)]';
xi=[x1;x2];

h=zeros(5,1);
for j=1:1:5
    h(j)=exp(-norm(xi-c(:,j))^2/(2*b^2));
end
gama=100;
for i=1:1:5
    sys(i)=gama*s*h(i);
end

function sys=mdlOutputs(t,x,u)
global b c namna
xd=sin(t);
dxd=cos(t);
ddxd=-sin(t);

x1=u(2);
x2=u(3);
e=x1-xd;
de=x2-dxd;
s=namna*e+de;

W=[x(1) x(2) x(3) x(4) x(5)];
xi=[x1;x2];

h=zeros(5,1);
for j=1:1:5
    h(j)=exp(-norm(xi-c(:,j))^2/(2*b^2));
end
fn=W*h;
xite=0.20;

%fn=10*x1+x2; %Precise f
ut=-namna*de+ddxd-fn-xite*sign(s);

sys(1)=ut;
sys(2)=fn;