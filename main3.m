%PARTE 3 PROGETTO MTFIA

%Reset del workspace:
clc;
clear;

sample_time = 1; %giorno
horizon = 7;     %giorni
interval = 1:sample_time:horizon;
T = length(interval);

%Definizione matrici A,B,C,D:
A = eye(3); 
B = [2 0 -1 0 0; 0 1 0 -2 0; 0 0 1 3 -1]; %alfa
C = eye(3);
D = zeros(3,5);

%Definizione stato iniziale X0:
X0 = [100, 70, -45]';

%Punto 3)
%     Sotto le ipotesi del punto 1) (stato osservaile ed orizzonte di 7 giorni)
%     si vuole minimizzare il costo dello stato e del controllo rispettando
%     i vincoli:  x1(3) = 10
%                 x1(4) = 10
%                 x2(t) = -10 per ogni t
%                 x3(5) = 0

%Definizione parametri per le matrici dei costi:
alfa = 1;
beta = 1;
gamma = 3; %Quanto vogliamo il riferimento a 0 degli stati
eta = 2.26; %Per rendere la matrice R semidefinita positiva
q = 7; %Quanto 'costa' lo stato
r = 1; %Quanto 'costa' il controllo

%Definizione matrici costi quadratici:
Q = eye(3);
Q(2,1) = -1;
Q(1,2) = -1;
Q(3,3) = 0;
Q = q*(Q + gamma*eye(3));
Qf = Q;

R = r*([16 0 -4 0 0; 0 alfa 0 0 0; -4 0 1 0 0; 0 0 0 1 -2; 0 0 0 -2 4] + eta*eye(5));

%Definizione matrice del tracking:
Z = zeros(size(X0,1),T);
Z(2,:) = -10;
Z(1,3:4) = 10;
Z(3,5) = 0;

%Ottengo il valore di Kp:
[Kp ,Ki, g] = mylqt(A, B, C, Q, Qf, R, T, Z, X0);

%Simulo il sistema con il controllo ottimo:
X = zeros(size(X0,1), T+1);
U = zeros(size(B,2), T);
Y = zeros(size(C,1), T);
X(:,1) = X0;

for k = 1:T-1
    U(:,k) = -Kp(:,:,k)*X(:,k) + Ki(:,:,k)*g(:,k+1);
    X(:,k+1) = A*X(:,k) + B*U(:,k);
    Y(:,k) = C*X(:,k);
end

%Plot della simulazione:
subplot (2,1,1);
plot(interval,Y, interval, Z);
title('CONTROLLO STATO LQR');
legend('x1','x2','x3','z1','z2','z3');

%Plot del controllo:
subplot (2,1,2);
plot(interval,U);
title('CONTROLLI LQR');
legend('u1','u2','u3', 'u4', 'u5');
