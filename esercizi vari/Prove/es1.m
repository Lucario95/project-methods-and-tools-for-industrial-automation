%x(t+1) = A*x(t) + B*u(t)
%y(t) = C*x(t);
%x --> x1 x2 x3 -->  A 3x3
%u --> u1 u2 --> B 3x2

t_i = 0;
t_f = 20;
x0 = [-1 0.5 1]';

A = [0.9 -0.1 0; 0 0.75 -1; -1 0.9 0.6];

B = [0 0; 0 1; -0.7 0.1];

C = eye(3);

%   evoluzione dello stato tra 0 e TF nei seguenti casi:
%   1) sistema autonomo ( ingressi nulli );
%   2) sistema con ingressi u1 = 1 e u2 = -1;

%   1)
x_t = zeros(3,1);
x_t = x0;
y_t = zeros(3,1);
X = zeros(t_f+1,3);
Y = zeros(t_f+1,3);
for i = t_i:1:t_f
    x_prox = A*x_t;
    y_t = C*x_t;
    X(i+1,:) = x_prox';
    Y(i+1,:) = y_t';
    x_t = x_prox;
end
subplot(2,1,1)
plot(t_i:1:t_f, Y);
hold on;

%   2)
x_t = zeros(3,1);
u = [1 ; -1];
x_t = x0;
y_t = zeros(3,1);
X = zeros(t_f+1,3);
Y = zeros(t_f+1,3);
for i = t_i:1:t_f
    x_prox = A*x_t + B*u;
    y_t = C*x_t;
    X(i+1,:) = x_prox';
    Y(i+1,:) = y_t';
    x_t = x_prox;
end
subplot(2,1,2)
plot(t_i:1:t_f, Y);