clear;
clc;

%Valori parametrici per sistema_nastro_trasportatore:
T = 0.1;
x0 = 10;
tau = 0.6;
%Densità
ro = 100; %kg/m^3
%Area
area = 15;
r = 0.5;

Y_MAX = 10;
%Guadagno uscita
Km = 1/Y_MAX;
%Guadagno ingresso raw
Ks = 750;

%Matrici sistema:
A = ro*area;
B = Ks/A;
C = 1;
D = 0;