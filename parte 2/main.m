clc;
clear;


P = [ 1 : 10;
      5 3 6 8 4 12 12 5 3 2 ;
      12 6 1 5 6 15 3 2 8 8;
      1 20 2 5 7 11 12 2 5 4;
      13 10 1 15 6 12 11 4 4 13;
      2 6 2 1 5 13 2 7 18 3]';
  
% Liste dei job non ancora schedulati per la macchina M1 e la macchina M2:
unscheduled_jobs1 = zeros(1, 5);
unscheduled_jobs2 = zeros(1, 5);

[~, order] = sort(P(:, 2));
% Matrice P con righe oridinate rispetto ai tempi di processo per la
% macchina M1:
P1 = P(order, :);

[~, order] = sort(P(:, 3));
% Matrice P con righe oridinate rispetto ai tempi di processo per la
% macchina M1:
P2 = P(order, :);

% Indici per le liste degli unscheduled jobs:
i1 = 0; 
i2 = 0;
% Indici per le righe delle matrici P1 e P2:
j1 = 0; 
j2 = 0;

% TODO: ciclare su le liste degli unsch jobs e sulle righe di P1 e P2 per
% predere mano a mano quello che costa di meno per prima M1 e poi M2.
% Controllare che iil job preso non sia nella lista per l'altra macchina.
while i1 < 5 && i2 < 5 && j1 < 10 && j2 < 10
   
    if any(unscheduled_job2(:, :) == P1(j1, 1))
    
    end
    
end

