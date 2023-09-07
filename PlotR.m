% Give Path optimization plot
function PlotR(V,cities)
figure;

cities=[cities cities(:,1)];

[xxx,order]=max(V);
New=cities(:,order);
New=[New New(:,1)];

subplot(1,2,1);
plot( cities(1,1), cities(2,1),'r*' ); %First city
hold on;
plot( cities(1,2), cities(2,2),'+' ); %Second city
hold on;
plot( cities(1,:), cities(2,:),'o-' ), xlabel('X axis'), ylabel
('Y axis'), title('Original Route');
axis([0,1,0,1]);

subplot(1,2,2);
plot( New(1,1), New(2,1),'r*' ); %First city
hold on;
plot( New(1,2), New(2,2),'+' ); %Second city
hold on;
plot(New(1,:),New(2,:),'o-');
title('TSP solution');
xlabel('X axis');ylabel('Y axis');
axis([0,1,0,1]);
axis on