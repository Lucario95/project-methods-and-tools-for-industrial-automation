%x(t+1) = A*x(t) + B*u(t)
%y(t) = C*x(t);
%x --> x1 x2 x3 -->  A 3x3
%u --> u1 u2 --> B 3x2

t_i = 0;
t_f = 20;

x0 = [-1 0.5 1]';
t = 0:t_f;

A = [0.9 -0.1 0; 0 0.75 -1; -1 0.9 0.6];

B = [0 0; 0 1; -0.7 0.1];

C = eye(3);

%   evoluzione dello stato tra 0 e TF nei seguenti casi:
%   1) sistema autonomo ( ingressi nulli );
%   2) sistema con ingressi u1 = 1 e u2 = -1;

%   1)
X = zeros(3, t_f+1);
Y = zeros(3, t_f+1);
X(:,1) = x0;
for i = t_i+1:1:t_f
    X(:,i+1) = A*X(:,i);
    Y(:,i) = C*X(:,i);
end
subplot(2,1,1)
plot(t_i:1:t_f, Y);
hold on;

%   2)
X = zeros(3, t_f+1);
Y = zeros(3, t_f+1);
u = [1 -1]';
X(:,1) = x0;
for i = t_i+1:1:t_f
    X(:,i+1) = A*X(:,i)+ B*u;
    Y(:,i) = C*X(:,i);
end
subplot(2,1,2)
plot(t_i:1:t_f, Y);