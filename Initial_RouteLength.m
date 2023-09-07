% Calculate Initial Route Length
function L0=Initial_RouteLength(cities)
[r,c]=size(cities);
L0=0;
for i=2:c
    L0=L0+dist(cities(:,i-1)',cities(:,i));
end