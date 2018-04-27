%PARTE 2 PROGETTO MTFIA

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
C = [1 0 -1; 0 -1 1];
D = zeros(3,5);

%Media della distribuzione di x nell'istante t = 0:
X0 = [100, 70, 20]';

%Punto 2)
%     Non è possibile misurare x2(t): la misura dello stato è affetta da rumore a media
%     nulla con distribuzione normale e varianza nota (v(t)).
%     Il modello è affetto da un rumore a media nulla con distribuzione
%     normale e varianza nota (w(t))


%Definizione dei rumori:

%Media:
mu = 0;
MUv = mu*ones(size(C,1),T);
MUw = mu*ones(size(X0,1),T);

%Varianze:
sigmaW = 2*eye(3);
sigmaV = 1.5*eye(2);
%Varianza della distribuzione di x all'istante t = 0:
sigmaX = 1*eye(3);

%Inizializzo un generatore di numeri casuali:
rng(0, 'twister');
randValuesW = randn(size(X0,1),1,T);
rng(1, 'twister');
randValuesV = randn(size(C,1),1,T);

W = zeros(size(X0,1),1,T);
V = zeros(size(C,1),1,T);
%Ottengo le matrici W e V:
for i = 1:T
W(:,:,i) = sigmaW*randValuesW(:,:,i) + MUw(:,i);
V(:,:,i) = sigmaV*randValuesV(:,:,i) + MUv(:,i);
end

%Definizione parametri per le matrici dei costi:
gamma = 3; %Quanto vogliamo il riferimento a 0 degli stati
eta = 2.26; %Per rendere la matrice R semidefinita positiva
q = 1; %Quanto 'costa' lo stato
r = 1; %Quanto 'costa' il controllo

%Definizione matrici costi quadratici:
Q = eye(3);
Q(2,1) = -1;
Q(1,2) = -1;
Q(3,3) = 0;
Q = q*(Q + gamma*eye(3));
Qf = Q;

R = [16 0 -4 0 0; 0 0 0 0 0; -4 0 1 0 0; 0 0 0 1 -2; 0 0 0 -2 4];
R = r*(R + eta*eye(5));

[Kp, ~] = lqrfinite(A, B, Q, Qf, R, T);

[X_star, U_star, Y_star, x] = mykalmanfilter(A, B, C, Kp, X0, sigmaX, sigmaV, sigmaW, T, W, V);

%Plot della simulazione:
figure(1);
subplot (3,1,1);
plot(interval,X_star);
title('CONTROLLO STATO STIMATO');
legend('x1','x2','x3');


subplot (3,1,2);
plot(interval, x);
title('CONTROLLO STATO REALE');
legend('x1','x2','x3');

subplot (3,1,3);
U_star(:,T) = [0 0 0 0 0];
plot(interval,U_star);
title('INGRESSI');
legend('u1','u2','u3', 'u4', 'u5');

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