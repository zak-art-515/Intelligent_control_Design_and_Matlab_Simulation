function dx=Plant(t,x,flag,para)
    dx=zeros(2,1);
    u=para;
    f=10*x(1)*x(2);
    dx(1)=x(2);
    dx(2)=f+u;
end