%PARTE 3 PROGETTO MTFIA

clc;
clear;


% DESCRIZIONE
% Si assume che lo stato sia perfettamente osservabile. Si vuole definire
% il controllo ottimo in modo da minimizzare l'errore quadratico dello
% stato e del controllo rispetto al seguente segnale, con time horizon di 7
% giorni:
% x1(k) ~ 10, k = 3, 4
% x2(k) ~ -10, per ogni k
% x3(k) ~ 0, k = 5


% DEFINIZIONE PARAMETRI
sample_time = 1;
horizon = 7;
interval = 1:sample_time:horizon;
T = length(interval);

A = eye(3); 
B = [2 0 -1 0 0; 0 1 0 -2 0; 0 0 1 3 -1];
C = eye(3);
D = zeros(3,5);

X0 = [100, 70, -45]';


% DEFINIZIONE MATRICI Q E R
q = 7;      % Definisce il peso (costo) dello stato.
r = 1;      % Definisce il peso (costo) del controllo.
gamma = 3;  % Peso per portare a zero lo stato.
eta = 2.26; % Peso per portare a zero il controllo.
Q = q * ([1 -1 0; -1 1 0; 0 0 0] + gamma * eye(3));
Qf = Q;
R = r * ([16 0 -4 0 0; 0 0 0 0 0; -4 0 1 0 0; 0 0 0 1 -2; 0 0 0 -2 4] + eta * eye(5));


% DEFINIZIONE SEGNALE DA TRACCIARE
Z = zeros(size(X0,1), T);
Z(1,3:4) = 10;              % x1(k) ~ 10, k = 3, 4
Z(2,:) = -10;               % x2(k) ~ -10, per ogni k
Z(3,5) = 0;                 % x3(k) ~ 0, k = 5


% CALCOLO DI COMPONENTE PROPORZIONALE E INTEGRALE
[Kp ,Ki, g] = mylqt(A, B, C, Q, Qf, R, T, Z, X0);


% SIMULAZIONE E PLOT DEL SISTEMA
X = zeros(size(X0,1), T);
U = zeros(size(B,2), T);
Y = zeros(size(C,1), T);
X(:,1) = X0;

for k = 1:T-1
    % Calcolo del controllo ottimo:
    U(:,k) = -Kp(:,:,k) * X(:,k) + Ki(:,:,k) * g(:,k+1);
    X(:,k+1) = A * X(:,k) + B * U(:,k);
    Y(:,k) = C * X(:,k);
end

figure(1)
subplot(2, 1, 1);
plot(interval, X, interval, Z);
title('Confronto stato e segnale da tracciare');
legend('x1', 'x2', 'x3', 'z1', 'z2', 'z3');
subplot(2, 1, 2);
plot(interval, U);
title('Controllo ottimo');
legend('u1', 'u2', 'u3', 'u4', 'u5');
figure(2)
subplot(3, 1, 1);
plot(interval, X(1,:), interval, Z(1,:));
title('Componente 1');
legend('x1', 'z1');
subplot(3, 1, 2);
plot(interval, X(2,:), interval, Z(2,:));
title('Componente 2');
legend('x2', 'z2');
subplot(3, 1, 3);
plot(interval, X(3,:), interval, Z(3,:));
title('Componente 3');
legend('x3', 'z3');