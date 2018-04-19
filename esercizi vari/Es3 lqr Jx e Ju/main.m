%Reset del workspace:
clc;
clear;

%Dati di sampling:
sample_time=1;
horizon=4;

A=[0 1; -0.5 1];

B=[0 1]';
C=eye(2);
D=zeros(2, 1);

sistema=ss(A,B,C,D,sample_time);
T=0:sample_time:horizon;

%Stato iniziale:
x0=[1 1]';

%Y libera del sistema U=0;
U=zeros(1,length(T));

% Simulare:
[Y, intervallo, ~] = lsim(sistema,U,T,x0);   

%Stampo il grafico:
subplot (3,1,1);
plot(intervallo,Y)
axis('tight');
title('Risposta libera')

%-------------------------------------------------------------------------%

%Evoluzione in anello chiuso, con controllo ottimo LQR:
Q = 0.5*eye(2);
Qf = 1*Q;
%Poi far variare r fra 0<r<inf:
R=1;
ro = 0.1:0.1:15.1;

[Kd,S,e] = lqrd(A,B,Q,R, sample_time);

%Simulo il nuovo sistema:
sys_closed_infinite_horizon=ss(A-B*Kd,B,C,0,sample_time);
U=zeros(1,length(T));
[Y, intervallo, X] = lsim(sys_closed_infinite_horizon,U,T,x0);   % simulate

%Stampo la simulazione
subplot (3,1,2);
plot(intervallo,Y)
axis('tight');
title('LQR - Infinite')

%-------------------------------------------------------------------------%

%Plot della funzione Ju in funzione di Jx:
Jx = zeros(length(ro),1);

Ju = zeros(length(ro),1);

for i = 1:1:length(ro)
   [Jx(i,1), Ju(i,1)] = calcoloJ(horizon, x0, A, B, C, T, Q, sample_time, ro(1,i));
end

subplot(3,1,3);
plot(ro, Jx./Ju);
title('Rapporto fra Jx e Ju');