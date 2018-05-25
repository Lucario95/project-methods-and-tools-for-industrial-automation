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
  

% SUDDIVISIONE DELLA LISTA DEI JOB NON SCHEDULATI:
  
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


% APPLICAZIONE ALGORITMO DI JOHNSON PER LE COPPIE (M1, M3) E (M2, M4):

% Johnson per le macchine M1 e M3:

i = 1; 
j = 5;
i11 = 1;
i13 = 1;
% Ordine di scheduling:
scheduled_jobs1 = zeros(1, 5);

P1 = P(unscheduled_jobs1,[1, 2, 4]);
[~, order] = sort(P1(:, 2));
% Sottomatrice di P ordinata rispetto ai tempi di processo per la macchina
% M1:
P11 = P1(order, :);                 
[~, order] = sort(P1(:, 3));
% Sottomatrice di P ordinata rispetto ai tempi di processo per la macchina
% M3:
P13 = P1(order, :);                 


% Riempiamo la lista degli scheduled jobs:
while i <= 5 && j >= 1 && any(scheduled_jobs1(:, :) == 0)                 

    if P11(i11, 2) >= P13(i13, 3)
        if ~any(scheduled_jobs1(:, :) == P13(i13, 1))
            scheduled_jobs1(1, j) = P13(i13, 1);
            j = j - 1;
        end
        i13 = i13 + 1;
    else
        if ~any(scheduled_jobs1(:, :) == P11(i11, 1))
            scheduled_jobs1(1, i) = P11(i11, 1);
            i = i + 1;
        end
        i11 = i11 + 1;
    end
    
end


% Johnson per le macchine M2 e M4:

i = 1; 
j = 5;
i22 = 1;
i24 = 1;
scheduled_jobs2 = zeros(1, 5);

P2 = P(unscheduled_jobs2,[1, 3, 5]);   
[~, order] = sort(P2(:, 2));
P22 = P2(order, :);                 
[~, order] = sort(P1(:, 3));
P24 = P2(order, :);                 


% Riempiamo la lista degli scheduled jobs:
while i <= 5 && j >= 1 && any(scheduled_jobs2(:, :) == 0) 

    if P22(i22, 2) >= P24(i24, 3)
        if ~any(scheduled_jobs2(:, :) == P24(i24, 1))
            scheduled_jobs2(1, j) = P24(i24, 1);
            j = j - 1;
        end
        i24 = i24 + 1;
    else
        if ~any(scheduled_jobs2(:, :) == P22(i22, 1))
            scheduled_jobs2(1, i) = P22(i22, 1);
            i = i + 1;
        end
        i22 = i22 + 1;
    end
    
end


% Matrice dei tempi di inizio e di fine esecuzione alla macchina M5: la 
% prima colonna contiene gli id dei job, la seconda colonna contiene i 
% tempi di inizio alla macchina M5, e la terza colonna contiene
% i tempi di completamento alla macchina M5.
CT1 = zeros(5, 3);
i = 1;
t = 0;                                                                      % Tempo di inizio del job i alla macchina M1.
while i <= 5
    id = scheduled_jobs1(1, i);
    p1 = P(id, 2);                                                          % Tempo di processo alla macchina M1.
    p3 = P(id, 4);                                                          % Tempo di processo alla macchina M3.
    p5 = P(id, 6);                                                          % Tempo di processo alla macchina M5.
    CT1(i, 1) = id;
    CT1(i, 2) = p1 + p3 + t;
    t = p1 + t;                                                             % Indica il tempo di inizio alla macchina M1 per il prossimo job.
    i = i + 1;
end

i = 1;
while i <= 5
    id = scheduled_jobs1(1, i);
    p5 = P(id, 6);      
    CT1(i, 3) = CT1(i, 2) + p5;
    i = i + 1;
end


CT2 = zeros(5, 3);
i = 1;
t = 0; 
while i <= 5
    id = scheduled_jobs2(1, i);
    p2 = P(id, 3);      
    p4 = P(id, 5);      
    p5 = P(id, 6);      
    CT2(i, 1) = id;
    CT2(i, 2) = p2 + p3 + t;
    t = p2 + t; 
    i = i + 1;
end

i = 1;
while i <= 5
    id = scheduled_jobs2(1, i);
    p5 = P(id, 6);      
    CT2(i, 3) = CT2(i, 2) + p5;
    i = i + 1;
end


% Controlliamo se ci siano conflitti tra i job della prima lista e i job
% della seconda lista, nella macchina M5:
i = 1;
while i <= 5

    % Controlliamo se gli intervalli di esecuzione sulla macchina M5 si
    % sovrappongono, o meno:
    
    % Sovrapposizione di un job della seconda lista con un job della prima
    % lista ancora in esecuzione nella macchina M5:
    if CT2(i, 2) > CT1(i, 2) && CT2(i, 2) < CT1(i, 3)
        % Introduciamo un ritardo pari al tempo per cui si sovrappongono:
        j = i;
        while j <= 5
            delay = CT1(i, 3) - CT2(i, 2);
            CT2(j, 2:3) = CT2(j, 2:3) + delay; 
        end
    elseif CT1(i, 2) > CT2(i, 2) && CT1(i, 2) < CT2(i, 3)        
        j = i;
        while j <= 5
            delay = CT2(i, 3) - CT1(i, 2);
            CT1(j, 2:3) = CT1(j, 2:3) + delay; 
        end     
    end
    
    i = i + 1;
    
end


% Stampiamo l'ordine di scheduling:
scheduled_jobs1
scheduled_jobs2