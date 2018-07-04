clc;
clear;

% La prima riga corrisponde alle X, la seconda riga corrisponde alle Y:
dataset = [ 14 15 15 16 17 18 20 20 21 24; 18 16 20 18 21 24 24 25 25 27 ];

sum_y_i = 0;    % Somma delle Y.
sum_x_i = 0;    % Somma delle X.
sum_x_y_i = 0;  % Somma dei prodotti X_i, Y_i.
sum_x_2_i = 0;  % Somma dei quadrati di X_i.
sum_y_2_i = 0;  % Somma dei quadrati di Y_i.

for i = 1:size(dataset, 2) 
    sum_x_i = sum_x_i + dataset(1, i);
    sum_y_i = sum_y_i + dataset(2, i);
    sum_x_y_i = sum_x_y_i + dataset(1, i) * dataset(2, i);
    sum_x_2_i = sum_x_2_i + dataset(1, i)^2;
    sum_y_2_i = sum_y_2_i + dataset(2, i)^2;
end

sum_x_2 = sum_x_i^2;    % Quadrato della somma delle X.
sum_y_2 = sum_y_i^2;    % Quadrato della somma delle Y.

n = 10;
a = (sum_y_i * sum_x_2_i - sum_x_i * sum_x_y_i) / (n * sum_x_2_i - sum_x_2);
b = (n * sum_x_y_i - sum_x_i * sum_y_i) / (n * sum_x_2_i - sum_x_2);
c = (sum_x_i * sum_y_2_i - sum_y_i * sum_x_y_i) / (n * sum_y_2_i - sum_y_2);
d = (n * sum_x_y_i - sum_x_i * sum_y_i) / (n * sum_y_2_i - sum_y_2);

disp("Coefficiente di correlazione");
r = sqrt(b * d)
 
plot(dataset(1,:), dataset(2,:), '*');
hold on;

Y = zeros(1, n);
for i = 1: size(dataset, 2)
    Y(1, i) = a + b * dataset(1, i);
end
plot(dataset(1,:), Y);