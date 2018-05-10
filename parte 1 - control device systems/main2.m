%PARTE 2 PROGETTO MTFIA

clc;
clear;


% DESCRIZIONE
% Si assume che non sia possibile misurare x2.
% Si assume che la misura dello stato sia affetta da un errore V a media
% nulla e varianza nota, con distribuzione normale.
% Si assume che il modello sia affetto da un errore W a media nulla e
% varianza nota, con distribuzione normale.
% Si vuole definire il controllo ottimo.


% DEFINIZIONE PARAMETRI
sample_time = 1;
horizon = 7;
interval = 1:sample_time:horizon;
T = length(interval);

A = eye(3); 
B = [2 0 -1 0 0; 0 1 0 -2 0; 0 0 1 3 -1];
% Y presenta solo due componenti:
C = [1 0 -1; 0 -1 1];
D = zeros(2,5);

% Valor medio della distribuzione normale di X:
X0 = [100, 70, 20]';


% DEFINIZIONE DEI RUMORI
% Valore medio delle distribuzioni normali di V e W:
mu = 0;
MUv = mu * ones(size(C,1),T);
MUw = mu * ones(size(X0,1),T);
% Varianze delle distribuzioni normali di X, V, e W:
sigmaX = 1 * eye(3);
sigmaV = 1.5 * eye(2);
sigmaW = 2 * eye(3);

% Inizializzazione generatori di numeri casuali:
rng(1, 'twister');
randValuesV = randn(size(C,1), 1, T);
rng(0, 'twister');
randValuesW = randn(size(X0,1), 1, T);

W = zeros(size(X0,1), 1, T);
V = zeros(size(C,1), 1, T);
% Inizializzazione dei rumori con valore medio e varianza:
for i = 1:T
W(:,:,i) = sigmaW * randValuesW(:,:,i) + MUw(:,i);
V(:,:,i) = sigmaV * randValuesV(:,:,i) + MUv(:,i);
end


% DEFINIZIONE MATRICI Q E R
q = 2;      % Definisce il peso (costo) dello stato.
r = 1;      % Definisce il peso (costo) del controllo.
gamma = 3;  % Peso per portare a zero lo stato.
eta = 2.26; % Peso per portare a zero il controllo.
Q = q * ([1 -1 0; -1 1 0; 0 0 0] + gamma * eye(size(X0,1)));
Qf = Q;
R = r * ([16 0 -4 0 0; 0 0 0 0 0; -4 0 1 0 0; 0 0 0 1 -2; 0 0 0 -2 4] + eta * eye(size(B,2)));


% CALCOLO DI Kp
[Kp, ~] = lqrfinite(A, B, Q, Qf, R, T);


% FILTRO DI KALMAN
% Si ottiene lo stato stimato, il controllo ottimo, e lo stato reale.
[X_star, U_star, x] = mykalmanfilter(A, B, C, Kp, X0, sigmaX, sigmaV, sigmaW, T, W, V);


% PLOT DELLA SIMULAZIONE
% Prima figura: stato stimato, stato reale, controllo ottimo.
% Seconda figura: confronto fra le componenti dello stato stimato e quelle 
% dello stato reale.
figure(1);
subplot(3, 1, 1);
plot(interval, X_star);
title('Stato stimato');
legend('x1', 'x2', 'x3');
subplot(3,1,2);
plot(interval, x);
title('Stato reale');
legend('x1', 'x2', 'x3');
subplot (3, 1, 3);
U_star(:,T) = [0 0 0 0 0];
plot(interval, U_star);
title('Controlli');
legend('u1', 'u2', 'u3', 'u4', 'u5');
figure(2)
subplot(3, 1, 1);
plot(interval, X_star(1,:), interval, x(1,:));
title('Componente 1');
legend('x1 star','x1');
subplot(3, 1, 2);
plot(interval, X_star(2,:), interval, x(2,:));
title('Componente 2');
legend('x2 star','x2');
subplot(3, 1, 3);
plot(interval, X_star(3,:), interval, x(3,:));
title('Componente 3');
legend('x3 star','x3');
