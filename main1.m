%PARTE 1 PROGETTO MTFIA

%Reset del workspace:
clc;
clear;

%Definizione e istanziazione delle variabili del sistema:
%X è un vettore 3x1 rappresenta quantità giornaliera di prodotto
%U è un vettore 5x1 rappresenta la quantità di materiali in ingresso e
    %prodotti in uscita da un centro di produzione:
%alfa è la frequenza con cui entrano/escono questi prodotti ( B matrice 3x5 )
%E' richiesto che U(3,:) = 4 * U(1,:);
%                   U(4,:) = 2 * U(5,:);
%                   X(2,:) ~ X(1,:);
%Esprimiamo questi 3 vincoli come costo aggiuntivo da minimizzare nelle
%equazioni di Riccati, tramite la differenza X-Z (dove Z esprimerà il
%vincolo 3)
%e la differenza U-S (dove S esprimerà i vincoli 1 e 2)
%Definizione intervalli di tempo:
%Istante 0 corrisponde all'indice 1
%L'istante finale corrisponde all'indice horizon ( 7 )

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

%Controllo autovalori:
if getstability(A)
    disp('Il sistema in ciclo aperto è stabile');
else
    disp('Il sistema in ciclo aperto è instabile!');
end

%Y libera del sistema U=0;
U=zeros(size(B,2),T);

% Simulare:
sys = ss(A,B,C,D);
[Y, intervallo, ~] = lsim(sys,U',interval,X0);   

%Stampo il grafico:
subplot (3,1,1);
plot(intervallo,Y)
axis('tight');
title('Risposta libera')


%Punto 1)

%Definizione parametri per le matrici dei costi:
alfa = 1;
beta = 1;
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

R = r*([16 0 -4 0 0; 0 alfa 0 0 0; -4 0 1 0 0; 0 0 0 1 -2; 0 0 0 -2 4] + eta*eye(5));

%Ottengo il valore di Kp:
[K ,P] = lqrfinite(A, B, Q, Qf, R, T);

%Simulo il sistema con il controllo ottimo:
X = zeros(size(X0,1), T+1);
U = zeros(size(B,2), T);
Y = zeros(size(C,1), T);
X(:,1) = X0;
U(:,1) = K(:,:,1)*X0;
for k = 1:T
    U(:,k) = K(:,:,k)*X(:,k);
    X(:,k+1) = A*X(:,k) + B*U(:,k);
    Y(:,k) = C*X(:,k);
end

%Plot della simulazione:
subplot (3,1,2);
plot(interval,Y);
title('CONTROLLO STATO LQR');
legend('x1','x2','x3');

%Plot del controllo:
subplot (3,1,3);
plot(interval,U);
title('CONTROLLI LQR');
legend('u1','u2','u3', 'u4', 'u5');
