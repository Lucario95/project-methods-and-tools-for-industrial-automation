%Plottare la funzione in 2D
%   y = (110-60x^2+x^3)/(110+10x^2+x^4)

% X = 1:0.1:200;
% 
% Y = (110-60*X.^2+X.^3)./(110+10*X.^2+X.^4);
% plot(X,Y)

%o

X = linspace(0,100, 1000);
Y = (110-60*X.^2+X.^3)./(110+10*X.^2+X.^4);
plot(X,Y);
title('BEST PLOT EVER');