clc;clear;
x0 = 1;
y0 = 0;

x = linspace(-2,3.5,23);
y = linspace(-2,3.5,23);
[X,Y] = meshgrid(x,y);


Z1 = 2*X+3*Y+1;
fz1 = 2*x0+3*y0 +1;  % value of function at point (1,0)
Z2 = X.^2 + Y.^2 - X.*Y -5;
fz2 =x0^2 + y0^2 - x0*y0 -5;
Z3 = (X-5).*cos(Y-5) - (Y-5).*sin(X-5);
fz3 = (x0-5)*cos(y0-5) - (y0-5)*sin(x0-5);

[U1,V1] = gradient(Z1,0.25);
[U2,V2] = gradient(Z2,0.25);
[U3,V3] = gradient(Z3,0.25);

t = (X == x0) & (Y == y0);
ind = find(t);
% gradient at the point (1,0)
Z1t = @(x,y) fz1+ (U1(ind))*(x-x0) + (V1(ind))*(y-y0); 
Z2t = @(x,y) fz2+ (U2(ind))*(x-x0) + (V2(ind))*(y-y0);
Z3t = @(x,y) fz3+ (U3(ind))*(x-x0) + (V3(ind))*(y-y0);


figure
subplot(1,3,1)
surfc(X,Y,Z1)   %plot function and contour
hold on
surf(X,Y,Z1t(X,Y)) %plot tangent plane
plot3(x0,y0,fz1,'r.','MarkerSize',20)  %plot point on function
hold off
axis([-2 3.5 -2 3.5 -10 20])
pbaspect([1 1 1])
title('f1(x,y) = 2x + 3y + 1')


subplot(1,3,2)
surf(X,Y,Z2)   
hold on
% shift contour to z=-15 plane (bottom surface of coordinate system)
[~,h] = contour(X,Y,Z2);
h.ContourZLevel = -15;
surf(X,Y,Z2t(X,Y))
plot3(x0,y0,fz2,'r.','MarkerSize',20)
hold off
axis([-2 3.5 -2 3.5 -15 15])
pbaspect([1 1 1])
title('f2(x,y) = x^2 + y^2 - xy - 5')


subplot(1,3,3)
surfc(X,Y,Z3)   %plot function
hold on
surf(X,Y,Z3t(X,Y))
plot3(x0,y0,fz3,'r.','MarkerSize',20)
hold off
axis([-2 3.5 -2 3.5 -15 15])
pbaspect([1 1 1])
title('f3(x,y) = (x - 5)cos(y - 5) - (y - 5)sin(x - 5)')

