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
global cij bj c
sizes = simsizes;
sizes.NumContStates = 5;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 2;
sizes.NumInputs = 3;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0 = 0.1*ones(1,5);
str = [];
ts = [];
cij=0.5*[-2 -1 0 1 2;
         -2 -1 0 1 2];
bj=5;
c=10;

function sys=mdlDerivatives(t,x,u)
global cij bj c
xd=sin(t);dxd=cos(t);
x1=u(1);x2=u(2);
e=x1-xd;
de=x2-dxd;

s=c*e+de;

xi=[x1;x2];
h=zeros(5,1);
for j=1:1:5
    h(j)=exp(-norm(xi-cij(:,j))^2/(2*bj^2));
end
gama=0.01;
W=[x(1) x(2) x(3) x(4) x(5)]';

for i=1:1:5
    sys(i)=1/gama*s*h(i);
end

function sys=mdlOutputs(t,x,u)
global cij bj c
xd=sin(t);dxd=cos(t);ddxd=-sin(t);
x1=u(1);x2=u(2);
e=x1-xd;
de=x2-dxd;

s=c*e+de;
W=[x(1) x(2) x(3) x(4) x(5)]';
xi=[x1;x2];
h=zeros(5,1);
for j=1:1:5
    h(j)=exp(-norm(xi-cij(:,j))^2/(2*bj^2));
end
fn=W'*h;
xite=10;
b=100;

delta=0.05;
kk=1/delta;
if abs(s)>delta
    sats=sign(s);
else
    sats=kk*s;
end

ut=1/b*(-fn+ddxd-c*de-xite*sats);

sys(1)=ut;
sys(2)=fn;