%Reset del workspace:
clc;
clear;

%Dati di sampling:
sample_time=0.25;
horizon=20;

A=[0.8 0 0; -0.5 1 0; 0 -1 2];
B=[1 0; 0 1; 1 0];
C=eye(3);
D=zeros(3, 2);

sistema=ss(A,B,C,D,sample_time);
T=0:sample_time:horizon;

%Stato iniziale:
x0=[1 1 5]';

%-------------------------------------------------------------------------%

%Controllo autovalori:
if isStable(A)
    disp('Il sistema in ciclo aperto è stabile');
else
    disp('Il sistema in ciclo aperto è instabile!');
end
%-------------------------------------------------------------------------%

%Y libera del sistema U=0;
U=zeros(2,length(T));

% Simulare:
[Y, intervallo, ~] = lsim(sistema,U,T,x0);   

%Stampo il grafico:
subplot (2,1,1);
plot(intervallo,Y)
axis('tight');
title('Risposta libera')

%-------------------------------------------------------------------------%

%Setto le variabili per il controllo LQT:
Z = zeros(3,length(intervallo));
for k = 1:length(intervallo)
    Z(:,k) = [10;1;k];

end

Q = 100*eye(3);
R = eye(2);
Qf = Q;

%Controllo ottimo LQT:
[X_star, U_star, L, Lg, g] = Mylqt(A, B, C, Z, Q, Qf, R, T, x0);

%Plot del sistema:
subplot (2,1,2);
plot(intervallo,X_star,intervallo, Z)
axis('tight');
title('controllo in ciclo chiuso LQT')