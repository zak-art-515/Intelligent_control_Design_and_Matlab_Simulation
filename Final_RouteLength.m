% Calculate Final Route Length
function L=Final_RouteLength(V,cities)
[xxx,order]=max(V);
New=cities(:,order);
New=[New New(:,1)];
[rows,cs]=size(New);
L=0;
for i=2:cs
    L=L+dist(New(:,i-1)',New(:,i));
end