function f =evaluate_localbest(x1,x2,x3)
K0=[x1;x2;x3];
K1=[func(x1),func(x2),func(x3)];
[maxvalue index]=max(K1);
plocalbest=K0(index,:);
f=plocalbest;