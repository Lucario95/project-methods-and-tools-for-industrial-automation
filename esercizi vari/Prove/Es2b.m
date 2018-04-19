%Plottare la funzione in 3D 
% Z = X*(1-X)*Y(1-Y)

X = linspace(0,1, 100);
Y = linspace(0,1, 100);
[X,Y] = meshgrid(X,Y);
Z = X.*(1-X).*Y.*(1-Y);
surf(X,Y,Z);
title('BEST PLOT EVER 1');

figure(2);
contour(X,Y,Z);
title('BEST PLOT EVER 2');