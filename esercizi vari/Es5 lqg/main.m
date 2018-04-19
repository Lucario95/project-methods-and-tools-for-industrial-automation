%Reset del workspace:
clc;
clear;

%Stato iniziale:
x0=[10 2 5]';

%Dati di sampling:
sample_time=1;
horizon=10;

A=[1 0 0; 0.5 1 0; 1 1 -1];
B=[1 0; 0 1; 1 0];
C=eye(3);
D=zeros(3, 2);
mu = 0.5*ones(3,1);
sigma = 1;
% eps = normrnd(mu,sigma,size(x0,1),size(x0,2));
%
% eta = normrnd(mu,0.6*sigma,size(C,1),1);
big_eps = 0.8*eye(size(A,1));
Qn = 0.5*eye(size(A,1));
Rn = 0.2*eye(size(C,1));

sys=ss(A,B,C,D,sample_time);

T=0:sample_time:horizon;


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
[Y, intervallo, ~] = lsim(sys,U,T,x0);   

%Stampo il grafico:
subplot (2,1,1);
plot(intervallo,Y)
axis('tight');
title('Risposta libera')

%-------------------------------------------------------------------------%

%Per il controllo LQG:
q = 1;
r = 1;
Q = q * eye(size(x0,1));
Qf = Q;
R = r * eye(size(B,2));
[P, Kp, x_star, u_star] = MyLQG(A, B, C, D, Q, R, Qf, T, big_eps, Qn, Rn, mu, big_eps, x0);

y_star = C*x_star; %+ eta;
%Plot del sistema:
subplot (2,1,2);
plot(intervallo,x_star,intervallo, y_star);
axis('tight');
title('controllo in ciclo chiuso LQG')