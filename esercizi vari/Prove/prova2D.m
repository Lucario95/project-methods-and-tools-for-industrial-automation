
X = linspace(-100, 100, 500);
Y = X.^2 + 2*X + 1;
subplot(2,1,1);
plot(X,Y);
title('BEST PLOT EVER');
Y = -X.^2 + 2*X + 1;
subplot(2,1,2);
plot(X,Y);