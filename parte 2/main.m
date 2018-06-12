clc;
clear;


% Matrice dei tempi di processo: la prima colonna contiene gli id dei job,
% le colonne i successive indicano i tempi di processo sulle macchine 
% i - 1.
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
% Matrice P con righe ordinate rispetto ai tempi di processo per la
% macchina M1:
P1 = P(order, :);

[~, order] = sort(P(:, 3));
% Matrice P con righe ordinate rispetto ai tempi di processo per la
% macchina M2:
P2 = P(order, :);

% Indici per le liste degli unscheduled jobs:
i1 = 1; 
i2 = 1;
% Indici per le righe delle matrici P1 e P2:
j1 = 1; 
j2 = 1;

% Per ogni macchina inseriamo nella lista (dei job non schedulati)
% corrispondente il job che costa meno:
while (i1 <= 5 && j1 <= 10) || (i2 <= 5 && j2 <= 10)
   
    if (i1 <= 5 && j1 <= 10) && ~any(unscheduled_jobs2(:, :) == P1(j1, 1))
        unscheduled_jobs1(1, i1) = P1(j1, 1);
        i1 = i1 + 1;
    end
    if (i2 <= 5 && j2 <= 10) && ~any(unscheduled_jobs1(:, :) == P2(j2, 1))
        unscheduled_jobs2(1, i2) = P2(j2, 1);
        i2 = i2 + 1;
    end
    
    j1 = j1 + 1;
    j2 = j2 + 1;
    
end

scheduled_jobsM13 = johnson(P(unscheduled_jobs1(:), [1 2]), P(unscheduled_jobs1(:), [1 4]));
scheduled_jobsM24 = johnson(P(unscheduled_jobs2, [1 3]), P(unscheduled_jobs2, [1 5]));

schedule_timesM13 = runjobs(P(scheduled_jobsM13(:), [1 2 4 6]));
schedule_timesM24 = runjobs(P(scheduled_jobsM24(:), [1 3 5 6]));

schedule_timesM5 = checkcollisions(schedule_timesM13(:, [1 5 6]), schedule_timesM24(:, [1 5 6]))


