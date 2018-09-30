clc;clear;
x = linspace(-2,3.5,111);
y = linspace(-2,3.5,111);
[X,Y] = meshgrid(x,y);

x0=1;
y0=0;

% find index for (x0,y0) in the U,V meshgrid
s = (X == x0) & (Y== y0);
ind = find(s);

Z1 = 2*X+3*Y+1;
Z2 = X.^2 + Y.^2 - X.*Y -5;
Z3 = (X-5).*cos(Y-5) - (Y-5).*sin(X-5);

[U1,V1] = gradient(Z1,0.05);
[U2,V2] = gradient(Z2,0.05);
[U3,V3] = gradient(Z3,0.05);

%equations for tangent lines
Z1t = -1/1.5*x+1/1.5;
Z2t = 2*x - 2;
Z3t = 1.425/1.4605*x-1.425/1.4605;

figure
subplot(1,3,1)
q = quiver(X(ind),Y(ind),U1(ind),V1(ind));  % plot gradient vector
q.LineWidth = 2;
q.MaxHeadSize = 0.5;
hold on
contour(X,Y,Z1,15) %plot contours
plot(x,Z1t,'--','LineWidth',2);   %plot tangent
plot(X(ind),Y(ind),'r*','MarkerSize',6)  %plot the point (1,0)
hold off
axis([-2 3.5 -2 3.5])
pbaspect([1 1 1])
title('f1(x,y) = 2x + 3y + 1')


subplot(1,3,2)
contour(X,Y,Z2)
hold on
q = quiver(X(ind),Y(ind),U2(ind),V2(ind));
q.LineWidth = 2;
q.MaxHeadSize = 0.5;
plot(x,Z2t,'--','Linewidth',2)
plot(X(ind),Y(ind),'r*','MarkerSize',6)
hold off
axis([-2 3.5 -2 3.5])
pbaspect([1 1 1])
title('f2(x,y) = x^2 + y^2 - xy - 5')


subplot(1,3,3)
contour(X,Y,Z3,20)
hold on
q = quiver(X(ind),Y(ind),U3(ind),V3(ind));
q.LineWidth = 2;
q.MaxHeadSize = 0.5;
plot(x,Z3t,'--','Linewidth',2)
plot(X(ind),Y(ind),'r*','MarkerSize',6)
hold off
axis([-2 3.5 -2 3.5])
pbaspect([1 1 1])
title('f3(x,y) = (x - 5)cos(y - 5) - (y - 5)sin(x - 5)')

