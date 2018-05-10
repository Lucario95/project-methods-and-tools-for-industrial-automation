%PARTE 1 PROGETTO MTFIA

clc;
clear;


% DESCRIZIONE
% X indica la quantità di prodotto nell'inventario di ogni centro di
% produzione (3 componenti).
% U indica le quantità di prodotto in uscita o le quantità di materiale 
% grezzo in ingresso (5 componenti).

% Si richiede: 
% U(3,:) ~ 4 * U(1,:)
% U(4,:) ~ 2 * U(5,:)
% X(2,:) ~ X(1,:)

% Si assume che lo stato sia perfettamente osservabile. Si vuole definire
% il controllo ottimo in modo da minimizzare l'errore quadratico dello
% stato e del controllo rispetto a zero, con time horizon di 7 giorni.


% DEFINIZIONE PARAMETRI
% Assumiamo tempo di campionamento di un giorno e time horizon di 7 giorni.
% Note:
% - l'istante 0 corrisponde all'indice 1;
% - l'istante finale corrisponde all'indice T.
sample_time = 1;
horizon = 7;
interval = 1:sample_time:horizon;
T = length(interval);                                                      

% Definizione delle matrici A, B, C, D:
A = eye(3); 
B = [2 0 -1 0 0; 0 1 0 -2 0; 0 0 1 3 -1];
C = eye(3);
D = zeros(3,5);

% Definizione dello stato iniziale:
X0 = [100, 70, -45]';


% SIMULAZIONE RISPOSTA LIBERA
% Ingresso nullo:
U = zeros(size(B,2), T);
% Modello del sistema a tempo continuo:
sys = ss(A, B, C, D);
% Simulazione del sistema a tempo discreto:
Y = lsim(sys, U', interval, X0);   
% Plot della risposta libera:
subplot(3, 1, 1);
plot(interval, Y)
axis('tight');
title('Risposta libera')
legend('x1', 'x2', 'x3');


% DEFINIZIONE MATRICI Q E R
q = 2;      % Definisce il peso (costo) dello stato.
r = 1;      % Definisce il peso (costo) del controllo.
gamma = 1;  % Peso per portare a zero lo stato.
eta = 1;    % Peso per portare a zero il controllo.
Q = q * ([1 -1 0; -1 1 0; 0 0 0] + gamma * eye(size(X0,1)));
Qf = Q;
R = r * ([16 0 -4 0 0; 0 0 0 0 0; -4 0 1 0 0; 0 0 0 1 -2; 0 0 0 -2 4] + eta * eye(size(B,2)));


% CALCOLO DI Kp
% Ottengo il valore di Kp:
[K ,P] = lqrfinite(A, B, Q, Qf, R, T);


% SIMULAZIONE SISTEMA CON CONTROLLO OTTIMO
X = zeros(size(X0,1), T+1);
U = zeros(size(B,2), T);
Y = zeros(size(C,1), T);
X(:,1) = X0;
for k = 1:T
    % Calcolo del controllo ottimo:
    U(:,k) = K(:,:,k) * X(:,k);
    % Calcolo dello stato successivo:
    X(:,k+1) = A * X(:,k) + B * U(:,k);
    Y(:,k) = C * X(:,k);
end
% Plot dello stato controllato:
subplot (3, 1, 2);
plot(interval, Y);
title('Stato con LQR');
legend('x1', 'x2', 'x3');
% Plot dei controlli:
subplot(3, 1, 3);
plot(interval, U);
title('Controlli');
legend('u1', 'u2', 'u3', 'u4', 'u5');
